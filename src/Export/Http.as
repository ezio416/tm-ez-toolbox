// c 2024-01-02
// m 2025-03-07

namespace Ez {  // EzHttp
    Net::HttpRequest@ GetAsync(const string &in url, bool start = true, const string &in agent = "") {
        Net::HttpRequest@ req = Net::HttpRequest();
        req.Method = Net::HttpMethod::Get;
        req.Url = url;
        if (agent.Length > 0)
            req.Headers["User-Agent"] = agent;

        if (start) {
            req.Start();
            while (!req.Finished())
                yield();
        }

        return req;
    }

    Net::HttpRequest@ PostAsync(const string &in url, const string &in body = "", bool start = true, const string &in agent = "") {
        Net::HttpRequest@ req = Net::HttpRequest();
        req.Method = Net::HttpMethod::Post;
        req.Url = url;
        req.Body = body;
        req.Headers["Content-Type"] = "application/json";
        if (agent.Length > 0)
            req.Headers["User-Agent"] = agent;

        if (start) {
            req.Start();
            while (!req.Finished())
                yield();
        }

        return req;
    }

    Net::HttpRequest@ PostAsync(const string &in url, Json::Value@ body = null, bool start = true, const string &in agent = "") {
        return PostAsync(url, Json::Write(body), start, agent);
    }
}

#if TMNEXT
namespace Ez {  // EzHttp::Nadeo
    const string audienceCore          = "NadeoServices";
    const string audienceLive          = "NadeoLiveServices";
    uint64       lastRequestTs         = 0;
    const uint64 waitBetweenRequestsMs = 1000;

    bool _requesting = false;
    bool get_requesting() { return _requesting; }

    Net::HttpRequest@ GetAsync(const string &in audience, const string &in url, bool start = true) {
        NadeoServices::AddAudience(audience);

        while (_requesting || !NadeoServices::IsAuthenticated(audience))
            yield();

        if (start)
            _requesting = true;

        WaitAsync();

        Net::HttpRequest@ req = NadeoServices::Get(audience, url);
        if (start) {
            req.Start();
            while (!req.Finished())
                yield();

            _requesting = false;
        }

        return req;
    }

    Net::HttpRequest@ GetCoreAsync(const string &in endpoint, bool start = true) {
        return GetAsync(audienceCore, NadeoServices::BaseURLCore() + endpoint, start);
    }

    Net::HttpRequest@ GetLiveAsync(const string &in endpoint, bool start = true) {
        return GetAsync(audienceLive, NadeoServices::BaseURLLive() + endpoint, start);
    }

    Net::HttpRequest@ GetMeetAsync(const string &in endpoint, bool start = true) {
        return GetAsync(audienceLive, NadeoServices::BaseURLMeet() + endpoint, start);
    }

    Net::HttpRequest@ PostAsync(const string &in audience, const string &in url, const string &in body = "", bool start = true) {
        NadeoServices::AddAudience(audience);

        while (_requesting || !NadeoServices::IsAuthenticated(audience))
            yield();

        if (start)
            _requesting = true;

        WaitAsync();

        Net::HttpRequest@ req = NadeoServices::Post(audience, url, body);
        if (start) {
            req.Start();
            while (!req.Finished())
                yield();

            _requesting = false;
        }

        return req;
    }

    Net::HttpRequest@ PostAsync(const string &in audience, const string &in url, Json::Value@ body = null, bool start = true) {
        return PostAsync(audience, url, Json::Write(body), start);
    }

    Net::HttpRequest@ PostCoreAsync(const string &in endpoint, const string &in body = "", bool start = true) {
        return PostAsync(audienceCore, NadeoServices::BaseURLCore() + endpoint, body, start);
    }

    Net::HttpRequest@ PostCoreAsync(const string &in endpoint, Json::Value@ body = null, bool start = true) {
        return PostAsync(audienceCore, NadeoServices::BaseURLCore() + endpoint, body, start);
    }

    Net::HttpRequest@ PostLiveAsync(const string &in endpoint, const string &in body = "", bool start = true) {
        return PostAsync(audienceLive, NadeoServices::BaseURLLive() + endpoint, body, start);
    }

    Net::HttpRequest@ PostLiveAsync(const string &in endpoint, Json::Value@ body = null, bool start = true) {
        return PostAsync(audienceLive, NadeoServices::BaseURLLive() + endpoint, body, start);
    }

    Net::HttpRequest@ PostMeetAsync(const string &in endpoint, const string &in body = "", bool start = true) {
        return PostAsync(audienceLive, NadeoServices::BaseURLMeet() + endpoint, body, start);
    }

    Net::HttpRequest@ PostMeetAsync(const string &in endpoint, Json::Value@ body = null, bool start = true) {
        return PostAsync(audienceLive, NadeoServices::BaseURLMeet() + endpoint, body, start);
    }

    void WaitAsync() {
        uint64 now;

        while ((now = Time::Now) - lastRequestTs < waitBetweenRequestsMs)
            yield();

        lastRequestTs = now;
    }
}
#endif
