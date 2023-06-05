/*
c 2023-06-04
m 2023-06-04
*/

namespace Util {

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
}