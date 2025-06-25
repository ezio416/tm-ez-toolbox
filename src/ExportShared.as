// c 2025-03-29
// m 2025-06-24

const uint   MAX_UINT   = uint(-1);
const uint64 MAX_UINT64 = uint64(-1);

namespace Ez2 {
    shared funcdef void CallbackFunc();
}

namespace Ez2::State {
    import uint64                               get_frameCount()          from "Ez2";

    import bool                                 get_editor()              from "Ez2";
    import float                                get_fps()                 from "Ez2";
    import string                               get_gameMode()            from "Ez2";
    import bool                                 get_guiPlayer()           from "Ez2";
    import bool                                 get_map()                 from "Ez2";
    import MapInfo@                             get_mapInfo()             from "Ez2";
    import bool                                 get_menu()                from "Ez2";
    import bool                                 get_loading()             from "Ez2";
    import bool                                 get_paused()              from "Ez2";
    import int                                  get_ping()                from "Ez2";
    import bool                                 get_playground()          from "Ez2";
    import bool                                 get_playgroundScript()    from "Ez2";
    import CGamePlaygroundUIConfig::EUISequence get_sequence()            from "Ez2";
    import bool                                 get_viewingControlled()   from "Ez2";

    import bool                                 get_driving()             from "Ez2";
    import bool                                 get_mainMenu()            from "Ez2";
    import bool                                 get_mapEditor()           from "Ez2";
    import bool                                 get_mapEditorTesting()    from "Ez2";
    import bool                                 get_playingMap()          from "Ez2";
    import bool                                 get_playingMapLocal()     from "Ez2";
    import bool                                 get_playingMapOnline()    from "Ez2";
    import bool                                 get_replayEditorEditing() from "Ez2";
    import bool                                 get_replayEditorViewing() from "Ez2";
    import bool                                 get_skinEditor()          from "Ez2";
    import bool                                 get_spectating()          from "Ez2";
    import bool                                 get_viewingReplay()       from "Ez2";

    /*
    stores information on the current map
    if you keep a handle to this around, call `.Update()` every frame
    */
    shared class MapInfo {
        private uint _authorTime = MAX_UINT;
        uint get_authorTime() final {
            return _authorTime;
        }
        string get_authorTimeFormatted() final {
            return _authorTime != MAX_UINT
                ? Time::Format(_authorTime)
                : "-:--.---"
            ;
        }

        private uint _bronzeTime = MAX_UINT;
        uint get_bronzeTime() final {
            return _bronzeTime;
        }
        string get_bronzeTimeFormatted() final {
            return _bronzeTime != MAX_UINT
                ? Time::Format(_bronzeTime)
                : "-:--.---"
            ;
        }

        private uint _goldTime = MAX_UINT;
        uint get_goldTime() final {
            return _goldTime;
        }
        string get_goldTimeFormatted() final {
            return _goldTime != MAX_UINT
                ? Time::Format(_goldTime)
                : "-:--.---"
            ;
        }

        private uint _silverTime = MAX_UINT;
        uint get_silverTime() final {
            return _silverTime;
        }
        string get_silverTimeFormatted() final {
            return _silverTime != MAX_UINT
                ? Time::Format(_silverTime)
                : "-:--.---"
            ;
        }

        private string _type;
        string get_type() final {
            return _type;
        }

        private string _uid;
        string get_uid() final {
            return _uid;
        }

        void Reset() final {
            _authorTime = MAX_UINT;
            _bronzeTime = MAX_UINT;
            _goldTime   = MAX_UINT;
            _silverTime = MAX_UINT;
            _type       = "";
            _uid        = "";
        }

        void Update() final {
            CGameCtnApp@ App = GetApp();

            if (App.RootMap !is null) {
                _authorTime = App.RootMap.TMObjective_AuthorTime;
                _bronzeTime = App.RootMap.TMObjective_BronzeTime;
                _goldTime   = App.RootMap.TMObjective_GoldTime;
                _silverTime = App.RootMap.TMObjective_SilverTime;
                _type       = string(App.RootMap.MapType);
                _uid        = App.RootMap.EdChallengeId;

            } else {
                this.Reset();
            }
        }
    }
}

namespace Ez2::Static {
    shared enum AccessLevel {
        Starter,
        Standard,
        Club
    }

    shared enum GameType {
        TmForever,
        Tm2,
        TmTurbo,
        Tm2020
    }

    shared enum OperatingSystem {
        Windows,
        Wine,
        Linux
    }

    import AccessLevel     get_accessLevel()    from "Ez2";
    import uint8           get_bits()           from "Ez2";
    import string          get_exeVersion()     from "Ez2";
    import GameType        get_gameType()       from "Ez2";
    import OperatingSystem get_os()             from "Ez2";
    import MwId            get_playerId()       from "Ez2";
    import string          get_playerLogin()    from "Ez2";
    import string          get_playerUsername() from "Ez2";
    import string          get_playerWsid()     from "Ez2";
}
