/*
c 2023-06-04
m 2023-06-04
*/

namespace MenuInfo {
    [Setting category="MenuInfo" name="Text color"]
    string colorCode = "FFF";

    [Setting category="MenuInfo" name="Text position" min=10 max=3840]
    uint textPosition = 10;

    [Setting category="MenuInfo" name="Spacing" min=1 max=100]
    uint spacingCount = 5;

    [Setting category="MenuInfo" name="WhereAmI"]
    bool showWhereAmI = true;  // false for release

    [Setting category="MenuInfo" name="Server ping" description="only shown when on a server, duh"]
    bool showPing = true;

    [Setting category="MenuInfo" name="COTD countdown"]
    bool showCOTD = true;

    [Setting category="MenuInfo" name="FPS counter"]
    bool showFPS = true;

    [Setting category="MenuInfo" name="Clock"]
    bool showClock = true;
}