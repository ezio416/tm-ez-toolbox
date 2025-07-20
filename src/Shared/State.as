// c 2025-07-13
// m 2025-07-14

/*
Stores information about the game that changes. Although most things in this module are shared,
it is recommended that you do not use them in shared code in case of future plugin updates.
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

        MapInfo@ Update() final {
            CGameCtnChallenge@ RootMap = EzGame::RootMap;
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

            return this;
        }
    }

    /*
    whether the player has control of the car
    */
    shared bool get_driving() {
        return true
            and inPlayground
            and sequence == CGamePlaygroundUIConfig::EUISequence::Playing
            and viewingControlled
            and !viewingReplay
        ;
    }

    /*
    the current average framerate
    */
    shared float get_fps() {
        try {
            return GetApp().Viewport.AverageFps;
        } catch {
            return 0.0f;
        }
    }

    /*
    the current game mode
    */
    shared string get_gameMode() {
        return string(EzGame::ServerInfo.CurGameModeStr);
    }

    /*
    whether there exists a valid GUIPlayer
    */
    shared bool get_hasGuiPlayer() {
#if TMNEXT || MP4
        try {
            return GetApp().CurrentPlayground.GameTerminals[0].GUIPlayer !is null;
        } catch {
            return false;
        }
#elif TURBO
        return false;  // idk where it is
#endif
    }

    /*
    whether the game's menus are shown (not UI layers)
    */
    shared bool get_hasMenu() {
        return GetApp().ActiveMenus.Length > 0;
    }

    /*
    whether there exists a valid playground script
    */
    shared bool get_hasPlaygroundScript() {
        return GetApp().PlaygroundScript !is null;
    }

    /*
    whether we're in an editor
    */
    shared bool get_inEditor() {
        return GetApp().Editor !is null;
    }

    /*
    whether we're at the main menu
    */
    shared bool get_inMainMenu() {
        return true
            and hasMenu
            and !hasPlaygroundScript
            and !inEditor
            and !inMap
        ;
    }

    /*
    whether we're in a map
    */
    shared bool get_inMap() {
        return EzGame::RootMap !is null;
    }

    /*
    whether we're in the map editor
    */
    shared bool get_inMapEditor() {
        return cast<CGameCtnEditorFree>(GetApp().Editor) !is null;
    }

    /*
    whether we're editing mediatracker in the editor
    */
    shared bool get_inMapEditorMediaTracker() {
        return true
            and inMapEditor
            and inPlayground
        ;
    }

    /*
    whether we're testing/validating a map in the editor
    */
    shared bool get_inMapEditorTesting() {
        return true
            and cast<CGameEditorMediaTracker>(GetApp().Editor) !is null
            and hasPlaygroundScript
        ;
    }

    /*
    whether we're in a drivable map
    */
    shared bool get_inPlayground() {
#if TMNEXT
        // is a CGamePlaygroundBasic for a few frames on map load so a cast is required
        return cast<CSmArenaClient>(GetApp().CurrentPlayground) !is null;
#elif MP4 || TURBO
        // could be a number of different types
        return GetApp().CurrentPlayground !is null;
#endif
    }

    /*
    whether we're editing a replay
    */
    shared bool get_inReplayEditorEditing() {
        return true
            and cast<CGameEditorMediaTracker>(GetApp().Editor) !is null
            and !hasPlaygroundScript
            and inEditor
        ;
    }

    /*
    whether we're viewing a local replay file
    */
    shared bool get_inReplayEditorViewing() {
        return true
            and !inEditor
            and inMap
            and !inPlayground
            and !loading
        ;
    }

    /*
    whether we're editing a skin in the garage
    */
    shared bool get_inSkinEditor() {
#if TMNEXT
        return cast<CGameEditorSkin>(GetApp().Editor) !is null;
#elif MP4 || TURBO
        return false;
#endif
    }

    /*
    whether the game is loading in or out of a map or editor
    */
    shared bool get_loading() {
#if TMNEXT
        try {
            return GetApp().LoadProgress.State != NGameLoadProgress::EState::Disabled;
        } catch {
            return false;
        }
#elif MP4 || TURBO
        return false;  // idk where it is
#endif
    }

    /*
    whether the pause menu is shown
    */
    shared bool get_paused() {
        try {
#if TMNEXT || MP4
            return GetApp().Network.PlaygroundClientScriptAPI.IsInGameMenuDisplayed;
#elif TURBO
            return GetApp().CurrentPlayground.Interface.ManialinkPage.Childs[27].IsFocused;  // I hate this
#endif
        } catch {
            return false;
        }
    }

    /*
    the ping (in ms) if we're connected to a server
    */
    shared int get_ping() {
        return (true
            and playingMap
            and !playingMapLocal
        )
            ? GetApp().Network.LatestGamePing
            : 0
        ;
    }

    /*
    whether we're playing a map
    */
    shared bool get_playingMap() {
        return true
            and !inEditor
            and inMap
            and inPlayground
        ;
    }

    /*
    whether we're playing a map locally (solo)
    */
    shared bool get_playingMapLocal() {
        return true
            and hasPlaygroundScript
            and playingMap
        ;
    }

    /*
    whether we're playing a map online (server)
    */
    shared bool get_playingMapOnline() {
        return true
            and !hasPlaygroundScript
            and playingMap
        ;
    }

    /*
    the current UI sequence
    */
    shared CGamePlaygroundUIConfig::EUISequence get_sequence() {
        try {
            return GetApp().CurrentPlayground.UIConfigs[0].UISequence;
        } catch {
            return CGamePlaygroundUIConfig::EUISequence::None;
        }
    }

    /*
    whether we're spectating another player or the environment (not cam 7)
    */
    shared bool get_spectating() {
        return true
            and !loading
            and playingMap
            and !playingMapLocal
            and !viewingControlled
            and !viewingReplay
        ;
    }

    /*
    whether we're viewing the player
    */
    shared bool get_viewingControlled() {
#if TMNEXT || MP4
        auto Playground = GetApp().CurrentPlayground;
        try {
            auto GUIPlayer = Playground.GameTerminals[0].GUIPlayer;
            return true
                and GUIPlayer !is null
                and GUIPlayer is Playground.GameTerminals[0].ControlledPlayer
            ;
        } catch {
            return false;
        }
#elif TURBO
        return true;  // just assume we aren't spectating? idk figure out later
#endif
    }

    /*
    whether we're viewing a replay from the leaderboard
    */
    shared bool get_viewingReplay() {
        return true
            and !hasGuiPlayer
            and !loading
            and playingMapLocal
            and sequence == CGamePlaygroundUIConfig::EUISequence::Playing
        ;
    }
}
