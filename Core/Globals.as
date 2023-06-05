/*
c 2023-06-04
m 2023-06-04
*/

namespace Globals {
    CTrackMania@ App {
        get {
            try   { return cast<CTrackMania@>(GetApp()); }
            catch { return null; }
        }
    }

    CTrackManiaNetwork@ Network {
        get {
            try   { return cast<CTrackManiaNetwork@>(App.Network); }
            catch { return null; }
        }
    }

    CTrackManiaNetworkServerInfo@ ServerInfo {
        get {
            try   { return cast<CTrackManiaNetworkServerInfo>(Network.ServerInfo); }
            catch { return null; }
        }
    }

    CSmArenaClient@ Playground {
        get {
            try   { return cast<CSmArenaClient>(App.CurrentPlayground); }
            catch { return null; }
        }
    }

    CGamePlaygroundUIConfig::EUISequence Sequence {
        get {
            try   { return Playground.UIConfigs[0].UISequence; }
            catch { return CGamePlaygroundUIConfig::EUISequence::None; }
        }
    }

    CSmArenaRulesMode@ PlaygroundScript {
        get {
            try   { return cast<CSmArenaRulesMode@>(App.PlaygroundScript); }
            catch { return null; }
        }
    }
}