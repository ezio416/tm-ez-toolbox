/*
c 2023-06-04
m 2023-06-05
*/

namespace WhereAmI {
    string title = "\\$F84" + Icons::MapMarker + "\\$Z " + Globals::title + " - WhereAmI";

    string GameMode {
        get {
            try {
                string gm = Globals::ServerInfo.CurGameModeStr;
                return gm == "" ? "none" : gm;
            } catch { return "none"; }
        }
    }

    void Render() {
        if (!WAI_show) return;
        if (WAI_hideWithGame && !_GameUI()) return;
        if (WAI_hideWithOP && !_PlanetUI()) return;

        string gamemode = GameMode;
        string sequence = SequenceStr();
        string green = "\\$0F0";
        string red = "\\$F00";

        int flags = UI::WindowFlags::AlwaysAutoResize;

        UI::Begin(title, WAI_show, flags);
            UI::Text(CurrentStr());
            UI::Text((_Editor() ? green : red) + "editor");
            UI::SameLine();
            UI::Text((_Map() ? green : red) + "map");
            UI::SameLine();
            UI::Text((InPlayableMap() ? green : red) + "playground");
            UI::SameLine();
            UI::Text((_Script() ? green : red) + "script");
            UI::Text((_GameUI() ? green : red) + "game UI             ");
            UI::SameLine();
            UI::Text((_PlanetUI() ? green : red) + "Openplanet UI");
            UI::Text("gamemode " + (gamemode != "none" ? green : red) + gamemode);
            UI::Text("sequence " + (sequence != "none" ? green : red) + sequence);
        UI::End();
    }
}