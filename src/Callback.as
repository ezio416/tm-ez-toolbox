// c 2025-04-03
// m 2025-06-24

namespace Ez2 {
    dictionary@ callbacks_OnEnteredMap = dictionary();

    void RegisterCallback_OnEnteredMap(CallbackFunc@ c) {
        const string executing = Meta::ExecutingPlugin().ID;

        if (c is null) {
            warn("plugin '" + executing + "' tried to register a null callback for OnEnteredMap");
            return;
        }

        callbacks_OnEnteredMap.Set(executing, @c);
    }

    void OnEnteredMap() {
        string[]@ pluginNames = callbacks_OnEnteredMap.GetKeys();
        string pluginName;

        for (uint i = 0; i < pluginNames.Length; i++) {
            pluginName = pluginNames[i];

            try {
                trace("OnEnteredMap: '" + pluginName + "'");
                cast<CallbackFunc>(callbacks_OnEnteredMap[pluginName])();
            } catch {
                error("error in OnEnteredMap for '" + pluginName + "': " + getExceptionInfo());
            }
        }
    }
}
