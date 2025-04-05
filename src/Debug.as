// c 2025-04-03
// m 2025-04-04

void RenderDebugContents() {
    UI::Text("frames: " + _state.frameCount);

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
        UI::Text(Text::Format("%.1f", _state.fps));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("game mode");
        UI::TableNextColumn();
        UI::Text(_state.gameMode);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("gui player");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.guiPlayer));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in editor");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.inEditor));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.inMap));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in menu");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.inMenu));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in playground");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.inPlayground));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("loading");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.loading));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("map type");
        UI::TableNextColumn();
        UI::Text(_state.mapType);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("map uid");
        UI::TableNextColumn();
        UI::Text(_state.mapUid);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("author time");
        UI::TableNextColumn();
        UI::Text(Time::Format(_state.authorTime));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("gold time");
        UI::TableNextColumn();
        UI::Text(Time::Format(_state.goldTime));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("silver time");
        UI::TableNextColumn();
        UI::Text(Time::Format(_state.silverTime));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("bronze time");
        UI::TableNextColumn();
        UI::Text(Time::Format(_state.bronzeTime));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("paused");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.paused));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("playground script");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.playgroundScript));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("sequence");
        UI::TableNextColumn();
        UI::Text(tostring(_state.sequence));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("viewing controlled");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.viewingControlled));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("\\$0FFlogic");
        UI::TableNextColumn();
        UI::Text("\\$0FF===================================");

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("driving");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.driving));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in main menu");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.inMainMenu));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("editing map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.inMapEditor));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("testing map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.inMapEditorTesting));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("editing local replay");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.inReplayEditorEditing));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("viewing local replay");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.inReplayEditorViewing));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("editing skin");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.inSkinEditor));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("playing local map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.playingLocalMap));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("playing map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.playingMap));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("spectating");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.spectating));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("viewing replay");
        UI::TableNextColumn();
        UI::Text(ColoredBool(_state.viewingReplay));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("\\$0FFcached");
        UI::TableNextColumn();
        UI::Text("\\$0FF===================================");

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("bits");
        UI::TableNextColumn();
        UI::Text(tostring(_state.bits));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("exe version");
        UI::TableNextColumn();
        UI::Text(_state.exeVersion);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("game");
        UI::TableNextColumn();
        UI::Text(tostring(_state.game));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local access level");
        UI::TableNextColumn();
        UI::Text(tostring(_state.localAccessLevel));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local id");
        UI::TableNextColumn();
        UI::Text(tostring(_state.localId.Value) + " (" + _state.localId.GetName() + ")");

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local login");
        UI::TableNextColumn();
        UI::Text(_state.localLogin);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local username");
        UI::TableNextColumn();
        UI::Text(_state.localUsername);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local wsid");
        UI::TableNextColumn();
        UI::Text(_state.localWsid);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("operating system");
        UI::TableNextColumn();
        UI::Text(tostring(_state.os));

        UI::PopStyleColor();
        UI::EndTable();
    }
}
