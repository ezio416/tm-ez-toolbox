// c 2023-06-04
// m 2025-03-09

bool          enabled     = true;
const string  pluginColor = "\\$6F6";
const string  pluginIcon  = Icons::Wrench;
Meta::Plugin@ pluginMeta  = Meta::ExecutingPlugin();
const string  pluginTitle = pluginColor + pluginIcon + "\\$G " + pluginMeta.Name;

void Main() {
    Ez::Update();  // need to update this frame to prevent exceptions
    startnew(Ez::UpdateAsync);

#if TMNEXT
    if (!Permissions::PlayLocalMap())
        warn("Starter Access detected, functionality is limited");
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

void Update(float) {
#if TMNEXT
#if DEPENDENCY_MLHOOK
    enabled = true;
#else
    if (enabled) {
        enabled = false;
        const string msg = "MLHook is required. Install it from Plugin Manager at the top. You may need to reload some plugins afterwards.";
        UI::ShowNotification(pluginTitle, msg, vec4(1.0f, 0.0f, 0.0f, 0.8f), 15000);
        throw(msg);
    }
#endif
#endif
}
