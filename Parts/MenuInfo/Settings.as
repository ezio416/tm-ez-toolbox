/*
c 2023-06-04
m 2023-06-09
*/

namespace MenuInfo {
    [Setting category="MenuInfo" name="Enabled"]
    bool MI_show = true;

    [Setting category="MenuInfo" name="Hide with game UI" description="also at main menu"]
    bool MI_hideWithGame = false;

    [Setting category="MenuInfo" name="Show icons"]
    bool MI_icons = true;

    [Setting category="MenuInfo" name="Padding" min=1 max=100]
    uint MI_padCount = 5;

    [Setting category="MenuInfo" name="Text color" description="3-character hex code" max=3]
    string MI_colorCode = "FFF";

    [Setting category="MenuInfo" name="WhereAmI" description="must be enabled in other tab"]
    bool MI_WhereAmI = false;

    [Setting category="MenuInfo" name="OnlineChecker" description="must be enabled in other tab"]
    bool MI_OnlineChecker = false;

    [Setting category="MenuInfo" name="Ping" description="only shown when on a server"]
    bool MI_ping = true;

    [Setting category="MenuInfo" name="COTD countdown"]
    bool MI_COTD = true;

    [Setting category="MenuInfo" name="FPS counter"]
    bool MI_FPS = true;

    [Setting category="MenuInfo" name="Clock"]
    bool MI_clock = true;
}