// c 2025-04-04
// m 2025-07-12

/*
This module provides the current state of some things in the game. Each getter function is structured so that
it will only run its logic once per frame and cache the result so that any future calls from any dependent plugins
during that frame will return the cached value. In the event of a game update, until the plugin author manually
verifies an offset, this module may run with reduced performance.
*/

/*
Stores information about the game that changes. Very efficient.
*/
namespace EzState {
    uint _frameCount = MAX_UINT32;
    /*
    number of frames the game has rendered
    used for caching values
    */
    uint frameCount {
        get {
            VerifyEnabled();

            _frameCount = FrameCount::valid
                ? FrameCount::Get()
                : MAX_UINT32
            ;

            return _frameCount;
        }
    }

    bool _driving = false;
    uint _driving_updated = 0;
    /*
    whether the player has control of the car
    */
    bool driving {
        get {
            VerifyEnabled();

            if (_driving_updated != frameCount) {
                _driving_updated = FrameCount::valid ? _frameCount : 0;

                _driving = true
                    and inPlayground
                    and sequence == CGamePlaygroundUIConfig::EUISequence::Playing
                    and viewingControlled
                    and !viewingReplay
                ;
            }

            return _driving;
        }
    }

    float _fps = 0.0f;
    uint _fps_updated = 0;
    /*
    the current average framerate
    */
    float fps {
        get {
            VerifyEnabled();

            if (_fps_updated != frameCount) {
                _fps_updated = FrameCount::valid ? _frameCount : 0;

                CGameCtnApp@ App = GetApp();

                _fps = App.Viewport !is null ? App.Viewport.AverageFps : 0.0f;
            }

            return _fps;
        }
    }

    string _gameMode;
    uint _gameMode_updated = 0;
    /*
    the current game mode
    */
    string gameMode {
        get {
            VerifyEnabled();

            if (_gameMode_updated != frameCount) {
                _gameMode_updated = FrameCount::valid ? _frameCount : 0;

                _gameMode = string(
                    cast<CTrackManiaNetworkServerInfo>(
                        cast<CTrackManiaNetwork>(
                            GetApp().Network
                        ).ServerInfo
                    ).CurGameModeStr
                );
            }

            return _gameMode;
        }
    }

    bool _hasGuiPlayer = false;
    uint _hasGuiPlayer_updated = 0;
    /*
    whether there exists a valid GUIPlayer
    */
    bool hasGuiPlayer {
        get {
            VerifyEnabled();

#if TMNEXT || MP4
            if (_hasGuiPlayer_updated != frameCount) {
                _hasGuiPlayer_updated = FrameCount::valid ? _frameCount : 0;

                CGameCtnApp@ App = GetApp();

                _hasGuiPlayer = true
                    and inPlayground
                    and App.CurrentPlayground.GameTerminals.Length > 0
                    and App.CurrentPlayground.GameTerminals[0] !is null
                    and App.CurrentPlayground.GameTerminals[0].GUIPlayer !is null
                ;
            }

            return _hasGuiPlayer;
#elif TURBO
            return false;  // idk where it is
#endif
        }
    }

    bool _hasMenu = false;
    uint _hasMenu_updated = 0;
    /*
    whether the game's menus are shown (not UI layers)
    */
    bool hasMenu {
        get {
            VerifyEnabled();

            if (_hasMenu_updated != frameCount) {
                _hasMenu_updated = FrameCount::valid ? _frameCount : 0;

                _hasMenu = GetApp().ActiveMenus.Length > 0;
            }

            return _hasMenu;
        }
    }

    bool _hasPlaygroundScript = false;
    uint _hasPlaygroundScript_updated = 0;
    /*
    whether there exists a valid playground script
    */
    bool hasPlaygroundScript {
        get {
            VerifyEnabled();

            if (_hasPlaygroundScript_updated != frameCount) {
                _hasPlaygroundScript_updated = FrameCount::valid ? _frameCount : 0;

                _hasPlaygroundScript = GetApp().PlaygroundScript !is null;
            }

            return _hasPlaygroundScript;
        }
    }

    bool _inEditor = false;
    uint _inEditor_updated = 0;
    /*
    whether we're in an editor
    */
    bool inEditor {
        get {
            VerifyEnabled();

            if (_inEditor_updated != frameCount) {
                _inEditor_updated = FrameCount::valid ? _frameCount : 0;

                _inEditor = GetApp().Editor !is null;
            }

            return _inEditor;
        }
    }

