// c 2025-04-03
// m 2025-07-14

/*
This module provides a way for plugins to register callback functions that can be called automatically under certain
conditions. When these functions are called, the ownership of the function (original plugin that defined it) is lost,
so that must be kept in mind when designing them. For example, if a plugin registers a function for 'OnEnteredMap',
it will be called with 'EzToolbox' as the executing plugin. I'm not sure of a way around this.

I've opted to instead do callbacks with methods in an abstract class which does not fix the issue above but does
significantly cut down on the code I have to write.
*/

/*
Allows plugins to register callback functions that will be called under certain conditions.
*/
namespace EzCallback {
    dictionary@ callbacks = dictionary();

    void Deregister() {
        Deregister(Meta::ExecutingPlugin());
    }

    void Deregister(const string&in pluginId) {
        if (true
            and pluginId != pluginMeta.ID
            and callbacks.Exists(pluginId)
        ) {
            callbacks.Delete(pluginId);
            trace("deregistered callback in EzToolbox");
        }
    }

    void Deregister(Meta::Plugin@ plugin) {
        if (true
            and plugin !is null
            and plugin !is pluginMeta
        ) {
            Deregister(plugin.ID);
        }
    }

    void OnEnteredMap() {
        trace("OnEnteredMap");

        string[]@ pluginIds = callbacks.GetKeys();
        for (uint i = 0; i < pluginIds.Length; i++) {
            try {
                cast<Callback>(callbacks[pluginIds[i]])._OnEnteredMap();
            } catch {
                error("error in OnEnteredMap for '" + pluginIds[i] + "': " + getExceptionInfo());
                PrintActiveContextStack(true);
            }
        }
    }

    void OnExitedMap() {
        trace("OnExitedMap");

        string[]@ pluginIds = callbacks.GetKeys();
        for (uint i = 0; i < pluginIds.Length; i++) {
            try {
                cast<Callback>(callbacks[pluginIds[i]])._OnExitedMap();
            } catch {
                error("error in OnExitedMap for '" + pluginIds[i] + "': " + getExceptionInfo());
                PrintActiveContextStack(true);
            }
        }
    }

    void Register(Callback@ c) {
        Meta::Plugin@ plugin = Meta::ExecutingPlugin();
        if (plugin is pluginMeta) {
            throw("ezio you idiot");
            return;
        }

        if (c is null) {
            error("tried to register a null callback for EzToolbox");
            return;
        }

        if (false
            or c.parent is null
            or c.count == 0
        ) {
            error("did not correctly set up callback for EzToolbox");
            return;
        }

        callbacks.Set(c.parent.ID, @c);
        string msg = "registered callback in EzToolbox (";
        string[] cbs;
        if (c.onEnteredMap) {
            cbs.InsertLast("OnEnteredMap");
        }
        if (c.onEnteredMapAsync) {
            cbs.InsertLast("OnEnteredMapAsync");
        }
        if (c.onExitedMap) {
            cbs.InsertLast("OnExitedMap");
        }
        if (c.onExitedMapAsync) {
            cbs.InsertLast("OnExitedMapAsync");
        }
        trace(msg + string::Join(cbs, ", ") + ")");
    }

    void Verify() {
        startnew(VerifyAsync);
    }

    void VerifyAsync() {
        while (true) {
            sleep(1000);

            string[]@ pluginIds = callbacks.GetKeys();
            for (int i = pluginIds.Length - 1; i >= 0; i--) {
                Meta::Plugin@ plugin = Meta::GetPluginFromID(pluginIds[i]);
                if (plugin is null) {
                    Deregister(pluginIds[i]);
                }
            }
        }
    }

    void WatchForMapChange() {
        startnew(WatchForMapChangeAsync);
    }

    void WatchForMapChangeAsync() {
        string currentUid;
        string lastUid;

        while (true) {
            yield();

            currentUid = EzState::mapInfo.uid;
            if (lastUid != currentUid) {
                lastUid = currentUid;

                if (!EzState::inEditor) {
                    if (EzState::inMap) {
                        OnEnteredMap();
                    } else {
                        OnExitedMap();
                    }
                }
            }
        }
    }
}
