/*
c 2023-06-04
m 2023-06-09
*/

namespace MenuInfo {
    bool Cest(Time::Info now) {
        uint m;
        switch (now.Month) {
            case 5:
                m = 1; break;
            case 8:
                m = 2; break;
            case 2: case 3: case 11:
                m = 3; break;
            case 6:
                m = 4; break;
            case 9: case 12:
                m = 5; break;
            case 4: case 7:
                m = 6; break;
            default:
                m = 0;
        }
        uint leap     = now.Year % 4 == 0 ? 1 : 0;
        uint yearCent = now.Year % 100;
        uint y        = (yearCent + yearCent / 4) % 7;
        bool lastWeek = (31 - (now.Day - ((y - leap + m + now.Day + 6) % 7))) < 7;

        return (
            (now.Month > 3 || (now.Month == 3 && lastWeek)) &&
            !(now.Month > 10 || (now.Month == 10 && lastWeek))
        );
    }
    bool Cest() { return Cest(Time::ParseUTC(Time::get_Stamp())); }

    void Render() {
        if (!MI_show) return;

        string text = "\\$" + MI_colorCode;

        string padding;
        for (uint i = 0; i < MI_padCount; i++) padding += " ";

        if (MI_ping) {
            if (Globals::ServerInfo.JoinLink != "") {
                text += padding;
                if (MI_icons) text += Icons::Kenney::Network + " ";
                text += int(Globals::Network.LatestGamePing) + "ms";
            }
        }

        if (MI_WhereAmI) {
            text += padding;
            if (MI_icons) text += Icons::MapMarker + " ";
            text += WhereAmI::CurrentStr();
        }

        if (MI_OnlineChecker) {
            text += padding;
            if (MI_icons) text += Icons::InternetExplorer + " ";
            text += (OnlineChecker::Get() ? "online" : "OFFLINE");
        }

        if (MI_COTD) {
            auto now = Time::ParseUTC(Time::get_Stamp());
            bool cest = Cest(now);

            int hourOfCotd = cest ? 17 : 18;
            int hourOfCotn = cest ? 1 : 2;
            int hourOfCotm = cest ? 9 : 10;

            text += padding;
            if (MI_icons) text += Icons::Trophy + " ";

            bool first45m = now.Minute < 45;
            if      (first45m && now.Hour == hourOfCotd) text += "COTD in progress";
            else if (first45m && now.Hour == hourOfCotn) text += "COTN in progress";
            else if (first45m && now.Hour == hourOfCotm) text += "COTM in progress";
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
                    if (hoursToCotn > 0) text += hoursToCotn + "h ";
                    text += minutes + "m until COTN";
                } else if (now.Hour < hourOfCotm) {
                    if (hoursToCotm > 0) text += hoursToCotm + "h ";
                    text += minutes + "m until COTM";
                } else {
                    if (hoursToCotd > 0) text += hoursToCotd + "h ";
                    text += minutes + "m until COTD";
                }
            }
        }

        if (MI_FPS) {
            auto fps = Globals::App.Viewport.AverageFps;
            text += padding;
            if (MI_icons) text += Icons::VideoCamera + " ";
            text += int(fps) + " FPS";
        }

        if (MI_clock) {
            text += padding;
            if (MI_icons) text += Icons::ClockO + " ";
            text += Time::FormatString("%X");
        }

        auto pos = UI::GetCursorPos();
        UI::SetCursorPos(vec2(
            UI::GetWindowSize().x - Draw::MeasureString(text).x - 10,
            pos.y
        ));
        UI::Text(text);
        UI::SetCursorPos(pos);
    }
}