// c 2025-07-19
// m 2025-07-20

#if TMNEXT
/*
Checks UI layers and caches indices to help performance in dependent plugins.
*/
namespace EzLayers {
    uint Loop(const string&in name, uint layerCount, dictionary& indices, const MwFastBuffer<CGameUILayer@>&in UILayers) {
        if (layerCount == UILayers.Length) {
            return layerCount;
        }

        indices.DeleteAll();
        layerCount = UILayers.Length;
        trace("new " + name + " layer count: " + layerCount);

        int start, end;
        string layerName;

        for (uint i = 0; i < UILayers.Length; i++) {
            CGameUILayer@ Layer = UILayers[i];

            if (false
                or Layer is null
                or Layer.ManialinkPageUtf8.Length == 0
            ) {
                continue;
            }

            start = Layer.ManialinkPageUtf8.IndexOf("<");
            end = Layer.ManialinkPageUtf8.IndexOf(">");

            if (false
                or start == -1
                or end == -1
                or end <= start + 1
            ) {
                continue;
            }

            layerName = Layer.ManialinkPageUtf8
                .SubStr(start + 1, end - start - 1)
                .Replace("manialink", "")
                .Replace("name=", "")
                .Replace('version="3"', "")
                .Replace('"', "")
                .Trim()
            ;

            indices.Set(layerName, i);
        }

        return layerCount;
    }

    /*
    Gets layers and indices from the menu.
    */
    namespace Menu {
        dictionary indices;
        uint       layerCount = 0;

        int GetIndex(const string&in layerName) {
            VerifyEnabled();
            return indices.Exists(layerName) ? int(indices[layerName]) : -1;
        }

        const dictionary@ GetIndices() {
            VerifyEnabled();
            return indices;
        }

        CGameUILayer@ GetLayer(const uint index) {
            VerifyEnabled();
            try {
                return cast<CTrackMania>(GetApp()).MenuManager.MenuCustom_CurrentManiaApp.UILayers[index];
            } catch {
                return null;
            }
        }

        CGameUILayer@ GetLayer(const string&in layerName) {
            VerifyEnabled();
            const int index = GetIndex(layerName);
            return index > -1 ? GetLayer(index) : null;
        }

        void LoopAsync() {
            auto App = cast<CTrackMania>(GetApp());

            while (true) {
                yield();

                if (false
                    or App.MenuManager is null
                    or App.MenuManager.MenuCustom_CurrentManiaApp is null
                ) {
                    indices.DeleteAll();
                    layerCount = 0;
                    continue;
                }

                layerCount = Loop(
                    "menu",
                    layerCount,
                    indices,
                    App.MenuManager.MenuCustom_CurrentManiaApp.UILayers
                );
            }
        }
    }

    /*
    Gets layers and indices from the current playground.
    */
    namespace Playground {
        dictionary indices;
        uint       layerCount = 0;

        int GetIndex(const string&in layerName) {
            VerifyEnabled();
            return indices.Exists(layerName) ? int(indices[layerName]) : -1;
        }

        const dictionary@ GetIndices() {
            VerifyEnabled();
            return indices;
        }

        CGameUILayer@ GetLayer(const uint index) {
            VerifyEnabled();
            try {
                return GetApp().Network.ClientManiaAppPlayground.UILayers[index];
            } catch {
                return null;
            }
        }

        CGameUILayer@ GetLayer(const string&in layerName) {
            VerifyEnabled();
            const int index = GetIndex(layerName);
            return index > -1 ? GetLayer(index) : null;
        }

        void LoopAsync() {
            auto Network = GetApp().Network;

            while (true) {
                yield();

                if (Network.ClientManiaAppPlayground is null) {
                    indices.DeleteAll();
                    layerCount = 0;
                    continue;
                }

                layerCount = Loop(
                    "playground",
                    layerCount,
                    indices,
                    Network.ClientManiaAppPlayground.UILayers
                );
            }
        }
    }
}
#endif
