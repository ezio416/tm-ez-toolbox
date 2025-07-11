// c 2025-04-08
// m 2025-07-10

/*
This module is for getting the current configuration file. This is helpful because
the plugin author can update this file at any time without the need for a full plugin
update in the case something breaks or needs to be changed for another reason.
*/

namespace Config {
    Json::Value@ config;
    const string url = "https://openplanet.dev/plugin/eztoolbox/config/cfg";

    void Request() {
        startnew(RequestAsync);
    }

    void RequestAsync() {
        const uint64 start = Time::Now;
        trace("getting config from openplanet.dev");

        while (true) {
            Net::HttpRequest@ req = EzHttp::GetAsync(url);

            try {
                @config = req.Json();

                if (config.GetType() == Json::Type::Object and !config.HasKey("error")) {
                    trace("got config after " + (Time::Now - start) + "ms: " + Json::Write(config));
                    return;
                }

                @config = null;

            } catch { }

            warn("failed to get config from openplanet.dev after " + (Time::Now - start) + "ms");
            sleep(3000);
        }
    }
}
