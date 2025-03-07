// c 2025-03-06
// m 2025-03-06

namespace EzGame {
    import CGameCtnEditorFree@                  get_Editor()           from "EzGame";
    import string                               get_GameMode()         from "EzGame";
    import CTrackManiaNetwork@                  get_Network()          from "EzGame";
    import CGameCtnChallenge@                   get_RootMap()          from "EzGame";
    import CGamePlaygroundUIConfig::EUISequence get_Sequence()         from "EzGame";
    import CTrackManiaNetworkServerInfo@        get_ServerInfo()       from "EzGame";
    import CDx11Viewport@                       get_Viewport()         from "EzGame";
#if TMNEXT
    import string                               get_ExeVersion()       from "EzGame";
    import CSmArenaClient@                      get_Playground()       from "EzGame";
    import CSmArenaRulesMode@                   get_PlaygroundScript() from "EzGame";
#elif MP4
    import CGamePlayground@                     get_Playground()       from "EzGame";
    import CTrackManiaRaceRules@                get_PlaygroundScript() from "EzGame";
#elif TURBO
    import CGamePlayground@                     get_Playground()       from "EzGame";
    import CTrackManiaRaceRules@                get_PlaygroundScript() from "EzGame";
#endif

    import bool PlayMapAsync(const string &in uid) from "EzGame";
}
