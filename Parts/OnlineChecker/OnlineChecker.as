/*
c 2023-06-04
m 2023-06-05
*/

namespace OnlineChecker {
    bool online = false;
    bool running = false;
    string title = "\\$9F4" + Icons::InternetExplorer + "\\$Z " + Globals::title + " - OnlineChecker";

    bool Get() {
        return online;
    }

    void Run() {
        if (running) return;
        running = true;

        NadeoServices::AddAudience("NadeoLiveServices");
        while (!NadeoServices::IsAuthenticated("NadeoLiveServices")) yield();

        while (true) {
            if (!OC_warn) {
                running = false;
                return;
            }

            try {
                auto req = NadeoServices::Get(
                    "NadeoLiveServices",
                    NadeoServices::BaseURL() + "/api/token/campaign/official?length=1&offset=999"
                );
                req.Start();
                while (!req.Finished()) yield();
                online = (req.String() != "");
            } catch { online = false; }

            online = (
                online &&
                Globals::Network !is null &&
                Globals::ServerInfo.IsOnline
            );

            if (!online)
                UI::ShowNotification(
                    Globals::title + " - OnlineChecker",
                    "It looks like you're offline! Records probably won't save.",
                    UI::HSV(0.02, 0.8, 0.9)
                );

            sleep(OC_freq * 1000);
        }
    }
}