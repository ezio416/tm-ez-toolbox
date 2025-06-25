// c 2025-06-24
// m 2025-06-24

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
            text += int(Math::Round(Ez2::State::fps)) + " FPS";
        }

        if (S_MenuInfo_Clock) {
            text += padding;
            if (S_MenuInfo_Icons) {
                text += Icons::ClockO + " ";
            }
            text += Time::FormatString("%X");
        }

        const vec2 pre = UI::GetCursorPos();
        UI::SetCursorPosX(UI::GetWindowSize().x - Draw::MeasureString(text).x - 10.0f);
        UI::Text(text);
        UI::SetCursorPos(pre);
    }
}
