// c 2025-07-13
// m 2025-07-13

/*
Makes HTTP requests.
*/
namespace EzHttp {
    shared Net::HttpRequest@ GetAsync(const string&in url, bool start = true, const string&in agent = "") {
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

    shared Net::HttpRequest@ PostAsync(const string&in url, const string&in body = "", bool start = true, const string&in agent = "") {
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
}
