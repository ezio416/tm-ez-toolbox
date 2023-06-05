/*
c 2023-06-04
m 2023-06-05
*/

namespace OnlineChecker {
    string title = "\\$9F4" + Icons::InternetExplorer + "\\$Z " + Globals::title + " - OnlineChecker";

    bool Get() {
        return false;
    }

    void Render() {
        if (!OC_show) return;
        if (OC_hideWithGame && !WhereAmI::_GameUI()) return;
        if (OC_hideWithOP && !WhereAmI::_PlanetUI()) return;

        int flags = UI::WindowFlags::AlwaysAutoResize;

        UI::Begin(title, OC_show, flags);
            UI::Text(Get() ? "\\$0F0online" : "\\$F00offline");
            UI::Text("Surely something else can go here...");
        UI::End();
    }
}