// c 2025-03-29
// m 2025-04-03

const string   pluginColor = "\\$0A0";
const string   pluginIcon  = Icons::Wrench;
Meta::Plugin@  pluginMeta  = Meta::ExecutingPlugin();
const string   pluginTitle = pluginColor + pluginIcon + "\\$G " + pluginMeta.Name;
InternalState@ _state;

/*
when plugin is unloaded
stops coroutines and garbage collects everything
not yieldable
*/
void OnDestroyed() {
    CleanUp("destroyed");
}

/*
when plugin is disabled
pauses coroutines
not yieldable
*/
void OnDisabled() {
    CleanUp("disabled");
}

/*
when plugin is enabled, except if it was reloaded while it was disabled
resumes coroutines
not yieldable
*/
// void OnEnabled() {
//     print("welcome back!");
//     // stop = false;
//     startnew(Main);
// }

UI::InputBlocking OnKeyPress(bool down, VirtualKey key) {
    if (!down || (key != VirtualKey::LButton && key != VirtualKey::Return))
        return UI::InputBlocking::DoNothing;

    if (!Ez2::state.playingMap)
        return UI::InputBlocking::DoNothing;

    print("key pressed: " + tostring(key));
        return UI::InputBlocking::DoNothing;
}

/*
when plugin is loaded
could also be thought of as OnCreated to oppose OnDestroyed
yieldable (is ran as a coroutine by the engine)
*/
void Main() {
    trace("new state loop");

    auto App = cast<CTrackMania@>(GetApp());
    auto Network = cast<CTrackManiaNetwork@>(App.Network);
    auto ServerInfo = cast<CTrackManiaNetworkServerInfo@>(Network.ServerInfo);

    Ez2::state;

    while (true) {
        _state.gameMode = string(ServerInfo.CurGameModeStr);

        _state.inEditor = App.Editor !is null;
        _state.inMap = App.RootMap !is null;
        _state.inMenu = App.ActiveMenus.Length > 0;
        _state.inPlayground = App.CurrentPlayground !is null;

        _state.loading = true
            && App.LoadProgress !is null
            && App.LoadProgress.State != NGameLoadProgress::EState::Disabled
        ;

        _state.fps = App.Viewport !is null ? App.Viewport.AverageFps : 0.0f;

        if (_state.inMap) {
            _state.mapType    = App.RootMap.MapType;
            _state.mapUid     = App.RootMap.EdChallengeId;
            _state.authorTime = App.RootMap.TMObjective_AuthorTime;
            _state.bronzeTime = App.RootMap.TMObjective_BronzeTime;
            _state.goldTime   = App.RootMap.TMObjective_GoldTime;
            _state.silverTime = App.RootMap.TMObjective_SilverTime;
        } else {
            _state.mapType    = "";
            _state.mapUid     = "";
            _state.authorTime = 0;
            _state.bronzeTime = 0;
            _state.goldTime   = 0;
            _state.silverTime = 0;
        }

        _state.guiPlayer = true
            && _state.inPlayground
            && App.CurrentPlayground.GameTerminals.Length > 0
            && App.CurrentPlayground.GameTerminals[0] !is null
            && cast<CSmPlayer@>(App.CurrentPlayground.GameTerminals[0].GUIPlayer) !is null
        ;

        _state.paused = true
            && App.Network.PlaygroundClientScriptAPI !is null
            && App.Network.PlaygroundClientScriptAPI.IsInGameMenuDisplayed
        ;

        _state.playgroundScript = App.PlaygroundScript !is null;

        _state.sequence = (true
            && _state.inPlayground
            && App.CurrentPlayground.UIConfigs.Length > 0
            && App.CurrentPlayground.UIConfigs[0] !is null
        )
            ? App.CurrentPlayground.UIConfigs[0].UISequence
            : CGamePlaygroundUIConfig::EUISequence::None
        ;

        CSmPlayer@ ViewingPlayer;
        if (_state.inPlayground)
            @ViewingPlayer = VehicleState::GetViewingPlayer();

        _state.viewingLogin = (true
            && ViewingPlayer !is null
            && ViewingPlayer.ScriptAPI !is null
        )
            ? ViewingPlayer.ScriptAPI.Login
            : ""
        ;

        yield();
    }

    warn("state loop broke!");
    CleanUp();
    startnew(Main);
}

void Render() {
    if (false
        || !S_Enabled
        || (S_HideWithGame && !UI::IsGameUIVisible())
        || (S_HideWithOP && !UI::IsOverlayShown())
    )
        return;

    if (UI::Begin(
        pluginTitle + "\\$888 (debug)###eztoolbox-debug",
        S_Enabled,
        UI::WindowFlags::AlwaysAutoResize
    ))
        RenderDebugContents();

    UI::End();
}

void RenderMenu() {
    if (UI::MenuItem(pluginTitle, "", S_Enabled))
        S_Enabled = !S_Enabled;
}
