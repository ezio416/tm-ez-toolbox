// c 2025-03-27
// m 2025-06-25

[Setting category="Menu Info" name="Enabled"]
bool S_MenuInfo = false;

[Setting category="Menu Info" name="Padding between elements" min=1 max=100 if="S_MenuInfo"]
uint S_MenuInfo_Padding = 5;

[Setting category="Menu Info" name="Show icons" if="S_MenuInfo"]
bool S_MenuInfo_Icons = true;

[Setting category="Menu Info" name="FPS" if="S_MenuInfo"]
bool S_MenuInfo_FPS = true;

[Setting category="Menu Info" name="Clock" if="S_MenuInfo"]
bool S_MenuInfo_Clock = true;


[Setting category="Debug" hidden]
bool S_Debug = false;

[Setting category="Debug" hidden]
bool S_Debug_HideWithGame = true;

[Setting category="Debug" hidden]
bool S_Debug_HideWithOP = true;

#if MANIA64
[Setting category="Debug" hidden]
bool S_Debug_64bit = false;
#endif

[SettingsTab name="Debug" icon="Bug" order=1]
void SettingsTab_Debug() {
#if !SIG_DEVELOPER
    UI::Text("Switch to developer mode to show debug settings");
    S_Debug = false;
#else
    if (UI::Button("Reset to default##debug")) {
        Meta::PluginSetting@[]@ settings = pluginMeta.GetSettings();
        for (uint i = 0; i < settings.Length; i++) {
            if (settings[i].Category == "Debug") {
                settings[i].Reset();
            }
        }
    }

    S_Debug = UI::Checkbox("Enabled", S_Debug);

    if (S_Debug) {
        S_Debug_HideWithGame = UI::Checkbox("Show/hide with game UI", S_Debug_HideWithGame);
        S_Debug_HideWithOP = UI::Checkbox("Show/hide with Openplanet UI", S_Debug_HideWithOP);
#if MANIA64
        S_Debug_64bit = UI::Checkbox("Use 64-bit values for raw offsets (includes pointers)", S_Debug_64bit);
#endif
    }
#endif
}