    bool _inMainMenu = false;
    uint _inMainMenu_updated = 0;
    /*
    whether we're at the main menu
    */
    bool inMainMenu {
        get {
            VerifyEnabled();

            if (_inMainMenu_updated != frameCount) {
                _inMainMenu_updated = FrameCount::valid ? _frameCount : 0;

                _inMainMenu = true
                    and hasMenu
                    and !hasPlaygroundScript
                    and !inEditor
                    and !inMap
                ;
            }

            return _inMainMenu;
        }
    }

    bool _inMap = false;
    uint _inMap_updated = 0;
    /*
    whether we're in a map
    */
    bool inMap {
        get {
            VerifyEnabled();

            if (_inMap_updated != frameCount) {
                _inMap_updated = FrameCount::valid ? _frameCount : 0;

                _inMap = EzGame::RootMap !is null;
            }

            return _inMap;
        }
    }

    bool _inMapEditor = false;
    uint _inMapEditor_updated = 0;
    /*
    whether we're in the map editor
    */
    bool inMapEditor {
        get {
            VerifyEnabled();

            if (_inMapEditor_updated != frameCount) {
                _inMapEditor_updated = FrameCount::valid ? _frameCount : 0;

                _inMapEditor = cast<CGameCtnEditorFree>(GetApp().Editor) !is null;
            }

            return _inMapEditor;
        }
    }

    bool _inMapEditorTesting = false;
    uint _inMapEditorTesting_updated = 0;
    /*
    whether we're testing/validating a map in the editor
    */
    bool inMapEditorTesting {
        get {
            VerifyEnabled();

            if (_inMapEditorTesting_updated != frameCount) {
                _inMapEditorTesting_updated = FrameCount::valid ? _frameCount : 0;

                _inMapEditorTesting = true
                    and inMapEditor
                    and inPlayground
                ;
            }

            return _inMapEditorTesting;
        }
    }

    bool _inPlayground = false;
    uint _inPlayground_updated = 0;
    /*
    whether we're in a drivable map
    */
    bool inPlayground {
        get {
            VerifyEnabled();

            if (_inPlayground_updated != frameCount) {
                _inPlayground_updated = FrameCount::valid ? _frameCount : 0;

                // is a CGamePlaygroundBasic for a few frames on map load so a cast is required
                _inPlayground = cast<CSmArenaClient>(GetApp().CurrentPlayground) !is null;
            }

            return _inPlayground;
        }
    }

    bool _inReplayEditorEditing = false;
    uint _inReplayEditorEditing_updated = 0;
    /*
    whether we're editing a replay
    */
    bool inReplayEditorEditing {  // wrong, could be mediatracker?
        get {
            VerifyEnabled();

            if (_inReplayEditorEditing_updated != frameCount) {
                _inReplayEditorEditing_updated = FrameCount::valid ? _frameCount : 0;

                _inReplayEditorEditing = true
                    and !hasPlaygroundScript
                    and inEditor
                ;
            }

            return _inReplayEditorEditing;
        }
    }

    bool _inReplayEditorViewing = false;
    uint _inReplayEditorViewing_updated = 0;
    /*
    whether we're viewing a local replay file
    */
    bool inReplayEditorViewing {  // wrong, could be mediatracker?
        get {
            VerifyEnabled();

            if (_inReplayEditorViewing_updated != frameCount) {
                _inReplayEditorViewing_updated = FrameCount::valid ? _frameCount : 0;

                _inReplayEditorViewing = true
                    and !inEditor
                    and inMap
                    and !inPlayground
                    and !loading
                ;
            }

            return _inReplayEditorViewing;
        }
    }

    bool _inSkinEditor = false;
    uint _inSkinEditor_updated = 0;
    /*
    whether we're editing a skin in the garage
    */
    bool inSkinEditor {
        get {
            VerifyEnabled();

#if TMNEXT
            if (_inSkinEditor_updated != frameCount) {
                _inSkinEditor_updated = FrameCount::valid ? _frameCount : 0;

                _inSkinEditor = cast<CGameEditorSkin>(GetApp().Editor) !is null;
            }

            return _inSkinEditor;
#elif MP4 || TURBO
            return false;
#endif
        }
    }

