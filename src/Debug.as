// c 2025-04-03
// m 2025-07-10

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
            UI::WindowFlags::None
        )) {
            RenderContents();
        }
        UI::End();
    }

    void RenderContents() {
        UI::BeginTabBar("#tabbar-debug");

        if (UI::BeginTabItem("Debug")) {
            UI::Text("frames: " + EzState::frameCount);
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
                UI::Text(ColoredBool(EzState::inEditor));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("fps");
                UI::TableNextColumn();
                UI::Text(Text::Format("%.1f", EzState::fps));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("game mode");
                UI::TableNextColumn();
                UI::Text(EzState::gameMode);

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("gui player");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::hasGuiPlayer));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("loading");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::loading));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("map");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::inMap));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("  type");
                UI::TableNextColumn();
                UI::Text(EzState::mapInfo.type);

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("  uid");
                UI::TableNextColumn();
                UI::Text(EzState::mapInfo.uid);

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("  author time");
                UI::TableNextColumn();
                UI::Text(EzState::mapInfo.authorTimeFormatted);

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("  gold time");
                UI::TableNextColumn();
                UI::Text(EzState::mapInfo.goldTimeFormatted);

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("  silver time");
                UI::TableNextColumn();
                UI::Text(EzState::mapInfo.silverTimeFormatted);

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("  bronze time");
                UI::TableNextColumn();
                UI::Text(EzState::mapInfo.bronzeTimeFormatted);

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("menu");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::hasMenu));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("paused");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::paused));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("ping");
                UI::TableNextColumn();
                UI::Text(tostring(EzState::ping));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("playground");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::inPlayground));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("playground script");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::hasPlaygroundScript));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("sequence");
                UI::TableNextColumn();
                UI::Text(tostring(EzState::sequence));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("viewing controlled");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::viewingControlled));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("\\$0CFlogic");
                UI::TableNextColumn();
                UI::Text("\\$0CF===================================");

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("driving");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::driving));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("in main menu");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::inMainMenu));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("editing map");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::inMapEditor));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("testing map");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::inMapEditorTesting));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("editing local replay");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::inReplayEditorEditing));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("viewing local replay");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::inReplayEditorViewing));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("editing skin");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::inSkinEditor));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("playing map");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::playingMap));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("playing map locally");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::playingMapLocal));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("playing map online");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::playingMapOnline));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("spectating");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::spectating));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("viewing replay");
                UI::TableNextColumn();
                UI::Text(ColoredBool(EzState::viewingReplay));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("\\$0CFstatic");
                UI::TableNextColumn();
                UI::Text("\\$0CF===================================");

#if TMNEXT
                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("access level");
                UI::TableNextColumn();
                UI::Text(tostring(EzStatic::accessLevel));
#endif

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("bits");
                UI::TableNextColumn();
                UI::Text(tostring(EzStatic::bits));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("exe version");
                UI::TableNextColumn();
                UI::Text(EzStatic::exeVersion);

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("game type");
                UI::TableNextColumn();
                UI::Text(tostring(EzStatic::gameType));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("operating system");
                UI::TableNextColumn();
                UI::Text(tostring(EzStatic::os));

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("player id");
                UI::TableNextColumn();
                UI::Text(tostring(EzStatic::playerId.Value) + " (" + EzStatic::playerId.GetName() + ")");

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("player login");
                UI::TableNextColumn();
                UI::Text(EzStatic::playerLogin);

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("player username");
                UI::TableNextColumn();
                UI::Text(EzStatic::playerUsername);

                UI::TableNextRow();
                UI::TableNextColumn();
                UI::Text("player wsid");
                UI::TableNextColumn();
                UI::Text(EzStatic::playerWsid);

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
                        UI::TableSetupColumn("offset", UI::TableColumnFlags::WidthFixed, UI::GetScale() * 80.0f);

                        RenderReflectionRows(classInfo);

                        UI::PopStyleColor();
                        UI::EndTable();
                    }
                }
                UI::EndChild();

                UI::EndTabItem();
            }

            if (UI::BeginTabItem("Raw Offsets")) {
                if (UI::BeginTable("##table-debug-viewport-offsets", 2, UI::TableFlags::RowBg | UI::TableFlags::ScrollY)) {
                    UI::PushStyleColor(UI::Col::TableRowBgAlt, vec4(vec3(), 0.5f));

#if TMNEXT || MP4
                    UI::ListClipper clipper(classInfo.Size / (S_Debug_64bit ? 0x8 : 0x4));
#elif TURBO
                    UI::ListClipper clipper(0x1810);  // Turbo doesn't have class sizes
#endif
                    while (clipper.Step()) {
                        for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i += 1) {
#if MANIA64
                            const uint16 o = i * (S_Debug_64bit ? 0x8 : 0x4);
#else
                            const uint16 o = i * 0x4;
#endif

                            UI::TableNextRow();

                            UI::TableNextColumn();
                            UI::Text("+0x" + Text::Format("%X", o));

                            UI::TableNextColumn();
                            if (false
#if MANIA64
                                or S_Debug_64bit
#endif
                            ) {
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
            if (member.Offset != 0x0 and member.Offset != uint16(-1)) {
                UI::Text("+0x" + Text::Format("%X", member.Offset));
            }
        }

        RenderReflectionRows(classInfo.BaseType);
    }
}
