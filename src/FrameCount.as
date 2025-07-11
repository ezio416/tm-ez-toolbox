// c 2025-04-07
// m 2025-07-10

/*
This module is for getting and ensuring an offset value is valid. The State module relies on an active counter of how
many frames the game has rendered for better performance. No exposed frame counters have been found, so we must use a
Dev function to grab one hidden inside App.Viewport. In the event of a game update, if the current known offset is
found to be invalid, we will check within the plugin's requested configuration file. If the current game version is
not found within that (plugin author has not yet added it), the State module will run with reduced performance.

It is not necessarily important that this specific frame counter is used - we really just need a value that's
guaranteed to be different every frame. Through testing, it has been found that a counter managed by the plugin (or
even by Openplanet) will not suffice because of internal frame timing, so we must rely on one managed by the game.

The variables 'o_FrameCount' and 'o_FrameCountFromSystemWindow' below should be updated when a plugin update is
required for another reason.
*/

namespace FrameCount {
    const uint8  checks = 3;
    bool         valid = false;

#if TMNEXT
    uint16       o_FrameCount = 0x0;
    uint16       o_FrameCountFromSystemWindow = 0x14;  // (20) valid 2025-07-04_14_15
    const uint16 o_SystemWindow = Reflection::GetType("CDx11Viewport").GetMember("SystemWindow").Offset;
#elif MP4
    uint16       o_FrameCount = 0x470;  // (1136) valid 2019-11-19_18_50
#elif TURBO
    uint16       o_FrameCount = 0x3F0;  // (1008) valid 2016-11-07_16_15
#endif

    bool CheckOffsetAsync(const bool systemWindow = true) {
        trace("checking frame count offset");

#if TMNEXT
        if (systemWindow) {
            o_FrameCount = o_SystemWindow + o_FrameCountFromSystemWindow;
        }
#endif

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
                return false;
            }
        }

        trace("frame count offset looks good");
        valid = true;
        return true;
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

        if (!Config::config.HasKey("offsets")) {
            error("config is missing key 'offsets'");
            return;
        }

        Json::Value@ offsets = Config::config["offsets"];
        if (offsets.GetType() != Json::Type::Object) {
            error("'offsets' is not an object");
            return;
        }

#if TMNEXT
        if (!offsets.HasKey("next")) {
            error("config is missing key 'next'");
            return;
        }

        Json::Value@ game = Config::config["offsets"]["next"];
        if (game.GetType() != Json::Type::Object) {
            error("'next' is not an object");
            return;
        }

        if (!game.HasKey("o_FrameCountFromSystemWindow")) {
            error("config is missing key 'o_FrameCountFromSystemWindow'");
            return;
        }

        Json::Value@ frameCount = game["o_FrameCountFromSystemWindow"];
        if (frameCount.GetType() != Json::Type::Object) {
            error("'o_FrameCountFromSystemWindow' is not an object");
            return;
        }

#elif MP4 || TURBO
#if MP4
        if (!offsets.HasKey("mp4")) {
            error("config is missing key 'mp4'");
            return;
        }

        Json::Value@ game = offsets["mp4"];
        if (game.GetType() != Json::Type::Object) {
            error("'mp4' is not an object");
            return;
        }

#elif TURBO
        if (!offsets.HasKey("turbo")) {
            error("config is missing key 'turbo'");
            return;
        }

        Json::Value@ game = offsets["turbo"];
        if (game.GetType() != Json::Type::Object) {
            error("'turbo' is not an object");
            return;
        }
#endif

        if (!game.HasKey("o_FrameCount")) {
            error("config is missing key 'o_FrameCount'");
            return;
        }

        Json::Value@ frameCount = game["o_FrameCount"];
        if (frameCount.GetType() != Json::Type::Object) {
            error("'o_FrameCount' is not an object");
            return;
        }
#endif

        const string exe = EzStatic::_exeVersion;
        if (!frameCount.HasKey(exe)) {
            error("game version '" + exe + "' is unsupported - plugin will run with reduced performance");
            return;
        }

        Json::Value@ offset = frameCount[exe];
        if (offset.GetType() != Json::Type::Number) {
            error("offset is not a number");
            return;
        }

#if TMNEXT
        o_FrameCountFromSystemWindow = uint16(offset);
        trace(
            "got new offset from SystemWindow: 0x"
            + Text::Format("%X", o_FrameCountFromSystemWindow)
            + " (" + o_FrameCountFromSystemWindow + ")"
        );
#elif MP4 || TURBO
        o_FrameCount = uint16(offset);
        trace(
            "got new offset: 0x"
            + Text::Format("%X", o_FrameCount)
            + " (" + o_FrameCount + ")"
        );
#endif

        const bool success = CheckOffsetAsync();

#if TMNEXT
        if (!success) {
            warn("offset from SystemWindow didn't work, trying raw offset");

            if (!game.HasKey("o_FrameCount")) {
                error("config is missing key 'o_FrameCount'");
                return;
            }

            @frameCount = game["o_FrameCount"];
            if (frameCount.GetType() != Json::Type::Object) {
                error("'o_FrameCount' is not an object");
                return;
            }

            if (!frameCount.HasKey(exe)) {
                error("game version '" + exe + "' is unsupported - plugin will run with reduced performance");
                return;
            }

            @offset = frameCount[exe];
            if (offset.GetType() != Json::Type::Number) {
                error("'offset' is not a number");
                return;
            }

            o_FrameCount = uint16(offset);
            trace(
                "got new offset: 0x"
                + Text::Format("%X", o_FrameCount)
                + " (" + o_FrameCount + ")"
            );

            CheckOffsetAsync(false);
        }
#endif

    }
}
