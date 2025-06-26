// c 2025-04-04
// m 2025-06-25

/*
This module provides the current state of some things in the game. Each getter function is structured so that
it will only run its logic once per frame and cache the result so that any future calls from any dependent plugins
during that frame will return the cached value. In the event of a game update, until the plugin author manually
verifies an offset, this module may run with reduced performance.
*/

namespace Ez {
    uint64 _frameCount = MAX_UINT64;
    /*
    number of frames the game has rendered
    used for caching values
    */
    uint64 frameCount {
        get {
            VerifyEnabled();

            return FrameCount::valid
                ? (_frameCount = FrameCount::Get())
                : (_frameCount = MAX_UINT64)
            ;
        }
    }

    /*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    base properties
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

    float _fps = 0.0f;
    uint64 _fps_updated = 0;
    /*
    the current average framerate
    `App.Viewport.AverageFps`
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
    uint64 _gameMode_updated = 0;
    /*
    the current game mode
    `App.Network.ServerInfo.CurGameModeStr`
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
    uint64 _hasGuiPlayer_updated = 0;
    /*
    whether there exists a valid GUIPlayer
    `App.CurrentPlayground.GameTerminals[0].GUIPlayer`
    */
    bool hasGuiPlayer {
        get {
            VerifyEnabled();

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
        }
    }

    bool _hasMenu = false;
    uint64 _hasMenu_updated = 0;
    /*
    whether the game's menus are shown (not UI layers)
    `App.ActiveMenus`
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
    uint64 _hasPlaygroundScript_updated = 0;
    /*
    whether there exists a valid playground script
    `App.PlaygroundScript`
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
    uint64 _inEditor_updated = 0;
    /*
    whether we're in an editor
    `App.Editor`
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

    bool _inMap = false;
    uint64 _inMap_updated = 0;
    /*
    whether we're in a map
    `App.RootMap`
    */
    bool inMap {
        get {
            VerifyEnabled();

            if (_inMap_updated != frameCount) {
                _inMap_updated = FrameCount::valid ? _frameCount : 0;

                _inMap = GetApp().RootMap !is null;
            }

            return _inMap;
        }
    }

    bool _inPlayground = false;
    uint64 _inPlayground_updated = 0;
    /*
    whether we're in a drivable map
    `App.CurrentPlayground`
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

    bool _loading = false;
    uint64 _loading_updated = 0;
    /*
    whether the game is loading in or out of a map or editor
    `App.LoadProgress.State`
    */
    bool loading {
        get {
            VerifyEnabled();

            if (_loading_updated != frameCount) {
                _loading_updated = FrameCount::valid ? _frameCount : 0;

                CGameCtnApp@ App = GetApp();

                _loading = true
                    and App.LoadProgress !is null
                    and App.LoadProgress.State != NGameLoadProgress::EState::Disabled
                ;
            }

            return _loading;
        }
    }

    State::MapInfo@ _mapInfo = State::MapInfo();
    uint64 _mapInfo_updated = 0;
    /*
    info on the current map
    `App.RootMap`
    */
    State::MapInfo@ mapInfo {
        get {
            VerifyEnabled();

            if (_mapInfo is null) {
                @_mapInfo = State::MapInfo();
            }

            if (_mapInfo_updated != frameCount) {
                _mapInfo_updated = FrameCount::valid ? _frameCount : 0;
                _mapInfo.Update();
            }

            return _mapInfo;
        }
    }

    bool _paused = false;
    uint64 _paused_updated = 0;
    /*
    whether the pause menu is shown
    `App.Network.PlaygroundClientScriptAPI.IsInGameMenuDisplayed`
    */
    bool paused {
        get {
            VerifyEnabled();

            if (_paused_updated != frameCount) {
                _paused_updated = FrameCount::valid ? _frameCount : 0;

                auto Network = cast<CTrackManiaNetwork>(GetApp().Network);

                _paused = true
                    and Network.PlaygroundClientScriptAPI !is null
                    and Network.PlaygroundClientScriptAPI.IsInGameMenuDisplayed
                ;
            }

            return _paused;
        }
    }

