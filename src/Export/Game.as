// c 2025-03-06
// m 2025-03-09

namespace Ez {  // EzGame
    CTrackMania@                         _App;
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

    CTrackMania@                         get_App()              { CheckEnabled(); return _App;              }
    CGameCtnEditorFree@                  get_Editor()           { CheckEnabled(); return _Editor;           }
    string                               get_ExeVersion()       { CheckEnabled(); return _ExeVersion;       }
    string                               get_GameMode()         { CheckEnabled(); return _GameMode;         }
    CTrackManiaNetwork@                  get_Network()          { CheckEnabled(); return _Network;          }
    CGameCtnChallenge@                   get_RootMap()          { CheckEnabled(); return _RootMap;          }
    CGamePlaygroundUIConfig::EUISequence get_Sequence()         { CheckEnabled(); return _Sequence;         }
    CTrackManiaNetworkServerInfo@        get_ServerInfo()       { CheckEnabled(); return _ServerInfo;       }
    CDx11Viewport@                       get_Viewport()         { CheckEnabled(); return _Viewport;         }
#if TMNEXT
    CSmArenaClient@                      get_Playground()       { CheckEnabled(); return _Playground;       }
    CSmArenaRulesMode@                   get_PlaygroundScript() { CheckEnabled(); return _PlaygroundScript; }
#elif MP4
    CGamePlayground@                     get_Playground()       { CheckEnabled(); return _Playground;       }
    CTrackManiaRaceRules@                get_PlaygroundScript() { CheckEnabled(); return _PlaygroundScript; }
#elif TURBO
    CGamePlayground@                     get_Playground()       { CheckEnabled(); return _Playground;       }
    CTrackManiaRaceRules@                get_PlaygroundScript() { CheckEnabled(); return _PlaygroundScript; }
#endif

    void Update() {
        if (!enabled) {
            @_App              = null;
            @_Editor           = null;
            _GameMode          = "";
            @_Network          = null;
            @_RootMap          = null;
            _Sequence          = CGamePlaygroundUIConfig::EUISequence::None;
            @_ServerInfo       = null;
            @_Viewport         = null;
#if TMNEXT
            _ExeVersion        = "";
            @_Playground       = null;
            @_PlaygroundScript = null;
#elif MP4
            @_Playground       = null;
            @_PlaygroundScript = null;
#elif TURBO
            @_Playground       = null;
            @_PlaygroundScript = null;
#endif
            return;
        }

        @_App = cast<CTrackMania@>(GetApp());
        @_Editor = cast<CGameCtnEditorFree@>(_App.Editor);
        @_Network = cast<CTrackManiaNetwork@>(_App.Network);
        @_ServerInfo = cast<CTrackManiaNetworkServerInfo@>(_Network.ServerInfo);
        @_Viewport = cast<CDx11Viewport@>(_App.Viewport);
#if TMNEXT
        _ExeVersion = _App.SystemPlatform.ExeVersion;
        @_Playground = cast<CSmArenaClient@>(_App.CurrentPlayground);
        @_PlaygroundScript = cast<CSmArenaRulesMode@>(_App.PlaygroundScript);
        @_RootMap = _App.RootMap;
#elif MP4
        @_Playground = _App.CurrentPlayground;
        @_PlaygroundScript = cast<CTrackManiaRaceRules@>(_App.PlaygroundScript);
        @_RootMap = _App.RootMap;
#elif TURBO
        @_Playground = _App.CurrentPlayground;
        @_PlaygroundScript = cast<CTrackManiaRaceRules@>(_App.PlaygroundScript);
        @_RootMap = _App.Challenge;
#endif
        _GameMode = _ServerInfo !is null ? string(_ServerInfo.CurGameModeStr) : "";
        _Sequence = _Playground !is null && _Playground.UIConfigs.Length > 0
            ? _Playground.UIConfigs[0].UISequence
            : CGamePlaygroundUIConfig::EUISequence::None;
    }

    void UpdateAsync() {
        while (true) {
            Update();
            yield();
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
