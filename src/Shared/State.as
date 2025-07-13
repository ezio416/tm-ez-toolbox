// c 2025-07-13
// m 2025-07-13

/*
Stores information about the game that changes. Very efficient.
*/
namespace EzState {
    /*
    stores information on the current map
    if you keep a handle to this around, call `.Update()` every frame before use
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
