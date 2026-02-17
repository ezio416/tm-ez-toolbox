// c 2025-06-24
// m 2026-01-29

/*
This module is a legacy feature from v0. It shows various information in the top-right of Openplanet's main menu bar.
*/

namespace MenuInfo {
    void Render() {
        if (!S_MenuInfo) {
            return;
        }

        string text;

        string padding;
        for (uint i = 0; i < S_MenuInfo_Padding; i++) {
            padding += " ";
        }

        if (S_MenuInfo_FPS) {
            text += padding;
            if (S_MenuInfo_Icons) {
                text += Icons::VideoCamera + " ";
            }
            text += int(Math::Round(EzState::fps)) + " FPS";
        }

        if (S_MenuInfo_Clock) {
            text += padding;
            if (S_MenuInfo_Icons) {
                text += Icons::ClockO + " ";
            }
            text += Time::FormatString("%T");
        }

        if (S_MenuInfo_Date) {
            text += padding;
            if (S_MenuInfo_Icons) {
                text += Icons::CalendarO + " ";
            }
            text += Time::FormatString("%F");
        }

        float width = UI::MeasureString(text).x;

        // if (S_MenuInfo_Menu) {
        //     width += UI::MeasureString(padding + pluginTitle).x + UI::GetScale() * 10.0f;
        // }

        const vec2 pre = UI::GetCursorPos();
        UI::SetCursorPosX(UI::GetWindowSize().x - width - 10.0f);

        // if (S_MenuInfo_Menu) {
        //     RenderMenu();
        // }

        UI::Text(text);
        UI::SetCursorPos(pre);
    }

    // void RenderMenu() {
    //     if (!UI::BeginMenu(pluginTitle)) {
    //         return;
    //     }

    //     if (UI::MenuItem("hello world")) {
    //         ;
    //     }

    //     UI::EndMenu();
    // }
}
