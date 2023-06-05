/*
c 2023-06-04
m 2023-06-05
*/

namespace OnlineChecker {
    [Setting category="OnlineChecker" name="Enabled"]
    bool OC_enabled = false;

    [Setting category="OnlineChecker" name="Show offline warnings"]
    bool OC_warn = true;

    [Setting category="OnlineChecker" name="Check frequency (seconds)" min=10 max=600]
    uint OC_freq = 60;
}