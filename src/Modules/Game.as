// c 2025-06-25
// m 2025-07-12

/*
This module is for getting handles to game objects as well as interacting with the game directly.
The main purpose is to provide a consistent API across different games.
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

namespace EzGame {
    void EditMap(const string&in url) {
        startnew(EditMapAsync, url);
    }

    void EditMapAsync(const string&in url) {
#if TMNEXT
        if (!Permissions::OpenAdvancedMapEditor()) {
            warn("can't edit map: player doesn't have permission");
            return;
        }
#endif

        if (url.Length == 0) {
            warn("can't edit map: url is blank");
            return;
        }

        trace("editing map from url: " + url);

        ReturnToMainMenu();

        WaitReadyAsync();
#if TMNEXT || MP4
        cast<CTrackMania>(GetApp()).ManiaTitleControlScriptAPI.EditMap(url, "", "");
#elif TURBO
        ;
#endif
        WaitReadyAsync();
    }

    void PlayMap(const string&in url) {
        startnew(PlayMapAsync, url);
    }

    void PlayMapAsync(const string&in url) {
#if TMNEXT
        if (!Permissions::PlayLocalMap()) {
            warn("can't play map: player doesn't have permission");
            return;
        }
#endif

        if (url.Length == 0) {
            warn("can't play map: url is blank");
            return;
        }

        trace("playing map from url: " + url);

        ReturnToMainMenu();

        WaitReadyAsync();
#if TMNEXT || MP4
        cast<CTrackMania>(GetApp()).ManiaTitleControlScriptAPI.PlayMap(url, "TrackMania/TM_PlayMap_Local", "");
#elif TURBO
        ;
#endif
        WaitReadyAsync();
    }

    void ReturnToMainMenu() {
        auto App = cast<CTrackMania>(GetApp());

#if TMNEXT || MP4
        if (App.Network.PlaygroundClientScriptAPI.IsInGameMenuDisplayed) {
            App.Network.PlaygroundInterfaceScriptHandler.CloseInGameMenu(
                CGameScriptHandlerPlaygroundInterface::EInGameMenuResult::Quit
            );
        }
#endif

        App.BackToMainMenu();
    }

    void WaitReadyAsync() {
#if TMNEXT || MP4
        auto App = cast<CTrackMania>(GetApp());
        while (!App.ManiaTitleControlScriptAPI.IsReady) {
            yield();
        }
#endif
    }
}
