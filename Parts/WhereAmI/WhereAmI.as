/*
c 2023-06-04
m 2023-06-04
*/

namespace WhereAmI {
    string title = "\\$F44" + Icons::QuestionCircle + "\\$Z " + Globals::title + " - WhereAmI";

    string GameMode {
        get {
            try {
                string gm = Globals::ServerInfo.CurGameModeStr;
                return gm == "" ? "none" : gm;
            } catch { return "none"; }
        }
    }

    void Render() {
        if (!Settings::showWhereAmI) return;

        string gamemode = GameMode;
        string sequence = SequenceStr();
        string green = "\\$0F0";
        string red = "\\$F00";

        UI::Begin(title, Settings::showWhereAmI);
            UI::Text(CurrentStr());
            UI::Text((_Editor() ? green : red) + "editor");
            UI::SameLine();
            UI::Text((_Map() ? green : red) + "map");
            UI::SameLine();
            UI::Text((InPlayableMap() ? green : red) + "playground");
            UI::SameLine();
            UI::Text((_Script() ? green : red) + "script");
            UI::Text("gamemode " + (gamemode != "none" ? green : red) + gamemode);
            UI::Text("sequence " + (sequence != "none" ? green : red) + sequence);
        UI::End();
    }
}