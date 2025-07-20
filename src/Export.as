// c 2025-07-09
// m 2025-07-20

/*
Allows plugins to register callback functions that will be called under certain conditions.
*/
namespace EzCallback {
    import void Deregister()          from "EzToolbox";
    import void Register(Callback@ c) from "EzToolbox";
}

#if DEPENDENCY_NADEOSERVICES
/*
Makes HTTP requests.
*/
namespace EzHttp {
    /*
    Makes requests to Nadeo's Web Services.
    */
    namespace Nadeo {
        import uint64            get_lastRequestTime()                                                                 from "EzToolbox";
        import bool              get_requesting()                                                                      from "EzToolbox";
        import uint64            get_waitTime()                                                                        from "EzToolbox";
        import void              set_waitTime(uint64 ms)                                                               from "EzToolbox";

        import Net::HttpRequest@ GetCoreAsync(const string&in endpoint, bool start = true)                             from "EzToolbox";
        import Net::HttpRequest@ GetLiveAsync(const string&in endpoint, bool start = true)                             from "EzToolbox";
        import Net::HttpRequest@ GetMeetAsync(const string&in endpoint, bool start = true)                             from "EzToolbox";
        import Net::HttpRequest@ PostCoreAsync(const string&in endpoint, const string&in body = "", bool start = true) from "EzToolbox";
        import Net::HttpRequest@ PostLiveAsync(const string&in endpoint, const string&in body = "", bool start = true) from "EzToolbox";
        import Net::HttpRequest@ PostMeetAsync(const string&in endpoint, const string&in body = "", bool start = true) from "EzToolbox";
    }
}
#endif

#if TMNEXT
/*
Checks UI layers and caches indices to help performance in dependent plugins.
*/
namespace EzLayers {
    /*
    Gets layers and indices from the menu.
    */
    namespace Menu {
        import int               GetIndex(const string&in layerName) from "EzToolbox";
        import const dictionary@ GetIndices()                        from "EzToolbox";
        import CGameUILayer@     GetLayer(const uint index)          from "EzToolbox";
        import CGameUILayer@     GetLayer(const string&in layerName) from "EzToolbox";
    }

    /*
    Gets layers and indices from the current playground.
    */
    namespace Playground {
        import int               GetIndex(const string&in layerName) from "EzToolbox";
        import const dictionary@ GetIndices()                        from "EzToolbox";
        import CGameUILayer@     GetLayer(const uint index)          from "EzToolbox";
        import CGameUILayer@     GetLayer(const string&in layerName) from "EzToolbox";
    }
}
#endif

/*
Stores information about the game that changes. Although most things in this module are shared,
it is recommended that you do not use them in shared code in case of future plugin updates.
*/
namespace EzState {
    import MapInfo@ get_mapInfo() from "EzToolbox";
}
