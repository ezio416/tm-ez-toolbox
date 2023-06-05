/*
c 2023-06-04
m 2023-06-04
*/

namespace MenuInfo {
    void Render() {
        if (!Settings::showMenuInfo) return;

        string text = "\\$" + MI_colorCode;

        string spacing;
        for (uint i = 0; i < MI_spacingCount; i++) spacing += " ";

        if (MI_OnlineChecker) {
            text += spacing + (OnlineChecker::Get() ? "online" : "offline");
        }

        if (MI_WhereAmI) {
            text += spacing + WhereAmI::CurrentStr();
        }

        if (MI_ping) {
            if (Globals::ServerInfo.JoinLink != "")
                text += spacing + int(Globals::Network.LatestGamePing) + "ms";
        }

        if (MI_COTD) {
            auto now = Time::ParseUTC(Time::get_Stamp());
            bool cest = Util::Cest(now);

            int hourOfCotd = cest ? 17 : 18;
            int hourOfCotn = cest ? 1 : 2;
            int hourOfCotm = cest ? 9 : 10;

            bool first30m = now.Minute < 30;
            if      (first30m && now.Hour == hourOfCotd) text += "COTD in progress";
            else if (first30m && now.Hour == hourOfCotn) text += "COTN in progress";
            else if (first30m && now.Hour == hourOfCotm) text += "COTM in progress";
            else {
                uint hoursToCotd = hourOfCotd - now.Hour - 1;
                uint hoursToCotm = hourOfCotm - now.Hour - 1;
                uint hoursToCotn = (now.Hour >= hourOfCotn) ? 24 - now.Hour : 0;
                uint minutes = 60 - now.Minute;
                if (minutes == 60) {
                    minutes = 0;
                    hoursToCotd++;
                    hoursToCotn++;
                    hoursToCotm++;
                }
                if (now.Hour < hourOfCotn || now.Hour >= hourOfCotd) {
                    if (hoursToCotn > 0) text += spacing + hoursToCotn + "h ";
                    text += minutes + "m until COTN";
                } else if (now.Hour < hourOfCotm) {
                    if (hoursToCotm > 0) text += spacing + hoursToCotm + "h ";
                    text += minutes + "m until COTM";
                } else {
                    if (hoursToCotd > 0) text += spacing + hoursToCotd + "h ";
                    text += spacing + minutes + "m until COTD";
                }
            }
        }

        if (MI_FPS) {
            auto fps = Globals::App.Viewport.AverageFps;
            text += spacing + int(fps) + " FPS";
        }

        if (MI_clock) {
            auto time = Time::FormatString("%X");
            text += spacing + time;
        }

        auto pos = UI::GetCursorPos();
        UI::SetCursorPos(vec2(
            UI::GetWindowSize().x - Draw::MeasureString(text).x - MI_textPosition,
            pos.y
        ));
        UI::Text(text);
        UI::SetCursorPos(pos);
    }
}