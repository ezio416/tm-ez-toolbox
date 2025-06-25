// c 2025-03-29
// m 2025-06-25

const string  pluginColor = "\\$0A0";
const string  pluginIcon  = Icons::Wrench;
Meta::Plugin@ pluginMeta  = Meta::ExecutingPlugin();
const string  pluginTitle = pluginColor + pluginIcon + "\\$G " + pluginMeta.Name;

void OnDestroyed() {
    Ez::callbacks.DeleteAll();
    Ez::ResetState();
}

void Main() {
    Config::Request();
    FrameCount::Start();
    Ez::InitStatic();

    Ez::VerifyCallbacks();
    Ez::WatchForMapChange();
}

void Render() {
    Debug::Render();
}

void RenderMenuMain() {
    MenuInfo::Render();
}
