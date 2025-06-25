// c 2025-04-03
// m 2025-06-24

namespace Debug {
    void Render() {
        if (false
            or !S_Debug
            or (S_Debug_HideWithGame and !UI::IsGameUIVisible())
            or (S_Debug_HideWithOP and !UI::IsOverlayShown())
        ) {
            return;
        }

        if (UI::Begin(
            pluginTitle + "\\$888 (debug)###eztoolbox-debug",
            S_Debug,
            UI::WindowFlags::AlwaysAutoResize
        )) {
            RenderContents();
        }
        UI::End();
    }

    void RenderContents() {
        // CTrackMania@ App = cast<CTrackMania>(GetApp());

        // if (UI::BeginTable("##table-debug-viewport", 2, UI::TableFlags::RowBg)) {
        //     UI::PushStyleColor(UI::Col::TableRowBgAlt, vec4(vec3(), 0.5f));

        //     for (uint16 i = 0x468; i < 0x540; i += 0x8) {
        //         uint value = Dev::GetOffsetUint32(App.Viewport, i);
        //         UI::TableNextRow();
        //         UI::TableNextColumn();
        //         UI::Text("+0x" + Text::Format("%X", i));
        //         UI::TableNextColumn();
        //         UI::Text(tostring(value));
        //     }

        //     UI::PopStyleColor();
        //     UI::EndTable();
        // }

        // UI::Separator();

        UI::Text("frames: " + Ez2::frameCount);
        UI::SameLine();
        UI::Text("valid: " + ColoredBool(FrameCount::valid));

        UI::Separator();

        if (UI::BeginTable("##table-debug", 2, UI::TableFlags::RowBg)) {
            UI::PushStyleColor(UI::Col::TableRowBgAlt, vec4(vec3(), 0.5f));

            // UI::TableSetupScrollFreeze(0, 1);
            UI::TableSetupColumn("name", UI::TableColumnFlags::WidthFixed);
            UI::TableSetupColumn("value", UI::TableColumnFlags::WidthFixed);
            // UI::TableHeadersRow();

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("\\$0CFbase");
            UI::TableNextColumn();
            UI::Text("\\$0CF===================================");

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("editor");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::editor));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("fps");
            UI::TableNextColumn();
            UI::Text(Text::Format("%.1f", Ez2::State::fps));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("game mode");
            UI::TableNextColumn();
            UI::Text(Ez2::State::gameMode);

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("gui player");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::guiPlayer));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("loading");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::loading));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("map");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::map));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("  type");
            UI::TableNextColumn();
            UI::Text(Ez2::State::mapInfo.type);

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("  uid");
            UI::TableNextColumn();
            UI::Text(Ez2::State::mapInfo.uid);

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("  author time");
            UI::TableNextColumn();
            UI::Text(Ez2::State::mapInfo.authorTimeFormatted);

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("  gold time");
            UI::TableNextColumn();
            UI::Text(Ez2::State::mapInfo.goldTimeFormatted);

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("  silver time");
            UI::TableNextColumn();
            UI::Text(Ez2::State::mapInfo.silverTimeFormatted);

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("  bronze time");
            UI::TableNextColumn();
            UI::Text(Ez2::State::mapInfo.bronzeTimeFormatted);

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("menu");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::menu));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("paused");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::paused));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("ping");
            UI::TableNextColumn();
            UI::Text(tostring(Ez2::State::ping));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("playground");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::playground));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("playground script");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::playgroundScript));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("sequence");
            UI::TableNextColumn();
            UI::Text(tostring(Ez2::State::sequence));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("viewing controlled");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::viewingControlled));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("\\$0CFlogic");
            UI::TableNextColumn();
            UI::Text("\\$0CF===================================");

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("driving");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::driving));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("in main menu");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::mainMenu));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("editing map");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::mapEditor));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("testing map");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::mapEditorTesting));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("editing local replay");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::replayEditorEditing));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("viewing local replay");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::replayEditorViewing));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("editing skin");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::skinEditor));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("playing map");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::playingMap));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("playing map locally");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::playingMapLocal));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("playing map online");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::playingMapOnline));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("spectating");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::spectating));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("viewing replay");
            UI::TableNextColumn();
            UI::Text(ColoredBool(Ez2::State::viewingReplay));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("\\$0CFstatic");
            UI::TableNextColumn();
            UI::Text("\\$0CF===================================");

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("access level");
            UI::TableNextColumn();
            UI::Text(tostring(Ez2::Static::accessLevel));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("bits");
            UI::TableNextColumn();
            UI::Text(tostring(Ez2::Static::bits));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("exe version");
            UI::TableNextColumn();
            UI::Text(Ez2::Static::exeVersion);

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("game type");
            UI::TableNextColumn();
            UI::Text(tostring(Ez2::Static::gameType));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("operating system");
            UI::TableNextColumn();
            UI::Text(tostring(Ez2::Static::os));

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("player id");
            UI::TableNextColumn();
            UI::Text(tostring(Ez2::Static::playerId.Value) + " (" + Ez2::Static::playerId.GetName() + ")");

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("player login");
            UI::TableNextColumn();
            UI::Text(Ez2::Static::playerLogin);

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("player username");
            UI::TableNextColumn();
            UI::Text(Ez2::Static::playerUsername);

            UI::TableNextRow();
            UI::TableNextColumn();
            UI::Text("player wsid");
            UI::TableNextColumn();
            UI::Text(Ez2::Static::playerWsid);

            UI::PopStyleColor();
            UI::EndTable();
        }
    }
}
