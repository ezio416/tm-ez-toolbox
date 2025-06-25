// c 2025-04-07
// m 2025-06-25

/*
This module is for getting and ensuring an offset value is valid. The State module relies on an active counter of how
many frames the game has rendered for better performance. No exposed frame counters have been found, so we must use a
Dev function to grab one hidden inside App.Viewport. In the event of a game update, if the current known offset is
found to be invalid, we will check within the plugin's requested configuration file. If the current game version is
not found within that (plugin author has not yet added it), the State module will run with reduced performance.

It is not necessarily important that this specific frame counter is used - we really just need a value that's
guaranteed to be different every frame. Through testing, it has been found that a counter managed by the plugin (or
even by Openplanet) will not suffice because of internal frame timing, so we must rely on one managed by the game.

The variable 'o_FrameCountFromSystemWindow' below should be updated when a plugin update is required for another
reason.
*/

namespace FrameCount {
    const uint8  checks = 3;
    uint16       o_FrameCount = 0x0;
    uint16       o_FrameCountFromSystemWindow = 0x14;  // valid 2024-12-12_15_15
    const uint16 o_SystemWindow = Reflection::GetType("CDx11Viewport").GetMember("SystemWindow").Offset;
    bool         valid = false;

    void CheckOffsetAsync() {
        trace("checking frame count offset");

        o_FrameCount = o_SystemWindow + o_FrameCountFromSystemWindow;

        uint last;
        uint new = Get();

        for (uint8 i = 0; i < checks; i++) {
            last = new;
            yield();
            new = Get();
            trace(
                "checking frame count value: last " + last
                + " new " + new + " (diff " + (new - last) + ")"
            );
            if (new != last + 1) {
                error("frame count didn't change as expected, plugin will run with reduced performance");
                return;
            }
        }

        trace("frame count offset looks good");
        valid = true;
    }

    uint Get() {
        return Dev::GetOffsetUint32(GetApp().Viewport, o_FrameCount);
    }

    void Start() {
        startnew(StartAsync);
    }

    void StartAsync() {
        CheckOffsetAsync();

        if (valid) {
            return;
        }

        warn("known frame count offset is invalid - using value from config");

        while (Config::config is null) {
            yield();  // wait until Config module finishes requesting
        }

        if (!Config::config.HasKey("o_FrameCountFromSystemWindow")) {
            error("config is missing 'o_FrameCountFromSystemWindow'");
            return;
        }

        Json::Value@ entry = Config::config["o_FrameCountFromSystemWindow"];
        if (entry.GetType() != Json::Type::Object) {
            error("o_FrameCountFromSystemWindow is not an object");
            return;
        }

        const string exe = GetApp().SystemPlatform.ExeVersion;
        if (!entry.HasKey(exe)) {
            error("game version '" + exe + "' is unsupported, plugin will run with reduced performance");
            return;
        }

        Json::Value@ offset = entry[exe];
        if (offset.GetType() != Json::Type::Number) {
            error("offset is not a number");
            return;
        }

        o_FrameCountFromSystemWindow = uint16(offset);
        trace(
            "got new offset: 0x"
            + Text::Format("%X", o_FrameCountFromSystemWindow)
            + " (" + o_FrameCountFromSystemWindow + ")"
        );

        CheckOffsetAsync();
    }
}
