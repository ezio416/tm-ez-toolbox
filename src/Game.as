// c 2023-06-04
// m 2025-03-06

namespace EzGame {
    CTrackMania@ App {
        get {
            try   { return cast<CTrackMania@>(GetApp()); }
            catch { return null; }
        }
    }

    CGameManiaAppPlayground@ CMAP {
        get {
            try   { return Network.ClientManiaAppPlayground; }
            catch { return null; }
        }
    }

    string ExeVersion {
        get {
            try   { return App.SystemPlatform.ExeVersion; }
            catch { return ""; }
        }
    }

    CTrackManiaMenus@ Menus {
        get {
            try   { return cast<CTrackManiaMenus@>(App.MenuManager); }
            catch { return null; }
        }
    }

    CTrackManiaNetwork@ Network {
        get {
            try   { return cast<CTrackManiaNetwork@>(App.Network); }
            catch { return null; }
        }
    }

    CSmArenaClient@ Playground {
        get {
            try   { return cast<CSmArenaClient@>(App.CurrentPlayground); }
            catch { return null; }
        }
    }

    CSmArenaRulesMode@ PlaygroundScript {
        get {
            try   { return cast<CSmArenaRulesMode@>(App.PlaygroundScript); }
            catch { return null; }
        }
    }

    CGameCtnChallenge@ RootMap {
        get {
            try   { return App.RootMap; }
            catch { return null; }
        }
    }

    ISceneVis@ Scene {
        get {
            try   { return App.GameScene; }
            catch { return null; }
        }
    }

    CGamePlaygroundUIConfig::EUISequence Sequence {
        get {
            try   { return Playground.UIConfigs[0].UISequence; }
            catch { return CGamePlaygroundUIConfig::EUISequence::None; }
        }
    }

    CTrackManiaNetworkServerInfo@ ServerInfo {
        get {
            try   { return cast<CTrackManiaNetworkServerInfo@>(Network.ServerInfo); }
            catch { return null; }
        }
    }
}
