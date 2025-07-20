// c 2025-04-03
// m 2025-07-19

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
            UI::WindowFlags::NoFocusOnAppearing
        )) {
            RenderContents();
        }
        UI::End();
    }

    void RenderContents() {
        if (UI::BeginTable("##table-debug", 2, UI::TableFlags::RowBg)) {
            UI::PushStyleColor(UI::Col::TableRowBgAlt, vec4(vec3(), 0.5f));

            try {
                // UI::TableSetupScrollFreeze(0, 1);
                UI::TableSetupColumn("name", UI::TableColumnFlags::WidthFixed);
                UI::TableSetupColumn("value", UI::TableColumnFlags::WidthStretch);
                // UI::TableHeadersRow();

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::SeparatorText("\\$0CFSTATE");
                UI::TableNextColumn();
                UI::SeparatorText("");

                RenderRow("driving",              ColoredBool(EzState::driving));
                RenderRow("fps",                  Text::Format("%.1f", EzState::fps));
                RenderRow("game mode",            EzState::gameMode);
                RenderRow("gui player",           ColoredBool(EzState::hasGuiPlayer));
                RenderRow("menu",                 ColoredBool(EzState::hasMenu));
                RenderRow("playground script",    ColoredBool(EzState::hasPlaygroundScript));
                RenderRow("editor",               ColoredBool(EzState::inEditor));
                RenderRow("main menu",            ColoredBool(EzState::inMainMenu));
                RenderRow("map",                  ColoredBool(EzState::inMap));
                auto info = EzState::mapInfo;
                RenderRow("  type",               info.type);
                RenderRow("  uid",                info.uid);
                RenderRow("  author time",        info.authorTimeFormatted);
                RenderRow("  gold time",          info.goldTimeFormatted);
                RenderRow("  silver time",        info.silverTimeFormatted);
                RenderRow("  bronze time",        info.bronzeTimeFormatted);
                RenderRow("editing map",          ColoredBool(EzState::inMapEditor));
                RenderRow("testing map",          ColoredBool(EzState::inMapEditorTesting));
                RenderRow("playground",           ColoredBool(EzState::inPlayground));
                RenderRow("editing local replay", ColoredBool(EzState::inReplayEditorEditing));
                RenderRow("viewing local replay", ColoredBool(EzState::inReplayEditorViewing));
                RenderRow("editing skin",         ColoredBool(EzState::inSkinEditor));
                RenderRow("loading",              ColoredBool(EzState::loading));
                RenderRow("paused",               ColoredBool(EzState::paused));
                RenderRow("ping",                 tostring(EzState::ping));
                RenderRow("playing map",          ColoredBool(EzState::playingMap));
                RenderRow("playing map locally",  ColoredBool(EzState::playingMapLocal));
                RenderRow("playing map online",   ColoredBool(EzState::playingMapOnline));
                RenderRow("sequence",             tostring(EzState::sequence));
                RenderRow("spectating",           ColoredBool(EzState::spectating));
                RenderRow("viewing controlled",   ColoredBool(EzState::viewingControlled));
                RenderRow("viewing replay",       ColoredBool(EzState::viewingReplay));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::SeparatorText("\\$0CFCONSTANTS");
                UI::TableNextColumn();
                UI::SeparatorText("");

                RenderRow("MAX_INT8",   tostring(MAX_INT8)   + " | \\$0FF" + Text::Format("0x%X", MAX_INT8));
                RenderRow("MAX_INT16",  tostring(MAX_INT16)  + " | \\$0FF" + Text::Format("0x%X", MAX_INT16));
                RenderRow("MAX_INT32",  tostring(MAX_INT32)  + " | \\$0FF" + Text::Format("0x%X", MAX_INT32));
#if MANIA64
                RenderRow("MAX_INT64",  tostring(MAX_INT64)  + " | \\$0FF" + Text::FormatPointer(MAX_INT64));
#endif
                RenderRow("MIN_INT8",   tostring(MIN_INT8)   + " | \\$0FF" + Text::Format("0x%X", MIN_INT8));
                RenderRow("MIN_INT16",  tostring(MIN_INT16)  + " | \\$0FF" + Text::Format("0x%X", MIN_INT16));
                RenderRow("MIN_INT32",  tostring(MIN_INT32)  + " | \\$0FF" + Text::Format("0x%X", MIN_INT32));
#if MANIA64
                RenderRow("MIN_INT64",  tostring(MIN_INT64)  + " | \\$0FF" + Text::FormatPointer(uint64(MIN_INT64)));
#endif
                RenderRow("MAX_UINT8",  tostring(MAX_UINT8)  + " | \\$0FF" + Text::Format("0x%X", MAX_UINT8));
                RenderRow("MAX_UINT16", tostring(MAX_UINT16) + " | \\$0FF" + Text::Format("0x%X", MAX_UINT16));
                RenderRow("MAX_UINT32", tostring(MAX_UINT32) + " | \\$0FF" + Text::Format("0x%X", MAX_UINT32));
#if MANIA64
                RenderRow("MAX_UINT64", tostring(MAX_UINT64) + " | \\$0FF" + Text::FormatPointer(MAX_UINT64));
#endif

#if TMNEXT
                UI::TableNextRow();
                UI::TableNextColumn();
                UI::SeparatorText("\\$0CFLAYERS");
                UI::TableNextColumn();
                UI::SeparatorText("");

                RenderRow("menu",       tostring(EzLayers::Menu::layerCount));
                RenderRow("playground", tostring(EzLayers::Playground::layerCount));
#endif

            } catch {
                error(getExceptionInfo());
                PrintActiveContextStack(true);
            }

            UI::PopStyleColor();
            UI::EndTable();
        }
    }

    void RenderRow(const string&in name, const string&in value) {
        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text(name);
        UI::TableNextColumn();
        UI::Text(value);
    }
}
