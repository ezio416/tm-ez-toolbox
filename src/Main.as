// c 2025-03-29
// m 2025-06-12

const string  pluginColor = "\\$0A0";
const string  pluginIcon  = Icons::Wrench;
Meta::Plugin@ pluginMeta  = Meta::ExecutingPlugin();
const string  pluginTitle = pluginColor + pluginIcon + "\\$G " + pluginMeta.Name;

/*
when plugin is unloaded
stops coroutines and garbage collects everything
not yieldable
*/
void OnDestroyed() {
    // CleanUp("destroyed");
}

/*
when plugin is disabled
pauses coroutines
not yieldable
*/
// void OnDisabled() {
//     // CleanUp("disabled");

//     Ez2::_frameCount = 0;

//     Ez2::_editor = false;
//     Ez2::_editor_updated = uint(-1);

//     Ez2::_fps = 0.0f;
//     Ez2::_fps_updated = uint(-1);

//     Ez2::_gameMode = "";
//     Ez2::_gameMode_updated = uint(-1);

//     Ez2::_map = false;
//     Ez2::_map_updated = uint(-1);

//     Ez2::_playground = false;
//     Ez2::_playground_updated = uint(-1);

//     Ez2::_playgroundScript = false;
//     Ez2::_playgroundScript_updated = uint(-1);

//     Ez2::_sequence = CGamePlaygroundUIConfig::EUISequence::None;
//     Ez2::_sequence_updated = uint(-1);

//     ;
// }

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

// UI::InputBlocking OnKeyPress(bool down, VirtualKey key) {
//     if (!down || (key != VirtualKey::LButton && key != VirtualKey::Return))
//         return UI::InputBlocking::DoNothing;

//     // if (!Ez2::state.playingMap)
//     //     return UI::InputBlocking::DoNothing;

//     print("key pressed: " + tostring(key));
//     return UI::InputBlocking::DoNothing;
// }

// UI::InputBlocking OnMouseButton(bool down, int button, int x, int y) {
//     if (!down)
//         return UI::InputBlocking::DoNothing;

//     print("mouse blicked: " + tostring(button));
//     return UI::InputBlocking::DoNothing;
// }

/*
when plugin is loaded
could also be thought of as OnCreated to oppose OnDestroyed
yieldable (is ran as a coroutine by the engine)
*/
void Main() {
    // print("\\$F0FViewport at " + Text::FormatPointer(GetPtrForNod(GetApp().Viewport)));
    Config::Request();
    FrameCount::Start();
}

void Render() {
    if (false
        or !S_Enabled
        or (S_HideWithGame && !UI::IsGameUIVisible())
        or (S_HideWithOP && !UI::IsOverlayShown())
    ) {
        return;
    }

    if (UI::Begin(
        pluginTitle + "\\$888 (debug)###eztoolbox-debug",
        S_Enabled,
        UI::WindowFlags::AlwaysAutoResize
    )) {
        RenderDebugContents();
    }
    UI::End();
}

void RenderMenu() {
    if (UI::MenuItem(pluginTitle, "", S_Enabled)) {
        S_Enabled = !S_Enabled;
    }
}

// void Update(float) {
//     Ez2::_frameCount++;
// }

// void IncrementAsync() {
//     while (true) {
//         Ez2::_frameCount++;
//         yield();
//     }
// }
