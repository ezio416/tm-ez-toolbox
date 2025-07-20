// c 2025-03-29
// m 2025-07-20

const string  pluginColor = "\\$0A0";
const string  pluginIcon  = Icons::Wrench;
Meta::Plugin@ pluginMeta  = Meta::ExecutingPlugin();
const string  pluginTitle = pluginColor + pluginIcon + "\\$G " + pluginMeta.Name;

void OnDestroyed() {
    EzCallback::callbacks.DeleteAll();
}

void Main() {
    EzCallback::Verify();
    EzCallback::WatchForMapChange();

    startnew(EzLayers::Menu::LoopAsync);
    startnew(EzLayers::Playground::LoopAsync);
}

void Render() {
    Debug::Render();
}

void RenderMenu() {
    if (UI::BeginMenu(pluginTitle)) {
        if (UI::MenuItem(Icons::Bug + " Debug Window", "", S_Debug)) {
            S_Debug = !S_Debug;
        }

        UI::EndMenu();
    }
}

void RenderMenuMain() {
    MenuInfo::Render();
}
