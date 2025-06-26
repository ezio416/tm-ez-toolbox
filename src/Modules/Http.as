// c 2024-01-02
// m 2025-06-25

/*
This module is for making HTTP requests to arbitrary sites and to Nadeo's Web Services endpoints.
*/

namespace Ez {
    Net::HttpRequest@ GetAsync(const string&in url, bool start = true, const string&in agent = "") {
        Net::HttpRequest@ req = Net::HttpRequest();
        req.Method = Net::HttpMethod::Get;
        req.Url = url;
        if (agent.Length > 0) {
            req.Headers["User-Agent"] = agent;
        }

        if (start) {
            req.Start();
            while (!req.Finished()) {
                yield();
            }
        }

        return req;
    }

    Net::HttpRequest@ PostAsync(const string&in url, const string&in body = "", bool start = true, const string&in agent = "") {
        Net::HttpRequest@ req = Net::HttpRequest();
        req.Method = Net::HttpMethod::Post;
        req.Url = url;
        req.Body = body;
        req.Headers["Content-Type"] = "application/json";
        if (agent.Length > 0) {
            req.Headers["User-Agent"] = agent;
        }

        if (start) {
            req.Start();
            while (!req.Finished()) {
                yield();
            }
        }

        return req;
    }

    Net::HttpRequest@ PostAsync(const string&in url, Json::Value@ body = null, bool start = true, const string&in agent = "") {
        return PostAsync(url, Json::Write(body), start, agent);
    }
}

#if DEPENDENCY_NADEOSERVICES
namespace Ez {
    const string audienceCore    = "NadeoServices";
    const string audienceLive    = "NadeoLiveServices";
    const uint64 waitTimeDefault = 1000;
    const uint64 waitTimeMinimum = 500;

    dictionary@ _lastRequestTime = dictionary();
    uint64 lastRequestTime {
        get {
            Meta::Plugin@ plugin = Meta::ExecutingPlugin();
            return _lastRequestTime.Exists(plugin.ID) ? uint64(_lastRequestTime[plugin.ID]) : 0;
        }

        set {
            Meta::Plugin@ plugin = Meta::ExecutingPlugin();
            _lastRequestTime.Set(plugin.ID, value);
        }
    }

    dictionary@ _requesting = dictionary();
    bool requesting {
        get {
            Meta::Plugin@ plugin = Meta::ExecutingPlugin();
            return _requesting.Exists(plugin.ID);
        }

        set {
            Meta::Plugin@ plugin = Meta::ExecutingPlugin();

            if (value) {
                _requesting.Set(plugin.ID, 1);
            } else {
                _requesting.Delete(plugin.ID);
            }
        }
    }

    dictionary@ _waitTime = dictionary();
    uint64 waitTime {
        get {
            Meta::Plugin@ plugin = Meta::ExecutingPlugin();
            return _waitTime.Exists(plugin.ID) ? uint64(_waitTime[plugin.ID]) : waitTimeDefault;
        }

        set {
            if (value < waitTimeMinimum) {
                error("minimum wait time for Nadeo API is " + waitTimeMinimum + "ms");
                value = waitTimeMinimum;
            }

            Meta::Plugin@ plugin = Meta::ExecutingPlugin();
            _waitTime.Set(plugin.ID, value);
        }
    }

    Net::HttpRequest@ GetAsync(const string&in audience, const string&in url, bool start = true) {
        NadeoServices::AddAudience(audience);

        while (requesting or !NadeoServices::IsAuthenticated(audience)) {
            yield();
        }

        if (start) {
            requesting = true;
        }

        WaitAsync();

        Net::HttpRequest@ req = NadeoServices::Get(audience, url);
        if (start) {
            req.Start();
            while (!req.Finished()) {
                yield();
            }

            requesting = false;
        }

        return req;
    }

    Net::HttpRequest@ GetCoreAsync(const string&in endpoint, bool start = true) {
        return GetAsync(audienceCore, NadeoServices::BaseURLCore() + (endpoint.StartsWith("/") ? "" : "/") + endpoint, start);
    }

    Net::HttpRequest@ GetLiveAsync(const string&in endpoint, bool start = true) {
        return GetAsync(audienceLive, NadeoServices::BaseURLLive() + (endpoint.StartsWith("/") ? "" : "/") + endpoint, start);
    }

    Net::HttpRequest@ GetMeetAsync(const string&in endpoint, bool start = true) {
        return GetAsync(audienceLive, NadeoServices::BaseURLMeet() + (endpoint.StartsWith("/") ? "" : "/") + endpoint, start);
    }

    Net::HttpRequest@ PostAsync(const string&in audience, const string&in url, const string&in body = "", bool start = true) {
        NadeoServices::AddAudience(audience);

        while (requesting || !NadeoServices::IsAuthenticated(audience))
            yield();

        if (start) {
            requesting = true;
        }

        WaitAsync();

        Net::HttpRequest@ req = NadeoServices::Post(audience, url, body);
        if (start) {
            req.Start();
            while (!req.Finished()) {
                yield();
            }

            requesting = false;
        }

        return req;
    }

    Net::HttpRequest@ PostAsync(const string&in audience, const string&in url, Json::Value@ body = null, bool start = true) {
        return PostAsync(audience, url, Json::Write(body), start);
    }

    Net::HttpRequest@ PostCoreAsync(const string&in endpoint, const string&in body = "", bool start = true) {
        return PostAsync(audienceCore, NadeoServices::BaseURLCore() + (endpoint.StartsWith("/") ? "" : "/") + endpoint, body, start);
    }

    Net::HttpRequest@ PostCoreAsync(const string&in endpoint, Json::Value@ body = null, bool start = true) {
        return PostAsync(audienceCore, NadeoServices::BaseURLCore() + (endpoint.StartsWith("/") ? "" : "/") + endpoint, body, start);
    }

    Net::HttpRequest@ PostLiveAsync(const string&in endpoint, const string&in body = "", bool start = true) {
        return PostAsync(audienceLive, NadeoServices::BaseURLLive() + (endpoint.StartsWith("/") ? "" : "/") + endpoint, body, start);
    }

    Net::HttpRequest@ PostLiveAsync(const string&in endpoint, Json::Value@ body = null, bool start = true) {
        return PostAsync(audienceLive, NadeoServices::BaseURLLive() + (endpoint.StartsWith("/") ? "" : "/") + endpoint, body, start);
    }

    Net::HttpRequest@ PostMeetAsync(const string&in endpoint, const string&in body = "", bool start = true) {
        return PostAsync(audienceLive, NadeoServices::BaseURLMeet() + (endpoint.StartsWith("/") ? "" : "/") + endpoint, body, start);
    }

    Net::HttpRequest@ PostMeetAsync(const string&in endpoint, Json::Value@ body = null, bool start = true) {
        return PostAsync(audienceLive, NadeoServices::BaseURLMeet() + (endpoint.StartsWith("/") ? "" : "/") + endpoint, body, start);
    }

    void WaitAsync() {
        uint64 now;

        while ((now = Time::Now) - lastRequestTime < waitTime) {
            yield();
        }

        lastRequestTime = now;
    }
}
#endif
