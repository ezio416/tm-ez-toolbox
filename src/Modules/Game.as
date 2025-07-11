// c 2025-06-25
// m 2025-07-09

/*
This module is for getting handles to game objects. The main purpose is to provide a consistent API across different
games.
*/

namespace EzGame {
    CTrackMania@ get_App() {
        VerifyEnabled();
        return cast<CTrackMania>(GetApp());
    }

    CGameCtnEditorFree@ get_Editor() {
        VerifyEnabled();
        return cast<CGameCtnEditorFree>(App.Editor);
    }

    CTrackManiaNetwork@ get_Network() {
        VerifyEnabled();
        return cast<CTrackManiaNetwork>(App.Network);
    }

    CGameCtnChallenge@ get_RootMap() {
        VerifyEnabled();
#if TMNEXT || MP4
        return App.RootMap;
#elif TURBO
        return App.Challenge;
#endif
    }

    CTrackManiaNetworkServerInfo@ get_ServerInfo() {
        VerifyEnabled();
        return cast<CTrackManiaNetworkServerInfo>(Network.ServerInfo);
    }

    CDx11Viewport@ get_Viewport() {
        VerifyEnabled();
        return cast<CDx11Viewport>(App.Viewport);
    }

#if TMNEXT
    CSmArenaClient@ get_Playground() {
        VerifyEnabled();
        return cast<CSmArenaClient>(App.CurrentPlayground);
    }

    CSmArenaRulesMode@ get_PlaygroundScript() {
        VerifyEnabled();
        return cast<CSmArenaRulesMode>(App.PlaygroundScript);
    }

#elif MP4 || TURBO
    CGamePlayground@ get_Playground() {  // CTrackManiaRaceNew, CTrackManiaRace1P, CSmArenaClient, ...
        VerifyEnabled();
        return App.CurrentPlayground;
    }

    CTrackManiaRaceRules@ get_PlaygroundScript() {  // todo: account for shootmania
        VerifyEnabled();
        return cast<CTrackManiaRaceRules>(App.PlaygroundScript);
    }
#endif
}
