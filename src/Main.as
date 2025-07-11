// c 2025-03-29
// m 2025-07-09

const string  pluginColor = "\\$0A0";
const string  pluginIcon  = Icons::Wrench;
Meta::Plugin@ pluginMeta  = Meta::ExecutingPlugin();
const string  pluginTitle = pluginColor + pluginIcon + "\\$G " + pluginMeta.Name;

void OnDestroyed() {
    EzCallback::callbacks.DeleteAll();

    EzState::ResetState();
}

void Main() {
    Config::Request();

    EzStatic::Init();

    FrameCount::Start();

    EzCallback::Verify();
    EzCallback::WatchForMapChange();
}

void Render() {
    Debug::Render();
}

void RenderMenuMain() {
    MenuInfo::Render();
}
