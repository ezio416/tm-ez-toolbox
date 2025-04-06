// c 2025-04-04
// m 2025-04-05

/*
This module is for returning the current state of some things in the game.
Each getter function is structured so that it will only run its logic once
  per frame and cache the result so that any future calls from any dependent
  plugins during that frame will return the cached value.
*/

namespace Ez2 {
    void StateLoopAsync() {
        while (true) {
            auto App = cast<CTrackMania@>(GetApp());
            auto Network = cast<CTrackManiaNetwork@>(App.Network);
            auto ServerInfo = cast<CTrackManiaNetworkServerInfo@>(Network.ServerInfo);

            _editor = App.Editor !is null;

            _fps = App.Viewport !is null ? App.Viewport.AverageFps : 0.0f;

            _gameMode = string(ServerInfo.CurGameModeStr);

            _playground = cast<CSmArenaClient@>(App.CurrentPlayground) !is null;

            _guiPlayer = true
                && _playground
                && App.CurrentPlayground.GameTerminals.Length > 0
                && App.CurrentPlayground.GameTerminals[0] !is null
                && App.CurrentPlayground.GameTerminals[0].GUIPlayer !is null
            ;

            _loading = true
                && App.LoadProgress !is null
                && App.LoadProgress.State != NGameLoadProgress::EState::Disabled
            ;

            _map = App.RootMap !is null;

            _mapInfo.Update();

            _menu = App.ActiveMenus.Length > 0;

            _paused = true
                && Network.PlaygroundClientScriptAPI !is null
                && Network.PlaygroundClientScriptAPI.IsInGameMenuDisplayed
            ;

            _playgroundScript = App.PlaygroundScript !is null;

            _sequence = (true
                && playground
                && App.CurrentPlayground.UIConfigs.Length > 0
                && App.CurrentPlayground.UIConfigs[0] !is null
            )
                ? App.CurrentPlayground.UIConfigs[0].UISequence
                : CGamePlaygroundUIConfig::EUISequence::None
            ;

            if (_guiPlayer) {
                auto GUIPlayer = cast<CSmPlayer@>(App.CurrentPlayground.GameTerminals[0].GUIPlayer);

                _viewingControlled = true
                    && GUIPlayer !is null
                    && GUIPlayer is App.CurrentPlayground.GameTerminals[0].ControlledPlayer
                ;

            } else
                _viewingControlled = false;

            yield();
        }
    }

    /*
    setting this to 0 and comparing against "updated" vars set to uint64(-1)
    causes values to lag by a frame so we init this to 1 and all others to 0
    edit: probably not correct since it happens anyway
    */
    // uint64 _frameCount = 1;
    /*
    number of frames plugin has been active
    used for caching values
    */
    uint64 get_frameCount() {
        // return _frameCount;
        return Dev::GetOffsetUint32(
            GetApp().Viewport,
            Reflection::TypeOf(GetApp().Viewport).GetMember("SystemWindow").Offset + 0x14
        );
    }

    bool _editor = false;
    uint64 _editor_updated = 0;
    /*
    whether we're in an editor
    `App.Editor`
    */
    bool get_editor() {
        if (_editor_updated != frameCount) {
            _editor_updated = frameCount;

            _editor = GetApp().Editor !is null;
        }

        return _editor;
    }

    float _fps = 0.0f;
    uint64 _fps_updated = 0;
    /*
    the current average framerate
    `App.Viewport.AverageFps`
    */
    float get_fps() {
        if (_fps_updated != frameCount) {
            _fps_updated = frameCount;

            CGameCtnApp@ App = GetApp();

            _fps = App.Viewport !is null ? App.Viewport.AverageFps : 0.0f;
        }

        return _fps;
    }

    string _gameMode;
    uint64 _gameMode_updated = 0;
    /*
    the current game mode
    `App.Network.ServerInfo.CurGameModeStr`
    */
    string get_gameMode() {
        if (_gameMode_updated != frameCount) {
            _gameMode_updated = frameCount;

            _gameMode = string(
                cast<CTrackManiaNetworkServerInfo@>(
                    cast<CTrackManiaNetwork@>(
                        GetApp().Network
                    ).ServerInfo
                ).CurGameModeStr
            );
        }

        return _gameMode;
    }

    bool _guiPlayer = false;
    uint64 _guiPlayer_updated = 0;
    /*
    whether there exists a valid GUIPlayer
    `App.CurrentPlayground.GameTerminals[0].GUIPlayer`
    */
    bool get_guiPlayer() {
        if (_guiPlayer_updated != frameCount) {
            _guiPlayer_updated = frameCount;

            CGameCtnApp@ App = GetApp();

            _guiPlayer = true
                && playground
                && App.CurrentPlayground.GameTerminals.Length > 0
                && App.CurrentPlayground.GameTerminals[0] !is null
                && App.CurrentPlayground.GameTerminals[0].GUIPlayer !is null
            ;
        }

        return _guiPlayer;
    }