    bool _loading = false;
    uint _loading_updated = 0;
    /*
    whether the game is loading in or out of a map or editor
    */
    bool loading {
        get {
            VerifyEnabled();

#if TMNEXT
            if (_loading_updated != frameCount) {
                _loading_updated = FrameCount::valid ? _frameCount : 0;

                CGameCtnApp@ App = GetApp();

                _loading = true
                    and App.LoadProgress !is null
                    and App.LoadProgress.State != NGameLoadProgress::EState::Disabled
                ;
            }

            return _loading;
#elif MP4 || TURBO
            return false;  // idk where it is
#endif
        }
    }

    MapInfo@ _mapInfo = MapInfo();
    uint _mapInfo_updated = 0;
    /*
    info on the current map
    */
    MapInfo@ mapInfo {
        get {
            VerifyEnabled();

            if (_mapInfo is null) {
                @_mapInfo = EzState::MapInfo();
            }

            if (_mapInfo_updated != frameCount) {
                _mapInfo_updated = FrameCount::valid ? _frameCount : 0;
                _mapInfo.Update();
            }

            return _mapInfo;
        }
    }

    bool _paused = false;
    uint _paused_updated = 0;
    /*
    whether the pause menu is shown
    */
    bool paused {
        get {
            VerifyEnabled();

#if TMNEXT || MP4
            if (_paused_updated != frameCount) {
                _paused_updated = FrameCount::valid ? _frameCount : 0;

                auto Network = cast<CTrackManiaNetwork>(GetApp().Network);

                _paused = true
                    and Network.PlaygroundClientScriptAPI !is null
                    and Network.PlaygroundClientScriptAPI.IsInGameMenuDisplayed
                ;
            }

            return _paused;
#elif TURBO
            try {
                return GetApp().CurrentPlayground.Interface.ManialinkPage.Childs[27].IsFocused;  // I hate this
            } catch {
                return false;
            }
#endif
        }
    }

    int _ping = 0;
    uint _ping_updated = 0;
    /*
    the ping (in ms) if we're connected to a server
    */
    int ping {
        get {
            VerifyEnabled();

            if (_ping_updated != frameCount) {
                _ping_updated = FrameCount::valid ? _frameCount : 0;

                _ping = (true
                    and playingMap
                    and !playingMapLocal
                )
                    ? GetApp().Network.LatestGamePing
                    : 0
                ;
            }

            return _ping;
        }
    }

    bool _playingMap = false;
    uint _playingMap_updated = 0;
    /*
    whether we're playing a map
    */
    bool playingMap {
        get {
            VerifyEnabled();

            if (_playingMap_updated != frameCount) {
                _playingMap_updated = FrameCount::valid ? _frameCount : 0;

                _playingMap = true
                    and !inEditor
                    and inMap
                    and inPlayground
                ;
            }

            return _playingMap;
        }
    }

    bool _playingMapLocal = false;
    uint _playingMapLocal_updated = 0;
    /*
    whether we're playing a map locally (solo)
    */
    bool playingMapLocal {
        get {
            VerifyEnabled();

            if (_playingMapLocal_updated != frameCount) {
                _playingMapLocal_updated = FrameCount::valid ? _frameCount : 0;

                _playingMapLocal = true
                    and hasPlaygroundScript
                    and playingMap
                ;
            }

            return _playingMapLocal;
        }
    }

    bool _playingMapOnline = false;
    uint _playingMapOnline_updated = 0;
    /*
    whether we're playing a map online (server)
    */
    bool playingMapOnline {
        get {
            VerifyEnabled();

            if (_playingMapOnline_updated != frameCount) {
                _playingMapOnline_updated = FrameCount::valid ? _frameCount : 0;

                _playingMapOnline = true
                    and !hasPlaygroundScript
                    and playingMap
                ;
            }

            return _playingMapOnline;
        }
    }

    CGamePlaygroundUIConfig::EUISequence _sequence = CGamePlaygroundUIConfig::EUISequence::None;
    uint _sequence_updated = 0;
    /*
    the current UI sequence
    */
    CGamePlaygroundUIConfig::EUISequence sequence {
        get {
            VerifyEnabled();

            if (_sequence_updated != frameCount) {
                _sequence_updated = FrameCount::valid ? _frameCount : 0;

                CGameCtnApp@ App = GetApp();

                _sequence = (true
                    and inPlayground
                    and App.CurrentPlayground.UIConfigs.Length > 0
                    and App.CurrentPlayground.UIConfigs[0] !is null
                )
                    ? App.CurrentPlayground.UIConfigs[0].UISequence
                    : CGamePlaygroundUIConfig::EUISequence::None
                ;
            }

            return _sequence;
        }
    }

