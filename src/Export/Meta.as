// c 2025-03-07
// m 2025-03-09

namespace Ez {  // EzMeta
    bool Enabled() {
        return enabled && pluginMeta.Enabled;
    }
}

Json::Value@ plugins = Json::Object();

void CheckEnabled() {
    if (!Ez::EzMeta::Enabled())
        throw("toolbox is closed");
}

Json::Value@ GetPluginValue(const string &in key, Json::Type type = Json::Type::Object) {
    CheckEnabled();

    Meta::Plugin@ executing = Meta::ExecutingPlugin();
    Json::Value@ plugin = Ez::EzJson::GetValue(plugins, executing.ID);
    return Ez::EzJson::GetValue(plugin, key, type);
}

void SetPluginValue(const string &in key, Json::Value@ value) {
    CheckEnabled();

    Meta::Plugin@ executing = Meta::ExecutingPlugin();
    Json::Value@ plugin = plugins[executing.ID];  // creates key if not exists
    plugin[key] = value;
}
