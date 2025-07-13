// c 2025-04-03
// m 2025-07-12

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
        const float scale = UI::GetScale();

        UI::BeginTabBar("#tabbar-debug");

        if (UI::BeginTabItem("Debug")) {
            UI::AlignTextToFramePadding();
            UI::Text("frames: " + EzState::frameCount);
            UI::SameLine();
            UI::Text((FrameCount::valid ? "\\$0F0" : "\\$F00in") + "valid");

            if (UI::BeginTable("##table-debug", 2, UI::TableFlags::RowBg)) {
                UI::PushStyleColor(UI::Col::TableRowBgAlt, vec4(vec3(), 0.5f));

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
                RenderRow("playground script",    ColoredBool(EzState::hasPlaygroundScript));
                RenderRow("editor",               ColoredBool(EzState::inEditor));
                RenderRow("in main menu",         ColoredBool(EzState::inMainMenu));
                RenderRow("map",                  ColoredBool(EzState::inMap));
                RenderRow("  type",               EzState::mapInfo.type);
                RenderRow("  uid",                EzState::mapInfo.uid);
                RenderRow("  author time",        EzState::mapInfo.authorTimeFormatted);
                RenderRow("  gold time",          EzState::mapInfo.goldTimeFormatted);
                RenderRow("  silver time",        EzState::mapInfo.silverTimeFormatted);
                RenderRow("  bronze time",        EzState::mapInfo.bronzeTimeFormatted);
                RenderRow("editing map",          ColoredBool(EzState::inMapEditor));
                RenderRow("testing map",          ColoredBool(EzState::inMapEditorTesting));
                RenderRow("playground",           ColoredBool(EzState::inPlayground));
                RenderRow("editing local replay", ColoredBool(EzState::inReplayEditorEditing));
                RenderRow("viewing local replay", ColoredBool(EzState::inReplayEditorViewing));
                RenderRow("editing skin",         ColoredBool(EzState::inSkinEditor));
                RenderRow("loading",              ColoredBool(EzState::loading));
                RenderRow("menu",                 ColoredBool(EzState::hasMenu));
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
                UI::SeparatorText("\\$0CFSTATIC");
                UI::TableNextColumn();
                UI::SeparatorText("");

#if TMNEXT
                RenderRow("access level",         tostring(EzStatic::accessLevel));
#endif
                RenderRow("bits",                 tostring(EzStatic::bits));
                RenderRow("exe version",          EzStatic::exeVersion);
                RenderRow("game type",            tostring(EzStatic::gameType));
                RenderRow("operating system",     tostring(EzStatic::os));
                RenderRow("player id",            tostring(EzStatic::playerId.Value) + " (" + EzStatic::playerId.GetName() + ")");
                RenderRow("player login",         EzStatic::playerLogin);
                RenderRow("player username",      EzStatic::playerUsername);
                RenderRow("player wsid",          EzStatic::playerWsid);

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

                UI::PopStyleColor();
                UI::EndTable();
            }

            UI::EndTabItem();
        }

        if (UI::BeginTabItem("Viewport")) {
            auto Viewport = cast<CDx11Viewport>(GetApp().Viewport);
            auto classInfo = Reflection::TypeOf(Viewport);

            UI::BeginTabBar("#tabbar-debug-viewport");

            if (UI::BeginTabItem("Reflection")) {
                if (UI::BeginChild("##child-debug-viewport-reflection")) {
                    if (UI::BeginTable("#table-debug-viewport-reflection", 2, UI::TableFlags::RowBg)) {
                        UI::PushStyleColor(UI::Col::TableRowBgAlt, vec4(vec3(), 0.5f));

                        UI::TableSetupColumn("name",   UI::TableColumnFlags::WidthStretch);
                        UI::TableSetupColumn("offset", UI::TableColumnFlags::WidthFixed, scale * 80.0f);

                        RenderReflectionRows(classInfo);

                        UI::PopStyleColor();
                        UI::EndTable();
                    }
                }
                UI::EndChild();

                UI::EndTabItem();
            }

            if (UI::BeginTabItem("Raw Offsets")) {
#if MANIA64
                S_Debug_64bit = UI::Checkbox("Use 64-bit values (includes pointers)", S_Debug_64bit);
#endif

                if (UI::BeginTable("##table-debug-viewport-offsets", 2, UI::TableFlags::RowBg | UI::TableFlags::ScrollY)) {
                    UI::PushStyleColor(UI::Col::TableRowBgAlt, vec4(vec3(), 0.5f));

#if TMNEXT || MP4
                    UI::ListClipper clipper(classInfo.Size / (S_Debug_64bit ? 0x8 : 0x4));
#elif TURBO
                    UI::ListClipper clipper(0x1810);  // Turbo doesn't have class sizes
#endif
                    while (clipper.Step()) {
                        for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i += 1) {
                            const uint16 o = i * (S_Debug_64bit ? 0x8 : 0x4);

                            UI::TableNextRow();

                            UI::TableNextColumn();
                            UI::Text("+0x" + Text::Format("%X", o));

                            UI::TableNextColumn();
                            if (S_Debug_64bit) {
                                const uint64 value = Dev::GetOffsetUint64(Viewport, o);
                                try {
                                    Dev::SafeReadUInt8(value);
                                    UI::Text("\\$0FF" + Text::FormatPointer(value));
                                } catch {
                                    UI::Text(tostring(value));
                                }

                            } else {
                                UI::Text(tostring(Dev::GetOffsetUint32(Viewport, o)));
                            }
                        }
                    }

                    UI::PopStyleColor();
                    UI::EndTable();
                }

                UI::EndTabItem();
            }

            UI::EndTabBar();

            UI::EndTabItem();
        }

        UI::EndTabBar();
    }

    void RenderReflectionRows(const Reflection::MwClassInfo@ classInfo) {
        if (classInfo is null) {
            return;
        }

        UI::TableNextRow();

        UI::TableNextColumn();
        UI::SeparatorText(classInfo.Name
#if TMNEXT || MP4
            + " (size 0x" + Text::Format("%X", classInfo.Size) + ")"
#endif
        );

        UI::TableNextColumn();
        UI::SeparatorText("");

        for (uint i = 0; i < classInfo.Members.Length; i++) {
            auto member = classInfo.Members[i];

            UI::TableNextRow();

            UI::TableNextColumn();
            UI::Text(member.Name);

            UI::TableNextColumn();
            if (true
                and member.Offset > 0x0
                and member.Offset < MAX_UINT16
            ) {
                UI::Text("+0x" + Text::Format("%X", member.Offset));
            }
        }

        RenderReflectionRows(classInfo.BaseType);
    }

    void RenderRow(const string&in name, const string&in value) {
        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text(name);
        UI::TableNextColumn();
        UI::Text(value);
    }
}
