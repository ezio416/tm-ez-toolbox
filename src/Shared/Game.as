// c 2025-06-25
// m 2025-07-13

/*
Gets handles to game objects and interacts with the game directly.
The main purpose is to provide a consistent API across different games.
*/
namespace EzGame {
    shared CTrackManiaNetwork@ get_Network() {
        return cast<CTrackManiaNetwork>(GetApp().Network);
    }

    shared CGameCtnChallenge@ get_RootMap() {
#if TMNEXT || MP4
        return GetApp().RootMap;
#elif TURBO
        return GetApp().Challenge;
#endif
    }

    shared CTrackManiaNetworkServerInfo@ get_ServerInfo() {
        return cast<CTrackManiaNetworkServerInfo>(Network.ServerInfo);
    }

    shared CDx11Viewport@ get_Viewport() {
        return cast<CDx11Viewport>(GetApp().Viewport);
    }

#if TMNEXT
    shared CSmArenaClient@ get_Playground() {
        return cast<CSmArenaClient>(GetApp().CurrentPlayground);
    }

    shared CSmArenaRulesMode@ get_PlaygroundScript() {
        return cast<CSmArenaRulesMode>(GetApp().PlaygroundScript);
    }

#elif MP4 || TURBO
    shared CGamePlayground@ get_Playground() {  // CTrackManiaRaceNew, CTrackManiaRace1P, CSmArenaClient, ...
        return GetApp().CurrentPlayground;
    }

    shared CTrackManiaRaceRules@ get_PlaygroundScript() {  // todo: account for shootmania
        return cast<CTrackManiaRaceRules>(GetApp().PlaygroundScript);
    }
#endif
}

namespace EzGame {
    shared void EditMap(const string&in url) {
        startnew(EditMapAsync, url);
    }

    shared void EditMapAsync(const string&in url) {
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

    shared void PlayMap(const string&in url) {
        startnew(PlayMapAsync, url);
    }

    shared void PlayMapAsync(const string&in url) {
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

    shared void ReturnToMainMenu() {
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

    shared void WaitReadyAsync() {
#if TMNEXT || MP4
        auto App = cast<CTrackMania>(GetApp());
        while (!App.ManiaTitleControlScriptAPI.IsReady) {
            yield();
        }
#endif
    }
}