    bool _loading = false;
    uint64 _loading_updated = 0;
    /*
    whether the game is loading in or out of a map or editor
    `App.LoadProgress.State`
    */
    bool get_loading() {
        if (_loading_updated != frameCount) {
            _loading_updated = frameCount;

            CGameCtnApp@ App = GetApp();

            _loading = true
                && App.LoadProgress !is null
                && App.LoadProgress.State != NGameLoadProgress::EState::Disabled
            ;
        }

        return _loading;
    }

    bool _map = false;
    uint64 _map_updated = 0;
    /*
    whether we're in a map
    `App.RootMap`
    */
    bool get_map() {
        if (_map_updated != frameCount) {
            _map_updated = frameCount;

            _map = GetApp().RootMap !is null;
        }

        return _map;
    }

    Ez2::State::MapInfo@ _mapInfo = Ez2::State::MapInfo();
    uint64 _mapInfo_updated = 0;
    /*
    info on the current map
    `App.RootMap`
    */
    Ez2::State::MapInfo@ get_mapInfo() {
        if (_mapInfo is null)
            @_mapInfo = Ez2::State::MapInfo();

        if (_mapInfo_updated != frameCount) {
            _mapInfo_updated = frameCount;
            _mapInfo.Update();
        }

        return _mapInfo;
    }

    bool _menu = false;
    uint64 _menu_updated = 0;
    /*
    whether the game's menus are shown (not UI layers)
    `App.ActiveMenus`
    */
    bool get_menu() {
        if (_menu_updated != frameCount) {
            _menu_updated = frameCount;

            _menu = GetApp().ActiveMenus.Length > 0;
        }

        return _menu;
    }

    bool _paused = false;
    uint64 _paused_updated = 0;
    /*
    whether the pause menu is shown
    `App.Network.PlaygroundClientScriptAPI.IsInGameMenuDisplayed`
    */
    bool get_paused() {
        if (_paused_updated != frameCount) {
            _paused_updated = frameCount;

            auto Network = cast<CTrackManiaNetwork@>(GetApp().Network);

            _paused = true
                && Network.PlaygroundClientScriptAPI !is null
                && Network.PlaygroundClientScriptAPI.IsInGameMenuDisplayed
            ;
        }

        return _paused;
    }

    bool _playground = false;
    uint64 _playground_updated = 0;
    /*
    whether we're in a drivable map
    `App.CurrentPlayground`
    */
    bool get_playground() {
        if (_playground_updated != frameCount) {
            _playground_updated = frameCount;

            // is a CGamePlaygroundBasic for a few frames on map load so a cast is required
            _playground = cast<CSmArenaClient@>(GetApp().CurrentPlayground) !is null;
        }

        return _playground;
    }

    bool _playgroundScript = false;
    uint64 _playgroundScript_updated = 0;
    /*
    whether there exists a valid playground script
    `App.PlaygroundScript`
    */
    bool get_playgroundScript() {
        if (_playgroundScript_updated != frameCount) {
            _playgroundScript_updated = frameCount;

            _playgroundScript = GetApp().PlaygroundScript !is null;
        }

        return _playgroundScript;
    }

    CGamePlaygroundUIConfig::EUISequence _sequence = CGamePlaygroundUIConfig::EUISequence::None;
    uint64 _sequence_updated = 0;
    /*
    the current UI sequence
    `App.CurrentPlayground.UIConfigs[0].UISequence`
    */
    CGamePlaygroundUIConfig::EUISequence get_sequence() {
        if (_sequence_updated != frameCount) {
            _sequence_updated = frameCount;

            CGameCtnApp@ App = GetApp();

            _sequence = (true
                && playground
                && App.CurrentPlayground.UIConfigs.Length > 0
                && App.CurrentPlayground.UIConfigs[0] !is null
            )
                ? App.CurrentPlayground.UIConfigs[0].UISequence
                : CGamePlaygroundUIConfig::EUISequence::None
            ;
        }

        return _sequence;
    }

    bool _viewingControlled = false;
    uint64 _viewingControlled_updated = 0;
    // whether we're viewing the player
    bool get_viewingControlled() {
        if (_viewingControlled_updated != frameCount) {
            _viewingControlled_updated = frameCount;

            CGameCtnApp@ App = GetApp();

            if (true
                && playground
                && App.CurrentPlayground.GameTerminals.Length > 0
                && App.CurrentPlayground.GameTerminals[0] !is null
            ) {
                auto GUIPlayer = cast<CSmPlayer@>(App.CurrentPlayground.GameTerminals[0].GUIPlayer);

                _viewingControlled = true
                    && GUIPlayer !is null
                    && GUIPlayer is App.CurrentPlayground.GameTerminals[0].ControlledPlayer
                ;

            } else
                _viewingControlled = false;
        }

        return _viewingControlled;
    }
}
