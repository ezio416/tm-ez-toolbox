// c 2025-03-06
// m 2025-03-09

/*
A library for Ezio's plugins.
*/
namespace Ez { }

namespace Ez::EzGame {
    import CTrackMania@                         get_App()              from "Ez";
    import CGameCtnEditorFree@                  get_Editor()           from "Ez";
    import string                               get_GameMode()         from "Ez";
    import CTrackManiaNetwork@                  get_Network()          from "Ez";
    import CGameCtnChallenge@                   get_RootMap()          from "Ez";
    import CGamePlaygroundUIConfig::EUISequence get_Sequence()         from "Ez";
    import CTrackManiaNetworkServerInfo@        get_ServerInfo()       from "Ez";
    import CDx11Viewport@                       get_Viewport()         from "Ez";
#if TMNEXT
    import string                               get_ExeVersion()       from "Ez";
    import CSmArenaClient@                      get_Playground()       from "Ez";
    import CSmArenaRulesMode@                   get_PlaygroundScript() from "Ez";
#elif MP4
    import CGamePlayground@                     get_Playground()       from "Ez";
    import CTrackManiaRaceRules@                get_PlaygroundScript() from "Ez";
#elif TURBO
    import CGamePlayground@                     get_Playground()       from "Ez";
    import CTrackManiaRaceRules@                get_PlaygroundScript() from "Ez";
#endif

    import bool PlayMapAsync(const string &in uid) from "Ez";
}

namespace Ez::EzHttp {
    import Net::HttpRequest@ GetAsync(const string &in url, bool start = true, const string &in agent = "")                              from "Ez";
    import Net::HttpRequest@ PostAsync(const string &in url, const string &in body = "", bool start = true, const string &in agent = "") from "Ez";
    import Net::HttpRequest@ PostAsync(const string &in url, Json::Value@ body = null, bool start = true, const string &in agent = "")   from "Ez";
}

#if TMNEXT
namespace Ez::EzHttp::Nadeo {
    import bool get_requesting() from "Ez";

    import Net::HttpRequest@ GetAsync(const string &in audience, const string &in url, bool start = true)                              from "Ez";
    import Net::HttpRequest@ GetCoreAsync(const string &in endpoint, bool start = true)                                                from "Ez";
    import Net::HttpRequest@ GetLiveAsync(const string &in endpoint, bool start = true)                                                from "Ez";
    import Net::HttpRequest@ GetMeetAsync(const string &in endpoint, bool start = true)                                                from "Ez";
    import Net::HttpRequest@ PostAsync(const string &in audience, const string &in url, const string &in body = "", bool start = true) from "Ez";
    import Net::HttpRequest@ PostAsync(const string &in audience, const string &in url, Json::Value@ body = null, bool start = true)   from "Ez";
    import Net::HttpRequest@ PostCoreAsync(const string &in endpoint, const string &in body = "", bool start = true)                   from "Ez";
    import Net::HttpRequest@ PostCoreAsync(const string &in endpoint, Json::Value@ body = null, bool start = true)                     from "Ez";
    import Net::HttpRequest@ PostLiveAsync(const string &in endpoint, const string &in body = "", bool start = true)                   from "Ez";
    import Net::HttpRequest@ PostLiveAsync(const string &in endpoint, Json::Value@ body = null, bool start = true)                     from "Ez";
    import Net::HttpRequest@ PostMeetAsync(const string &in endpoint, const string &in body = "", bool start = true)                   from "Ez";
    import Net::HttpRequest@ PostMeetAsync(const string &in endpoint, Json::Value@ body = null, bool start = true)                     from "Ez";
    import void              WaitAsync()                                                                                               from "Ez";
}
#endif

namespace Ez::EzMeta {
    import bool Enabled() from "Ez";
}

/*
Various utilities.
*/
namespace Ez::EzUtil {
    /*
    Test function for exports.
    */
    import void HelloWorld() from "Ez";
}
