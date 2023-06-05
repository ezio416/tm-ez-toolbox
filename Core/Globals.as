/*
c 2023-06-04
m 2023-06-04
*/

namespace Globals {
    auto App = cast<CTrackMania@>(GetApp());
    auto Network = cast<CTrackManiaNetwork@>(App.Network);

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

    CTrackManiaNetworkServerInfo@ ServerInfo {
        get {
            try   { return cast<CTrackManiaNetworkServerInfo>(Network.ServerInfo); }
            catch { return null; }
        }
    }

    CSmArenaRulesMode@ PlaygroundScript {
        get {
            return cast<CSmArenaRulesMode@>(App.PlaygroundScript);
        }
    }
}