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
            return FrameCount::valid
                ? (_frameCount = FrameCount::Get())
                : (_frameCount = MAX_UINT64)
            ;
        }
    }

    /*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    base properties
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

    bool _editor = false;
    uint64 _editor_updated = 0;
    /*
    whether we're in an editor
    `App.Editor`
    */
    bool editor {
        get {
            if (_editor_updated != frameCount) {
                _editor_updated = FrameCount::valid ? _frameCount : 0;

                _editor = GetApp().Editor !is null;
            }

            return _editor;
        }
    }

    float _fps = 0.0f;
    uint64 _fps_updated = 0;
    /*
    the current average framerate
    `App.Viewport.AverageFps`
    */
    float fps {
        get {
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

    bool _guiPlayer = false;
    uint64 _guiPlayer_updated = 0;
    /*
    whether there exists a valid GUIPlayer
    `App.CurrentPlayground.GameTerminals[0].GUIPlayer`
    */
    bool guiPlayer {
        get {
            if (_guiPlayer_updated != frameCount) {
                _guiPlayer_updated = FrameCount::valid ? _frameCount : 0;

                CGameCtnApp@ App = GetApp();

                _guiPlayer = true
                    and playground
                    and App.CurrentPlayground.GameTerminals.Length > 0
                    and App.CurrentPlayground.GameTerminals[0] !is null
                    and App.CurrentPlayground.GameTerminals[0].GUIPlayer !is null
                ;
            }

            return _guiPlayer;
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

    bool _map = false;
    uint64 _map_updated = 0;
    /*
    whether we're in a map
    `App.RootMap`
    */
    bool map {
        get {
            if (_map_updated != frameCount) {
                _map_updated = FrameCount::valid ? _frameCount : 0;

                _map = GetApp().RootMap !is null;
            }

            return _map;
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

    bool _menu = false;
    uint64 _menu_updated = 0;
    /*
    whether the game's menus are shown (not UI layers)
    `App.ActiveMenus`
    */
    bool menu {
        get {
            if (_menu_updated != frameCount) {
                _menu_updated = FrameCount::valid ? _frameCount : 0;

                _menu = GetApp().ActiveMenus.Length > 0;
            }

            return _menu;
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

    bool _playground = false;
    uint64 _playground_updated = 0;
    /*
    whether we're in a drivable map
    `App.CurrentPlayground`
    */
    bool playground {
        get {
            if (_playground_updated != frameCount) {
                _playground_updated = FrameCount::valid ? _frameCount : 0;

                // is a CGamePlaygroundBasic for a few frames on map load so a cast is required
                _playground = cast<CSmArenaClient>(GetApp().CurrentPlayground) !is null;
            }

            return _playground;
        }
    }

    bool _playgroundScript = false;
    uint64 _playgroundScript_updated = 0;
    /*
    whether there exists a valid playground script
    `App.PlaygroundScript`
    */
    bool playgroundScript {
        get {
            if (_playgroundScript_updated != frameCount) {
                _playgroundScript_updated = FrameCount::valid ? _frameCount : 0;

                _playgroundScript = GetApp().PlaygroundScript !is null;
            }

            return _playgroundScript;
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
            if (_sequence_updated != frameCount) {
                _sequence_updated = FrameCount::valid ? _frameCount : 0;

                CGameCtnApp@ App = GetApp();

                _sequence = (true
                    and playground
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
            if (_viewingControlled_updated != frameCount) {
                _viewingControlled_updated = FrameCount::valid ? _frameCount : 0;

                CGameCtnApp@ App = GetApp();

                if (true
                    and playground
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
            if (_driving_updated != frameCount) {
                _driving_updated = FrameCount::valid ? _frameCount : 0;

                _driving = true
                    and playground
                    and sequence == CGamePlaygroundUIConfig::EUISequence::Playing
                    and viewingControlled
                    and !viewingReplay
                ;
            }

            return _driving;
        }
    }

    bool _mainMenu = false;
    uint64 _mainMenu_updated = 0;
    /*
    whether we're at the main menu
    */
    bool mainMenu {
        get {
            if (_mainMenu_updated != frameCount) {
                _mainMenu_updated = FrameCount::valid ? _frameCount : 0;

                _mainMenu = true
                    and !editor
                    and !map
                    and menu
                    and !playgroundScript
                ;
            }

            return _mainMenu;
        }
    }

    bool _mapEditor = false;
    uint64 _mapEditor_updated = 0;
    /*
    whether we're in the map editor
    */
    bool mapEditor {
        get {
            if (_mapEditor_updated != frameCount) {
                _mapEditor_updated = FrameCount::valid ? _frameCount : 0;

                _mapEditor = true
                    and editor
                    and map
                    and playgroundScript
                ;
            }

            return _mapEditor;
        }
    }

    bool _mapEditorTesting = false;
    uint64 _mapEditorTesting_updated = 0;
    /*
    whether we're testing/validating a map in the editor
    */
    bool mapEditorTesting {
        get {
            if (_mapEditorTesting_updated != frameCount) {
                _mapEditorTesting_updated = FrameCount::valid ? _frameCount : 0;

                _mapEditorTesting = true
                    and mapEditor
                    and playground
                ;
            }

            return _mapEditorTesting;
        }
    }

    bool _playingMap = false;
    uint64 _playingMap_updated = 0;
    /*
    whether we're playing a map
    */
    bool playingMap {
        get {
            if (_playingMap_updated != frameCount) {
                _playingMap_updated = FrameCount::valid ? _frameCount : 0;

                _playingMap = true
                    and !editor
                    and map
                    and playground
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
            if (_playingMapLocal_updated != frameCount) {
                _playingMapLocal_updated = FrameCount::valid ? _frameCount : 0;

                _playingMapLocal = true
                    and playgroundScript
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
            if (_playingMapOnline_updated != frameCount) {
                _playingMapOnline_updated = FrameCount::valid ? _frameCount : 0;

                _playingMapOnline = true
                    and !playgroundScript
                    and playingMap
                ;
            }

            return _playingMapOnline;
        }
    }

    bool _replayEditorEditing = false;
    uint64 _replayEditorEditing_updated = 0;
    /*
    whether we're editing a replay
    */
    bool replayEditorEditing {
        get {
            if (_replayEditorEditing_updated != frameCount) {
                _replayEditorEditing_updated = FrameCount::valid ? _frameCount : 0;

                _replayEditorEditing = true
                    and editor
                    and !playgroundScript
                ;
            }

            return _replayEditorEditing;
        }
    }

    bool _replayEditorViewing = false;
    uint64 _replayEditorViewing_updated = 0;
    /*
    whether we're viewing a local replay file
    */
    bool replayEditorViewing {
        get {
            if (_replayEditorViewing_updated != frameCount) {
                _replayEditorViewing_updated = FrameCount::valid ? _frameCount : 0;

                _replayEditorViewing = true
                    and !editor
                    and !loading
                    and map
                    and !playground
                ;
            }

            return _replayEditorViewing;
        }
    }

    bool _skinEditor = false;
    uint64 _skinEditor_updated = 0;
    /*
    whether we're editing a skin in the garage
    */
    bool skinEditor {
        get {
            if (_skinEditor_updated != frameCount) {
                _skinEditor_updated = FrameCount::valid ? _frameCount : 0;

                _skinEditor = true
                    and editor
                    and !map
                ;
            }

            return _skinEditor;
        }
    }

    bool _spectating = false;
    uint64 _spectating_updated = 0;
    /*
    whether we're spectating another player or the environment (not cam 7)
    */
    bool spectating {
        get {
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
            if (_viewingReplay_updated != frameCount) {
                _viewingReplay_updated = FrameCount::valid ? _frameCount : 0;

                _viewingReplay = true
                    and !guiPlayer
                    and !loading
                    and playingMapLocal
                    and sequence == CGamePlaygroundUIConfig::EUISequence::Playing
                ;
            }

            return _viewingReplay;
        }
    }
}
