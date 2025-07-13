// c 2025-07-09
// m 2025-07-13

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
