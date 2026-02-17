// c 2023-06-04
// m 2025-03-06

namespace EzGame {
    CTrackMania@ App {
        get { return cast<CTrackMania@>(GetApp()); }
    }

    CGameManiaAppPlayground@ CMAP {
        get { return Network.ClientManiaAppPlayground; }
    }

#if TMNEXT
    string ExeVersion {
        get {
            try   { return App.SystemPlatform.ExeVersion; }
            catch { return ""; }
        }
    }
#endif

    string GameMode {
        get {
            try   { return string(ServerInfo.CurGameModeStr); }
            catch { return ""; }
        }
    }

    CTrackManiaMenus@ Menus {
        get { return cast<CTrackManiaMenus@>(App.MenuManager); }
    }

    CTrackManiaNetwork@ Network {
        get { return cast<CTrackManiaNetwork@>(App.Network); }
    }

#if TMNEXT
    CSmArenaClient@ Playground {
        get { return cast<CSmArenaClient@>(App.CurrentPlayground); }
    }
#elif MP4 || TURBO
    CGamePlayground@ Playground {  // CTrackManiaRaceNew, ...
        get { return App.CurrentPlayground; }
    }
#endif

#if TMNEXT
    CSmArenaRulesMode@ PlaygroundScript {
        get { return cast<CSmArenaRulesMode@>(App.PlaygroundScript); }
    }
#elif MP4 || TURBO
    CTrackManiaRaceRules@ PlaygroundScript {
        get { return cast<CTrackManiaRaceRules@>(App.PlaygroundScript); }
    }
#endif

    CGameCtnChallenge@ RootMap {
#if TMNEXT || MP4
        get { return App.RootMap; }
#elif TURBO
        get { return App.Challenge; }
#endif
    }

#if TMNEXT
    ISceneVis@ Scene {
        get { return App.GameScene; }
    }
#elif MP4 || TURBO
    CGameScene@ Scene {
        get { return App.GameScene; }
    }
#endif

    CGamePlaygroundUIConfig::EUISequence Sequence {
        get {
            try   { return Playground.UIConfigs[0].UISequence; }
            catch { return CGamePlaygroundUIConfig::EUISequence::None; }
        }
    }

    CTrackManiaNetworkServerInfo@ ServerInfo {
        get { return cast<CTrackManiaNetworkServerInfo@>(Network.ServerInfo); }
    }
}