    bool _spectating = false;
    uint _spectating_updated = 0;
    /*
    whether we're spectating another player or the environment (not cam 7)
    */
    bool spectating {
        get {
            VerifyEnabled();

            if (_spectating_updated != frameCount) {
                _spectating_updated = FrameCount::valid ? _frameCount : 0;

                _spectating = true
                    and !loading
                    and playingMap
                    and !playingMapLocal
                    and !viewingControlled
                    and !viewingReplay
                ;
            }

            return _spectating;
        }
    }

    bool _viewingControlled = false;
    uint _viewingControlled_updated = 0;
    /*
    whether we're viewing the player
    */
    bool viewingControlled {
        get {
            VerifyEnabled();

#if TMNEXT || MP4
            if (_viewingControlled_updated != frameCount) {
                _viewingControlled_updated = FrameCount::valid ? _frameCount : 0;

                CGameCtnApp@ App = GetApp();

                if (hasGuiPlayer) {
                    auto GUIPlayer = cast<CSmPlayer>(App.CurrentPlayground.GameTerminals[0].GUIPlayer);

                    _viewingControlled = true
                        and GUIPlayer !is null
                        and GUIPlayer is App.CurrentPlayground.GameTerminals[0].ControlledPlayer
                    ;

                } else {
                    _viewingControlled = false;
                }
            }

            return _viewingControlled;
#elif TURBO
            return true;  // just assume we aren't spectating? idk figure out later
#endif
        }
    }

    bool _viewingReplay = false;
    uint _viewingReplay_updated = 0;
    /*
    whether we're viewing a replay from the leaderboard
    */
    bool viewingReplay {
        get {
            VerifyEnabled();

            if (_viewingReplay_updated != frameCount) {
                _viewingReplay_updated = FrameCount::valid ? _frameCount : 0;

                _viewingReplay = true
                    and !hasGuiPlayer
                    and !loading
                    and playingMapLocal
                    and sequence == CGamePlaygroundUIConfig::EUISequence::Playing
                ;
            }

            return _viewingReplay;
        }
    }

    void ResetState() {
        _frameCount = MAX_UINT32;

        _driving                       = false;
        _driving_updated               = 0;
        _fps                           = 0.0f;
        _fps_updated                   = 0;
        _gameMode;
        _gameMode_updated              = 0;
        _hasGuiPlayer                  = false;
        _hasGuiPlayer_updated          = 0;
        _hasMenu                       = false;
        _hasMenu_updated               = 0;
        _hasPlaygroundScript           = false;
        _hasPlaygroundScript_updated   = 0;
        _inEditor                      = false;
        _inEditor_updated              = 0;
        _inMainMenu                    = false;
        _inMainMenu_updated            = 0;
        _inMap                         = false;
        _inMap_updated                 = 0;
        _inMapEditor                   = false;
        _inMapEditor_updated           = 0;
        _inMapEditorTesting            = false;
        _inMapEditorTesting_updated    = 0;
        _inPlayground                  = false;
        _inPlayground_updated          = 0;
        _inReplayEditorEditing         = false;
        _inReplayEditorEditing_updated = 0;
        _inReplayEditorViewing         = false;
        _inReplayEditorViewing_updated = 0;
        _inSkinEditor                  = false;
        _inSkinEditor_updated          = 0;
        _loading                       = false;
        _loading_updated               = 0;
        _mapInfo.Reset();
        _mapInfo_updated               = 0;
        _paused                        = false;
        _paused_updated                = 0;
        _ping                          = 0;
        _ping_updated                  = 0;
        _playingMap                    = false;
        _playingMap_updated            = 0;
        _playingMapLocal               = false;
        _playingMapLocal_updated       = 0;
        _playingMapOnline              = false;
        _playingMapOnline_updated      = 0;
        _sequence                      = CGamePlaygroundUIConfig::EUISequence::None;
        _sequence_updated              = 0;
        _spectating                    = false;
        _spectating_updated            = 0;
        _viewingControlled             = false;
        _viewingControlled_updated     = 0;
        _viewingReplay                 = false;
        _viewingReplay_updated         = 0;
    }
}
