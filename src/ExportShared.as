// c 2025-03-29
// m 2025-04-05

namespace Ez2::State {
    shared enum AccessLevel {
        Starter,
        Standard,
        Club
    }

    shared enum Game {
        United,
        Tm2,
        Turbo,
        Tm2020
    }

    shared enum OperatingSystem {
        Windows,
        Wine,
        Linux
    }

    import uint64                               get_frameCount()        from "Ez2";

    import bool                                 get_editor()            from "Ez2";
    import float                                get_fps()               from "Ez2";
    import string                               get_gameMode()          from "Ez2";
    import bool                                 get_guiPlayer()         from "Ez2";
    import bool                                 get_map()               from "Ez2";
    import Ez2::State::MapInfo@                 get_mapInfo()           from "Ez2";
    import bool                                 get_menu()              from "Ez2";
    import bool                                 get_loading()           from "Ez2";
    import bool                                 get_paused()            from "Ez2";
    import bool                                 get_playground()        from "Ez2";
    import bool                                 get_playgroundScript()  from "Ez2";
    import CGamePlaygroundUIConfig::EUISequence get_sequence()          from "Ez2";
    import bool                                 get_viewingControlled() from "Ez2";

    /*
    stores information on the current map
    if you keep a handle to this around, call `.Update()` every frame
    */
    shared class MapInfo {
        private uint _authorTime = uint(-1);
        uint get_authorTime() { return _authorTime; }
        string get_authorTimeFormatted() {
            return _authorTime != uint(-1)
                ? Time::Format(_authorTime)
                : "-:--.---"
            ;
        }

        private uint _bronzeTime = uint(-1);
        uint get_bronzeTime() { return _bronzeTime; }
        string get_bronzeTimeFormatted() {
            return _bronzeTime != uint(-1)
                ? Time::Format(_bronzeTime)
                : "-:--.---"
            ;
        }

        private uint _goldTime = uint(-1);
        uint get_goldTime() { return _goldTime; }
        string get_goldTimeFormatted() {
            return _goldTime != uint(-1)
                ? Time::Format(_goldTime)
                : "-:--.---"
            ;
        }

        private uint _silverTime = uint(-1);
        uint get_silverTime() { return _silverTime; }
        string get_silverTimeFormatted() {
            return _silverTime != uint(-1)
                ? Time::Format(_silverTime)
                : "-:--.---"
            ;
        }

        private string _type;
        string get_type() { return _type; }

        private string _uid;
        string get_uid() { return _uid; }

        void Update() {
            CGameCtnApp@ App = GetApp();

            if (App.RootMap !is null) {
                _authorTime = App.RootMap.TMObjective_AuthorTime;
                _bronzeTime = App.RootMap.TMObjective_BronzeTime;
                _goldTime   = App.RootMap.TMObjective_GoldTime;
                _silverTime = App.RootMap.TMObjective_SilverTime;
                _type       = string(App.RootMap.MapType);
                _uid        = App.RootMap.EdChallengeId;
            } else {
                _authorTime = uint(-1);
                _bronzeTime = uint(-1);
                _goldTime   = uint(-1);
                _silverTime = uint(-1);
                _type       = "";
                _uid        = "";
            }
        }
    }
}

namespace Ez2 {
    shared funcdef void CallbackFunc();

