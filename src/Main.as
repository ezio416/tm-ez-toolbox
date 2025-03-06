// c 2023-06-04
// m 2025-03-06

bool          canPlayLocalMaps = false;
const string  pluginColor      = "\\$6F6";
const string  pluginIcon       = Icons::Wrench;
Meta::Plugin@ pluginMeta       = Meta::ExecutingPlugin();
const string  pluginTitle      = pluginColor + pluginIcon + "\\$G " + pluginMeta.Name;

void Main() {
#if TMNEXT
    canPlayLocalMaps = Permissions::PlayLocalMap();
    if (!canPlayLocalMaps)
        warn("Starter Access detected, functionality is limited");
#else
    canPlayLocalMaps = true;
#endif

#if !DEPENDENCY_MLHOOK
    warn("MLHook not found, functionality is limited");
#endif
}

void Render() {
    if (false
        || !S_DebugEnabled
        || (S_DebugHideWithGame && !UI::IsGameUIVisible())
        || (S_DebugHideWithOP && !UI::IsOverlayShown())
    )
        return;

    if (UI::Begin(pluginTitle + " (Debug)", S_DebugEnabled, UI::WindowFlags::NoFocusOnAppearing))
        RenderDebug();
    UI::End();
}

void RenderMenuMain() {
    MenuInfo::Render();
}
