// c 2025-07-09
// m 2025-07-13

/*
Allows plugins to register callback functions that will be called under certain conditions.
*/
namespace EzCallback {
    import void Deregister()          from "EzToolbox";
    import void Register(Callback@ c) from "EzToolbox";
}

/*
Uses the Dev:: API.
*/
namespace EzDev {
#if MANIA64
    import uint64 CheckPointer(const uint64 ptr) from "EzToolbox";
    import uint64 GetNodPointer(CMwNod@ nod)     from "EzToolbox";
#else
    import uint CheckPointer(const uint ptr)     from "EzToolbox";
    import uint GetNodPointer(CMwNod@ nod)       from "EzToolbox";
#endif
}

/*
Gets handles to game objects and interacts with the game directly.
*/
namespace EzGame {
    import CTrackManiaNetwork@           get_Network()          from "EzToolbox";
    import CGameCtnChallenge@            get_RootMap()          from "EzToolbox";
    import CTrackManiaNetworkServerInfo@ get_ServerInfo()       from "EzToolbox";
    import CDx11Viewport@                get_Viewport()         from "EzToolbox";
#if TMNEXT
    import CSmArenaClient@               get_Playground()       from "EzToolbox";
    import CSmArenaRulesMode@            get_PlaygroundScript() from "EzToolbox";
#elif MP4 || TURBO
    import CGamePlayground@              get_Playground()       from "EzToolbox";
    import CTrackManiaRaceRules@         get_PlaygroundScript() from "EzToolbox";
#endif

    import void EditMap(const string&in url)      from "EzToolbox";
    import void EditMapAsync(const string&in url) from "EzToolbox";
    import void PlayMap(const string&in url)      from "EzToolbox";
    import void PlayMapAsync(const string&in url) from "EzToolbox";
    import void ReturnToMainMenu()                from "EzToolbox";
}

/*
Makes HTTP requests.
*/
namespace EzHttp {
    import Net::HttpRequest@ GetAsync(const string&in url, bool start = true, const string&in agent = "")                             from "EzToolbox";
    import Net::HttpRequest@ PostAsync(const string&in url, const string&in body = "", bool start = true, const string&in agent = "") from "EzToolbox";

#if DEPENDENCY_NADEOSERVICES
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
#endif
}

/*
Stores information about the game that changes. Very efficient.
*/
namespace EzState {
    import uint                                 get_frameCount()            from "EzToolbox";

    import float                                get_fps()                   from "EzToolbox";
    import string                               get_gameMode()              from "EzToolbox";
    import bool                                 get_hasGuiPlayer()          from "EzToolbox";
    import bool                                 get_hasMenu()               from "EzToolbox";
    import bool                                 get_hasPlaygroundScript()   from "EzToolbox";
    import bool                                 get_inEditor()              from "EzToolbox";
    import bool                                 get_inMap()                 from "EzToolbox";
    import bool                                 get_inPlayground()          from "EzToolbox";
    import bool                                 get_loading()               from "EzToolbox";
    import MapInfo@                             get_mapInfo()               from "EzToolbox";
    import bool                                 get_paused()                from "EzToolbox";
    import int                                  get_ping()                  from "EzToolbox";
    import CGamePlaygroundUIConfig::EUISequence get_sequence()              from "EzToolbox";
    import bool                                 get_viewingControlled()     from "EzToolbox";

    import bool                                 get_driving()               from "EzToolbox";
    import bool                                 get_inMainMenu()            from "EzToolbox";
    import bool                                 get_inMapEditor()           from "EzToolbox";
    import bool                                 get_inMapEditorTesting()    from "EzToolbox";
    import bool                                 get_inReplayEditorEditing() from "EzToolbox";
    import bool                                 get_inReplayEditorViewing() from "EzToolbox";
    import bool                                 get_inSkinEditor()          from "EzToolbox";
    import bool                                 get_playingMap()            from "EzToolbox";
    import bool                                 get_playingMapLocal()       from "EzToolbox";
    import bool                                 get_playingMapOnline()      from "EzToolbox";
    import bool                                 get_spectating()            from "EzToolbox";
    import bool                                 get_viewingReplay()         from "EzToolbox";
}

/*
Stores information about things that do not change.
*/
namespace EzStatic {
#if TMNEXT
    import AccessLevel     get_accessLevel()    from "EzToolbox";
#endif
    import uint8           get_bits()           from "EzToolbox";
    import string          get_exeVersion()     from "EzToolbox";
    import GameType        get_gameType()       from "EzToolbox";
    import OperatingSystem get_os()             from "EzToolbox";
    import MwId            get_playerId()       from "EzToolbox";
    import string          get_playerLogin()    from "EzToolbox";
    import string          get_playerUsername() from "EzToolbox";
    import string          get_playerWsid()     from "EzToolbox";
}