    /*
    Use this class to access all available values in the plugin
    You should check its values every frame to ensure they're accurate
    */
//     shared abstract class State {
//         /*/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//         logic properties
//         derived from base properties
//         /////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

//         private bool _driving = false;
//         private uint64 _last_driving = 0;
//         // whether the player has control of the car
//         bool get_driving() {
//             if (_last_driving != _frameCount) {
//                 _last_driving = _frameCount;

//                 _driving = true
//                     && _inPlayground
//                     && _sequence == CGamePlaygroundUIConfig::EUISequence::Playing
//                     && _viewingControlled
//                     && !viewingReplay
//                 ;
//             }

//             return _driving;
//         }

//         private bool _inMainMenu = false;
//         private uint64 _last_inMainMenu = 0;
//         // whether we're at the main menu
//         bool get_inMainMenu() {  // t1.4
//             if (_last_inMainMenu != _frameCount) {
//                 _last_inMainMenu = _frameCount;

//                 _inMainMenu = true
//                     && !_inEditor
//                     && !_inMap
//                     && _inMenu
//                     && !playgroundScript
//                 ;
//             }

//             return _inMainMenu;
//         }

//         private bool _inMapEditor = false;
//         private uint64 _last_inMapEditor = 0;
//         // whether we're in the map editor
//         bool get_inMapEditor() {  // t1.3
//             if (_last_inMapEditor != _frameCount) {
//                 _last_inMapEditor = _frameCount;

//                 _inMapEditor = true
//                     && _inEditor
//                     && _inMap
//                     && _playgroundScript
//                 ;
//             }

//             return _inMapEditor;
//         }

//         private bool _inMapEditorTesting = false;
//         private uint64 _last_inMapEditorTesting = 0;
//         // whether we're testing/validating a map in the editor
//         bool get_inMapEditorTesting() {  // t2.4
//             if (_last_inMapEditorTesting != _frameCount) {
//                 _last_inMapEditorTesting = _frameCount;

//                 _inMapEditorTesting = true
//                     && _inPlayground
//                     && inMapEditor
//                 ;
//             }

//             return _inMapEditorTesting;
//         }

//         private bool _inReplayEditorEditing = false;
//         private uint64 _last_inReplayEditorEditing = 0;
//         // whether we're editing a replay
//         bool get_inReplayEditorEditing() {  // t1.2
//             if (_last_inReplayEditorEditing != _frameCount) {
//                 _last_inReplayEditorEditing = _frameCount;

//                 _inReplayEditorEditing = true
//                     && _inEditor
//                     && !_playgroundScript
//                 ;
//             }

//             return _inReplayEditorEditing;
//         }

//         private bool _inReplayEditorViewing = false;
//         private uint64 _last_inReplayEditorViewing = 0;
//         // whether we're viewing a local replay file
//         bool get_inReplayEditorViewing() {  // t1.4
//             if (_last_inReplayEditorViewing != _frameCount) {
//                 _last_inReplayEditorViewing = _frameCount;

//                 _inReplayEditorViewing = true
//                     && !_inEditor
//                     && _inMap
//                     && !_inPlayground
//                     && !_loading
//                 ;
//             }

//             return _inReplayEditorViewing;
//         }

//         private bool _inSkinEditor = false;
//         private uint64 _last_inSkinEditor = 0;
//         // whether we're editing a skin in the garage
//         bool get_inSkinEditor() {  // t1.2
//             if (_last_inSkinEditor != _frameCount) {
//                 _last_inSkinEditor = _frameCount;

//                 _inSkinEditor = true
//                     && _inEditor
//                     && !_inMap
//                 ;
//             }

//             return _inSkinEditor;
//         }

//         private bool _playingLocalMap = false;
//         private uint64 _last_playingLocalMap = 0;
//         // whether we're playing a map locally (solo)
//         bool get_playingLocalMap() {  // t2.4
//             if (_last_playingLocalMap != _frameCount) {
//                 _last_playingLocalMap = _frameCount;

//                 _playingLocalMap = true
//                     && _playgroundScript
//                     && playingMap
//                 ;
//             }

//             return _playingLocalMap;
//         }

//         private bool _playingMap = false;
//         private uint64 _last_playingMap = 0;
//         // whether we're playing a map
//         bool get_playingMap() {  // t1.3
//             if (_last_playingMap != _frameCount) {
//                 _last_playingMap = _frameCount;

//                 _playingMap = true
//                     && !_inEditor
//                     && _inMap
//                     && _inPlayground
//                 ;
//             }

//             return _playingMap;
//         }

//         private bool _spectating = false;
//         private uint64 _last_spectating = 0;
//         // whether we're spectating another player or the environment (not cam 7)
//         bool get_spectating() {  // t4.14
//             if (_last_spectating != _frameCount) {
//                 _last_spectating = _frameCount;

//                 _spectating = true
//                     && !_loading
//                     && !_viewingControlled
//                     && !playingLocalMap
//                     && playingMap
//                     && !viewingReplay
//                 ;
//             }

//             return _spectating;
//         }

//         private bool _viewingReplay = false;
//         private uint64 _last_viewingreplay = 0;
//         // whether we're viewing a replay from the leaderboard
//         bool get_viewingReplay() {  // t3.6
//             if (_last_viewingreplay != _frameCount) {
//                 _last_viewingreplay = _frameCount;

//                 _viewingReplay = true
//                     && !_guiPlayer
//                     && !_loading
//                     && _sequence == CGamePlaygroundUIConfig::EUISequence::Playing
//                     && playingLocalMap
//                 ;
//             }

//             return _viewingReplay;
//         }

//         /*/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//         cached properties
//         saved once at boot
//         /////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

// #if MANIA32
//         private uint _bits = 32;
// #elif MANIA64
//         private uint _bits = 64;
// #endif
//         // number of bits in the CPU architecture (32 or 64)
//         uint get_bits() { return _bits; }
//         private void set_bits(uint u) { };

//         private string _exeVersion;
//         /*
//         the game's executable version
//         `App.ManiaPlanetScriptAPI.System.ExeVersion`
//         */
//         string get_exeVersion() { return _exeVersion; }
//         private void set_exeVersion(const string &in e) { }

// #if UNITED
//         private Game _game = Game::United;
// #elif MP3 || MP4
//         private Game _game = Game::Tm2;
// #elif TURBO
//         private Game _game = Game::Turbo;
// #elif TMNEXT
//         private Game _game = Game::Tm2020;
// #endif
//         // the game the player is playing
//         Game get_game() { return _game; }
//         private void set_game(Game g) { }

//         private AccessLevel _localAccessLevel;
//         /*
//         the player's subscription tier
//         do not use for actual permission checks, only as a reference
//         */
//         AccessLevel get_localAccessLevel() { return _localAccessLevel; }
//         private void set_localAccessLevel(AccessLevel a) { }

//         private MwId _localId;
//         /*
//         the player's game ID (used for PBs)
//         `App.UserManagerScript.Users[0].Id`
//         */
//         MwId get_localId() { return _localId; }
//         private void set_localId(MwId l) { }

//         private string _localLogin;
//         /*
//         the player's login (not password)
//         `App.LocalPlayerInfo.Login`
//         */
//         string get_localLogin() { return _localLogin; }
//         private void set_localLogin(const string &in l) { }

//         private string _localUsername;
//         /*
//         the player's username
//         `App.LocalPlayerInfo.Name`
//         */
//         string get_localUsername() { return _localUsername; }
//         private void set_localUsername(const string &in l) { }

//         private string _localWsid;
//         /*
//         the player's web services ID
//         `App.LocalPlayerInfo.WebServicesUserId`
//         */
//         string get_localWsid() { return _localWsid; }
//         private void set_localWsid(const string &in l) { }

// #if WINDOWS
//         private OperatingSystem _os = OperatingSystem::Windows;
// #elif WINDOWS_WINE
//         private OperatingSystem _os = OperatingSystem::Wine;
// #elif LINUX
//         private OperatingSystem _os = OperatingSystem::Linux;
// #endif
//         // the player's operating system
//         OperatingSystem get_os() { return _os; }
//         private void set_os(OperatingSystem o) { }

//         /*/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//         functions
//         /////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

//         protected void GetCachedInfoAsync() {
//             auto App = cast<CTrackMania@>(GetApp());

//             _exeVersion = (true
//                 && App.ManiaPlanetScriptAPI !is null
//                 && App.ManiaPlanetScriptAPI.System !is null
//             )
//                 ? App.ManiaPlanetScriptAPI.System.ExeVersion
//                 : ""
//             ;

//             if (Permissions::CreateClub())
//                 _localAccessLevel = AccessLevel::Club;
//             else if (Permissions::PlayLocalMap())
//                 _localAccessLevel = AccessLevel::Standard;
//             else
//                 _localAccessLevel = AccessLevel::Starter;

//             while (App.LocalPlayerInfo is null)
//                 yield();

//             _localLogin = App.LocalPlayerInfo.Login;
//             _localUsername = string(App.LocalPlayerInfo.Name);
//             _localWsid = App.LocalPlayerInfo.WebServicesUserId;

//             while (false
//                 || App.UserManagerScript is null
//                 || App.UserManagerScript.Users.Length == 0
//                 || App.UserManagerScript.Users[0] is null
//             )
//                 yield();

//             _localId = App.UserManagerScript.Users[0].Id;
//         }
//     }
}
