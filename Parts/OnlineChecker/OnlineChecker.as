/*
c 2023-06-04
m 2023-06-04
*/

namespace OnlineChecker {
    string title = "\\$9F4" + Icons::InternetExplorer + "\\$Z " + Globals::title + " - OnlineChecker";

    bool Get() {
        return false;
    }

    void Render() {
        if (!Settings::showOnlineChecker) return;

        UI::Begin(title, Settings::showOnlineChecker);
            UI::Text(Get() ? "\\$0F0online" : "\\$F00offline");
        UI::End();
    }
}