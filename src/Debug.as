// c 2025-04-03
// m 2025-04-03

void RenderDebugContents() {
    UI::Text("frames: " + Ez2::state.frameCount);

    UI::Separator();

    if (UI::BeginTable("##table-debug", 2, UI::TableFlags::RowBg | UI::TableFlags::ScrollY)) {
        UI::PushStyleColor(UI::Col::TableRowBgAlt, vec4(vec3(), 0.5f));

        // UI::TableSetupScrollFreeze(0, 1);
        UI::TableSetupColumn("name", UI::TableColumnFlags::WidthFixed);
        UI::TableSetupColumn("value", UI::TableColumnFlags::WidthFixed);
        // UI::TableHeadersRow();

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("\\$0FFbase");
        UI::TableNextColumn();
        UI::Text("\\$0FF===================================");

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("fps");
        UI::TableNextColumn();
        UI::Text(Text::Format("%.1f", Ez2::state.fps));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("game mode");
        UI::TableNextColumn();
        UI::Text(Ez2::state.gameMode);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("gui player");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.guiPlayer));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in editor");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inEditor));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inMap));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in menu");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inMenu));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in playground");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inPlayground));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("loading");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.loading));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("map type");
        UI::TableNextColumn();
        UI::Text(Ez2::state.mapType);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("map uid");
        UI::TableNextColumn();
        UI::Text(Ez2::state.mapUid);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("author time");
        UI::TableNextColumn();
        UI::Text(Time::Format(Ez2::state.authorTime));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("gold time");
        UI::TableNextColumn();
        UI::Text(Time::Format(Ez2::state.goldTime));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("silver time");
        UI::TableNextColumn();
        UI::Text(Time::Format(Ez2::state.silverTime));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("bronze time");
        UI::TableNextColumn();
        UI::Text(Time::Format(Ez2::state.bronzeTime));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("paused");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.paused));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("playground script");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.playgroundScript));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("sequence");
        UI::TableNextColumn();
        UI::Text(tostring(Ez2::state.sequence));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("viewing login");
        UI::TableNextColumn();
        UI::Text(Ez2::state.viewingLogin);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("\\$0FFlogic");
        UI::TableNextColumn();
        UI::Text("\\$0FF===================================");

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("driving");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.driving));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in main menu");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inMainMenu));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("editing map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inMapEditor));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("testing map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inMapEditorTesting));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("editing local replay");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inReplayEditorEditing));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("viewing local replay");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inReplayEditorViewing));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("editing skin");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inSkinEditor));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("playing local map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.playingLocalMap));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("playing map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.playingMap));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("spectating");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.spectating));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("viewing replay");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.viewingReplay));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("\\$0FFcached");
        UI::TableNextColumn();
        UI::Text("\\$0FF===================================");

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("bits");
        UI::TableNextColumn();
        UI::Text(tostring(Ez2::state.bits));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("exe version");
        UI::TableNextColumn();
        UI::Text(Ez2::state.exeVersion);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("game");
        UI::TableNextColumn();
        UI::Text(tostring(Ez2::state.game));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local access level");
        UI::TableNextColumn();
        UI::Text(tostring(Ez2::state.localAccessLevel));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local id");
        UI::TableNextColumn();
        UI::Text(tostring(Ez2::state.localId.Value) + " (" + Ez2::state.localId.GetName() + ")");

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local login");
        UI::TableNextColumn();
        UI::Text(Ez2::state.localLogin);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local username");
        UI::TableNextColumn();
        UI::Text(Ez2::state.localUsername);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local wsid");
        UI::TableNextColumn();
        UI::Text(Ez2::state.localWsid);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("operating system");
        UI::TableNextColumn();
        UI::Text(tostring(Ez2::state.os));

        UI::PopStyleColor();
        UI::EndTable();
    }
}
