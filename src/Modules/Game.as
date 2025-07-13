// c 2025-06-25
// m 2025-07-12

/*
This module is for getting handles to game objects. The main purpose is to provide a consistent API across different
games.
*/

namespace EzGame {
    CTrackManiaNetwork@ get_Network() {
        VerifyEnabled();
        return cast<CTrackManiaNetwork>(GetApp().Network);
    }

    CGameCtnChallenge@ get_RootMap() {
        VerifyEnabled();
#if TMNEXT || MP4
        return GetApp().RootMap;
#elif TURBO
        return GetApp().Challenge;
#endif
    }

    CTrackManiaNetworkServerInfo@ get_ServerInfo() {
        VerifyEnabled();
        return cast<CTrackManiaNetworkServerInfo>(Network.ServerInfo);
    }

    CDx11Viewport@ get_Viewport() {
        VerifyEnabled();
        return cast<CDx11Viewport>(GetApp().Viewport);
    }

#if TMNEXT
    CSmArenaClient@ get_Playground() {
        VerifyEnabled();
        return cast<CSmArenaClient>(GetApp().CurrentPlayground);
    }

    CSmArenaRulesMode@ get_PlaygroundScript() {
        VerifyEnabled();
        return cast<CSmArenaRulesMode>(GetApp().PlaygroundScript);
    }

#elif MP4 || TURBO
    CGamePlayground@ get_Playground() {  // CTrackManiaRaceNew, CTrackManiaRace1P, CSmArenaClient, ...
        VerifyEnabled();
        return GetApp().CurrentPlayground;
    }

    CTrackManiaRaceRules@ get_PlaygroundScript() {  // todo: account for shootmania
        VerifyEnabled();
        return cast<CTrackManiaRaceRules>(GetApp().PlaygroundScript);
    }
#endif
}
