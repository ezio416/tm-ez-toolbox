// c 2025-03-06
// m 2025-03-06

namespace EzGame {
    CGameCtnEditorFree@                  _Editor;
    string                               _GameMode;
    CTrackManiaNetwork@                  _Network;
    CGameCtnChallenge@                   _RootMap;
    CGamePlaygroundUIConfig::EUISequence _Sequence;
    CTrackManiaNetworkServerInfo@        _ServerInfo;
    CDx11Viewport@                       _Viewport;
#if TMNEXT
    string                               _ExeVersion;
    CSmArenaClient@                      _Playground;
    CSmArenaRulesMode@                   _PlaygroundScript;
#elif MP4
    CGamePlayground@                     _Playground;  // CTrackManiaRaceNew, ...
    CTrackManiaRaceRules@                _PlaygroundScript;
#elif TURBO
    CGamePlayground@                     _Playground;  // CTrackManiaRaceNew, ...
    CTrackManiaRaceRules@                _PlaygroundScript;
#endif

    CGameCtnEditorFree@                  get_Editor()           { return _Editor;           }
    string                               get_ExeVersion()       { return _ExeVersion;       }
    string                               get_GameMode()         { return _GameMode;         }
    CTrackManiaNetwork@                  get_Network()          { return _Network;          }
    CGameCtnChallenge@                   get_RootMap()          { return _RootMap;          }
    CGamePlaygroundUIConfig::EUISequence get_Sequence()         { return _Sequence;         }
    CTrackManiaNetworkServerInfo@        get_ServerInfo()       { return _ServerInfo;       }
    CDx11Viewport@                       get_Viewport()         { return _Viewport;         }
#if TMNEXT
    CSmArenaClient@                      get_Playground()       { return _Playground;       }
    CSmArenaRulesMode@                   get_PlaygroundScript() { return _PlaygroundScript; }
#elif MP4
    CGamePlayground@                     get_Playground()       { return _Playground;       }
    CTrackManiaRaceRules@                get_PlaygroundScript() { return _PlaygroundScript; }
#elif TURBO
    CGamePlayground@                     get_Playground()       { return _Playground;       }
    CTrackManiaRaceRules@                get_PlaygroundScript() { return _PlaygroundScript; }
#endif

    void Update() {
        CTrackMania@ App = cast<CTrackMania@>(GetApp());

        @_Editor = cast<CGameCtnEditorFree@>(App.Editor);
        @_Network = cast<CTrackManiaNetwork@>(App.Network);
        @_ServerInfo = cast<CTrackManiaNetworkServerInfo@>(_Network.ServerInfo);
        @_Viewport = cast<CDx11Viewport@>(App.Viewport);
#if TMNEXT
        _ExeVersion = App.SystemPlatform.ExeVersion;
        @_Playground = cast<CSmArenaClient@>(App.CurrentPlayground);
        @_PlaygroundScript = cast<CSmArenaRulesMode@>(App.PlaygroundScript);
        @_RootMap = App.RootMap;
#elif MP4
        @_Playground = App.CurrentPlayground;
        @_PlaygroundScript = cast<CTrackManiaRaceRules@>(App.PlaygroundScript);
        @_RootMap = App.RootMap;
#elif TURBO
        @_Playground = App.CurrentPlayground;
        @_PlaygroundScript = cast<CTrackManiaRaceRules@>(App.PlaygroundScript);
        @_RootMap = App.Challenge;
#endif
        _GameMode = _ServerInfo !is null ? string(_ServerInfo.CurGameModeStr) : "";
        _Sequence = _Playground !is null && _Playground.UIConfigs.Length > 0
            ? _Playground.UIConfigs[0].UISequence
            : CGamePlaygroundUIConfig::EUISequence::None;
    }

    void UpdateAsync() {
        while (true) {
            yield();
            Update();
        }
    }

#if TMNEXT
    bool PlayMapAsync(const string &in uid) {
        if (!Permissions::PlayLocalMap())
            return false;
        return true;
    }
#endif
}
