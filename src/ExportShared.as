// c 2025-03-29
// m 2025-06-25

const uint   MAX_UINT   = uint(-1);
const uint64 MAX_UINT64 = uint64(-1);

/*
Allows plugins to register callback functions that will be called under certain conditions.
*/
namespace Ez::Callback {
    /*
    class containing callback functions a plugin desires to use
    instructions:
    - inherit this class
    - override any .On\<MethodName>() methods
    - in the constructor, call super() and set the respective .on\<MethodName> bools true for any overridden methods
    - pass an instance of your class to Ez::Callback::Register()
    async methods are marked as such - all others are not yieldable
    */
    shared abstract class CallbackClass {
        private Meta::Plugin@ _parent;
        Meta::Plugin@ get_parent() const final {
            return _parent;
        }
        private void set_parent(Meta::Plugin@ p) { }

        protected bool onEnteredMap      = false;
        protected bool onEnteredMapAsync = false;
        protected bool onExitedMap       = false;
        protected bool onExitedMapAsync  = false;

        CallbackClass() {
            @_parent = Meta::ExecutingPlugin();
        }

        void OnEnteredMap() { }
        void OnEnteredMapAsync() { }
        void _OnEnteredMap() final {
            if (parent !is null) {
                if (onEnteredMap) {
                    trace("OnEnteredMap: plugin '" + parent.ID + "'");
                    this.OnEnteredMap();
                }

                if (onEnteredMapAsync) {
                    trace("OnEnteredMapAsync: plugin '" + parent.ID + "'");
                    startnew(CoroutineFunc(this.OnEnteredMapAsync));
                }
            }
        }

        void OnExitedMap() { }
        void OnExitedMapAsync() { }
        void _OnExitedMap() final {
            if (parent !is null) {
                if (onExitedMap) {
                    trace("OnExitedMap: plugin '" + parent.ID + "'");
                    this.OnExitedMap();
                }

                if (onExitedMapAsync) {
                    trace("OnExitedMapAsync: plugin '" + parent.ID + "'");
                    startnew(CoroutineFunc(this.OnExitedMapAsync));
                }
            }
        }
    }

    import void Deregister() from "Ez";
    import void Register(CallbackClass@) from "Ez";
}

/*
Stores information about the game that changes. Very efficient.
*/
namespace Ez::State {
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

    import uint64                               get_frameCount()          from "Ez";

    import bool                                 get_editor()              from "Ez";
    import float                                get_fps()                 from "Ez";
    import string                               get_gameMode()            from "Ez";
    import bool                                 get_guiPlayer()           from "Ez";
    import bool                                 get_map()                 from "Ez";
    import MapInfo@                             get_mapInfo()             from "Ez";
    import bool                                 get_menu()                from "Ez";
    import bool                                 get_loading()             from "Ez";
    import bool                                 get_paused()              from "Ez";
    import int                                  get_ping()                from "Ez";
    import bool                                 get_playground()          from "Ez";
    import bool                                 get_playgroundScript()    from "Ez";
    import CGamePlaygroundUIConfig::EUISequence get_sequence()            from "Ez";
    import bool                                 get_viewingControlled()   from "Ez";

    import bool                                 get_driving()             from "Ez";
    import bool                                 get_mainMenu()            from "Ez";
    import bool                                 get_mapEditor()           from "Ez";
    import bool                                 get_mapEditorTesting()    from "Ez";
    import bool                                 get_playingMap()          from "Ez";
    import bool                                 get_playingMapLocal()     from "Ez";
    import bool                                 get_playingMapOnline()    from "Ez";
    import bool                                 get_replayEditorEditing() from "Ez";
    import bool                                 get_replayEditorViewing() from "Ez";
    import bool                                 get_skinEditor()          from "Ez";
    import bool                                 get_spectating()          from "Ez";
    import bool                                 get_viewingReplay()       from "Ez";
}

/*
Stores information about things that do not change.
*/
namespace Ez::Static {
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

    import AccessLevel     get_accessLevel()    from "Ez";
    import uint8           get_bits()           from "Ez";
    import string          get_exeVersion()     from "Ez";
    import GameType        get_gameType()       from "Ez";
    import OperatingSystem get_os()             from "Ez";
    import MwId            get_playerId()       from "Ez";
    import string          get_playerLogin()    from "Ez";
    import string          get_playerUsername() from "Ez";
    import string          get_playerWsid()     from "Ez";
}