    int _ping = 0;
    uint64 _ping_updated = 0;
    /*
    the ping (in ms) if we're connected to a server
    `App.Network.LatestGamePing`
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

    CGamePlaygroundUIConfig::EUISequence _sequence = CGamePlaygroundUIConfig::EUISequence::None;
    uint64 _sequence_updated = 0;
    /*
    the current UI sequence
    `App.CurrentPlayground.UIConfigs[0].UISequence`
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

    bool _viewingControlled = false;
    uint64 _viewingControlled_updated = 0;
    /*
    whether we're viewing the player
    */
    bool viewingControlled {
        get {
            VerifyEnabled();

            if (_viewingControlled_updated != frameCount) {
                _viewingControlled_updated = FrameCount::valid ? _frameCount : 0;

                CGameCtnApp@ App = GetApp();

                if (true
                    and inPlayground
                    and App.CurrentPlayground.GameTerminals.Length > 0
                    and App.CurrentPlayground.GameTerminals[0] !is null
                ) {
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
        }
    }

    /*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    logic properties
    derived from base properties
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

    bool _driving = false;
    uint64 _driving_updated = 0;
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

    bool _inMainMenu = false;
    uint64 _inMainMenu_updated = 0;
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

    bool _inMapEditor = false;
    uint64 _inMapEditor_updated = 0;
    /*
    whether we're in the map editor
    */
    bool inMapEditor {
        get {
            VerifyEnabled();

            if (_inMapEditor_updated != frameCount) {
                _inMapEditor_updated = FrameCount::valid ? _frameCount : 0;

                _inMapEditor = true
                    and hasPlaygroundScript
                    and inEditor
                    and inMap
                ;
            }

            return _inMapEditor;
        }
    }

    bool _inMapEditorTesting = false;
    uint64 _inMapEditorTesting_updated = 0;
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

    bool _inReplayEditorEditing = false;
    uint64 _inReplayEditorEditing_updated = 0;
    /*
    whether we're editing a replay
    */
    bool inReplayEditorEditing {
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
    uint64 _inReplayEditorViewing_updated = 0;
    /*
    whether we're viewing a local replay file
    */
    bool inReplayEditorViewing {
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
    uint64 _inSkinEditor_updated = 0;
    /*
    whether we're editing a skin in the garage
    */
    bool inSkinEditor {
        get {
            VerifyEnabled();

            if (_inSkinEditor_updated != frameCount) {
                _inSkinEditor_updated = FrameCount::valid ? _frameCount : 0;

                _inSkinEditor = true
                    and inEditor
                    and !inMap
                ;
            }

            return _inSkinEditor;
        }
    }

    bool _playingMap = false;
    uint64 _playingMap_updated = 0;
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
    uint64 _playingMapLocal_updated = 0;
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
    uint64 _playingMapOnline_updated = 0;
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

    bool _spectating = false;
    uint64 _spectating_updated = 0;
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

    bool _viewingReplay = false;
    uint64 _viewingReplay_updated = 0;
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
        _frameCount = MAX_UINT64;

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
        _inMap                         = false;
        _inMap_updated                 = 0;
        _inPlayground                  = false;
        _inPlayground_updated          = 0;
        _loading                       = false;
        _loading_updated               = 0;
        _mapInfo.Reset();
        _mapInfo_updated               = 0;
        _paused                        = false;
        _paused_updated                = 0;
        _ping                          = 0;
        _ping_updated                  = 0;
        _sequence                      = CGamePlaygroundUIConfig::EUISequence::None;
        _sequence_updated              = 0;
        _viewingControlled             = false;
        _viewingControlled_updated     = 0;

        _driving                       = false;
        _driving_updated               = 0;
        _inMainMenu                    = false;
        _inMainMenu_updated            = 0;
        _inMapEditor                   = false;
        _inMapEditor_updated           = 0;
        _inMapEditorTesting            = false;
        _inMapEditorTesting_updated    = 0;
        _inReplayEditorEditing         = false;
        _inReplayEditorEditing_updated = 0;
        _inReplayEditorViewing         = false;
        _inReplayEditorViewing_updated = 0;
        _inSkinEditor                  = false;
        _inSkinEditor_updated          = 0;
        _playingMap                    = false;
        _playingMap_updated            = 0;
        _playingMapLocal               = false;
        _playingMapLocal_updated       = 0;
        _playingMapOnline              = false;
        _playingMapOnline_updated      = 0;
        _spectating                    = false;
        _spectating_updated            = 0;
        _viewingReplay                 = false;
        _viewingReplay_updated         = 0;
    }
}
