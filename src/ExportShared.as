// c 2025-03-29
// m 2025-07-12

const int8   MAX_INT8   = (1 << 7) - 1;
const int16  MAX_INT16  = (1 << 15) - 1;
const int    MAX_INT32  = (1 << 31) - 1;
const int8   MIN_INT8   = -MAX_INT8 - 1;
const int16  MIN_INT16  = -MAX_INT16 - 1;
const int    MIN_INT32  = -MAX_INT32 - 1;
const uint8  MAX_UINT8  = uint8(-1);
const uint16 MAX_UINT16 = uint16(-1);
const uint   MAX_UINT32 = uint(-1);
#if MANIA64
const int64  MAX_INT64  = (int64(1) << 63) - 1;
const int64  MIN_INT64  = MAX_INT64 + 1;
const uint64 MAX_UINT64 = uint64(-1);
#endif

/*
Allows plugins to register callback functions that will be called under certain conditions.
*/
namespace EzCallback {
    /*
    class containing callback functions a plugin desires to use
    instructions:
    - inherit this class
    - override any .On\<MethodName>() methods
    - in the constructor, call super() and set the respective .on\<MethodName> bools true for any overridden methods
    - pass an instance of your class to Ez::Callback::Register()
    async methods are marked as such - all others are not yieldable
    */
    shared abstract class Callback {
        private Meta::Plugin@ _parent;
        Meta::Plugin@ get_parent() const final {
            return _parent;
        }
        private void set_parent(Meta::Plugin@ p) { }

        private bool _onEnteredMap = false;
        bool get_onEnteredMap() { return _onEnteredMap; }
        protected void set_onEnteredMap(bool o) { _onEnteredMap = o; }

        private bool _onEnteredMapAsync = false;
        bool get_onEnteredMapAsync() { return _onEnteredMapAsync; }
        protected void set_onEnteredMapAsync(bool o) { _onEnteredMapAsync = o; }

        private bool _onExitedMap = false;
        bool get_onExitedMap() { return _onExitedMap; }
        protected void set_onExitedMap(bool o) { _onExitedMap = o; }

        private bool _onExitedMapAsync = false;
        bool get_onExitedMapAsync() { return _onExitedMapAsync; }
        protected void set_onExitedMapAsync(bool o) { _onExitedMapAsync = o; }

        uint get_count() {
            uint ret = 0;

            if (_onEnteredMap) {
                ret += 1;
            }
            if (onEnteredMapAsync) {
                ret += 1;
            }
            if (_onExitedMap) {
                ret += 1;
            }
            if (onExitedMapAsync) {
                ret += 1;
            }

            return ret;
        }

        Callback() {
            @_parent = Meta::ExecutingPlugin();
        }

        void OnEnteredMap() {
            if (onEnteredMap) {
                throw("plugin '" + (parent !is null ? parent.ID : "") +  "' did not override callback for OnEnteredMap!");
            }
        }
        void OnEnteredMapAsync() {
            if (onEnteredMapAsync) {
                throw("plugin '" + (parent !is null ? parent.ID : "") +  "' did not override callback for OnEnteredMapAsync!");
            }
        }
        void _OnEnteredMap() final {
            if (parent !is null) {
                if (_onEnteredMap) {
                    trace("OnEnteredMap: plugin '" + parent.ID + "'");
                    this.OnEnteredMap();
                }

                if (_onEnteredMapAsync) {
                    trace("OnEnteredMapAsync: plugin '" + parent.ID + "'");
                    startnew(CoroutineFunc(this.OnEnteredMapAsync));
                }
            }
        }

        void OnExitedMap() {
            if (onExitedMap) {
                throw("plugin '" + (parent !is null ? parent.ID : "") +  "' did not override callback for OnExitedMap!");
            }
        }
        void OnExitedMapAsync() {
            if (onExitedMapAsync) {
                throw("plugin '" + (parent !is null ? parent.ID : "") +  "' did not override callback for OnExitedMapAsync!");
            }
        }
        void _OnExitedMap() final {
            if (parent !is null) {
                if (_onExitedMap) {
                    trace("OnExitedMap: plugin '" + parent.ID + "'");
                    this.OnExitedMap();
                }

                if (_onExitedMapAsync) {
                    trace("OnExitedMapAsync: plugin '" + parent.ID + "'");
                    startnew(CoroutineFunc(this.OnExitedMapAsync));
                }
            }
        }
    }
}

/*
Stores information about the game that changes. Very efficient.
*/
namespace EzState {
    /*
    stores information on the current map
    if you keep a handle to this around, call `.Update()` every frame
    */
    shared class MapInfo {
        private uint _authorTime = MAX_UINT32;
        uint get_authorTime() final {
            return _authorTime;
        }
        string get_authorTimeFormatted() final {
            return _authorTime != MAX_UINT32
                ? Time::Format(_authorTime)
                : "-:--.---"
            ;
        }

        private uint _bronzeTime = MAX_UINT32;
        uint get_bronzeTime() final {
            return _bronzeTime;
        }
        string get_bronzeTimeFormatted() final {
            return _bronzeTime != MAX_UINT32
                ? Time::Format(_bronzeTime)
                : "-:--.---"
            ;
        }

        private uint _goldTime = MAX_UINT32;
        uint get_goldTime() final {
            return _goldTime;
        }
        string get_goldTimeFormatted() final {
            return _goldTime != MAX_UINT32
                ? Time::Format(_goldTime)
                : "-:--.---"
            ;
        }

        private uint _silverTime = MAX_UINT32;
        uint get_silverTime() final {
            return _silverTime;
        }
        string get_silverTimeFormatted() final {
            return _silverTime != MAX_UINT32
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
            _authorTime = MAX_UINT32;
            _bronzeTime = MAX_UINT32;
            _goldTime   = MAX_UINT32;
            _silverTime = MAX_UINT32;
            _type       = "";
            _uid        = "";
        }

        void Update() final {
            CGameCtnApp@ App = GetApp();

            CGameCtnChallenge@ RootMap;
#if TMNEXT || MP4
            @RootMap = App.RootMap;
#else
            @RootMap = App.Challenge;
#endif

            if (RootMap !is null) {
                _authorTime = RootMap.TMObjective_AuthorTime;
                _bronzeTime = RootMap.TMObjective_BronzeTime;
                _goldTime   = RootMap.TMObjective_GoldTime;
                _silverTime = RootMap.TMObjective_SilverTime;
                _type       = string(RootMap.MapType);
                _uid        = RootMap.EdChallengeId;

            } else {
                this.Reset();
            }
        }
    }
}

/*
Stores information about things that do not change.
*/
namespace EzStatic {
#if TMNEXT
    shared enum AccessLevel {
        Starter,
        Standard,
        Club
    }
#endif

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
}
