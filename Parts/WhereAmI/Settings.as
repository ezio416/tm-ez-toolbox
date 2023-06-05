/*
c 2023-06-03
m 2023-06-05
*/

namespace WhereAmI {
    [Setting category="WhereAmI" name="Enabled"]
    bool WAI_enabled = true;

    [Setting category="WhereAmI" name="Show window"]
    bool WAI_show = true;  // false for release

    [Setting category="WhereAmI" name="Hide with game UI"]
    bool WAI_hideWithGame = true;

    [Setting category="WhereAmI" name="Hide with Openplanet UI"]
    bool WAI_hideWithOP = false;  // true for release
}