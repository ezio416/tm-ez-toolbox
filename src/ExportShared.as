// c 2025-03-29
// m 2025-04-03

namespace Ez2 {
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

    /*
    Use this class to access all available values in the plugin
    You should check its values every frame to ensure they're accurate
    */
    abstract shared class State {
        private uint64 _frameCount = 0;
        uint64 get_frameCount() final { return _frameCount; }

        /*/////////////////////////////////////////////////////////////////////////////////////////////////////////////
        base properties
        set in main loop
        t1.1
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

        protected uint _authorTime = 0;
        /*
        the current map's author medal time
        `App.RootMap.TMObjective_AuthorTime`
        */
        uint get_authorTime() final { return _authorTime; }

        protected uint _bronzeTime = 0;
        /*
        the current map's bronze medal time
        `App.RootMap.TMObjective_BronzeTime`
        */
        uint get_bronzeTime() final { return _bronzeTime; }

        protected float _fps = 0.0f;
        /*
        the current average framerate
        `App.Viewport.AverageFps`
        */
        float get_fps() final { return _fps; }

        protected string _gameMode;
        /*
        the current game mode
        `App.Network.ServerInfo.CurGameModeStr`
        */
        string get_gameMode() final { return _gameMode; }

        protected uint _goldTime = 0;
        /*
        the current map's gold medal time
        `App.RootMap.TMObjective_GoldTime`
        */
        uint get_goldTime() final { return _goldTime; }

        protected bool _guiPlayer = false;
        /*
        whether there exists a valid GUIPlayer
        `App.CurrentPlayground.GameTerminals[0].GUIPlayer`
        */
        bool get_guiPlayer() final { return _guiPlayer; }

        protected bool _inEditor = false;
        /*
        whether we're in an editor
        `App.Editor`
        */
        bool get_inEditor() final { return _inEditor; }

        protected bool _inMap = false;
        /*
        whether we're in a map or there exists a valid one
        `App.RootMap`
        */
        bool get_inMap() final { return _inMap; }

        protected bool _inMenu = false;
        /*
        whether the game's menus are shown (not UI layers)
        `App.ActiveMenus`
        */
        bool get_inMenu() final { return _inMenu; }

        protected bool _inPlayground = false;
        /*
        whether we're in a drivable map
        `App.CurrentPlayground`
        */
        bool get_inPlayground() final { return _inPlayground; }

        protected bool _loading = false;
        /*
        whether the game is loading in or out of a map or editor
        `App.LoadProgress.State`
        */
        bool get_loading() final { return _loading; }

        protected string _mapType;
        /*
        the type of the current map
        `App.RootMap.MapType`
        */
        string get_mapType() final { return _mapType; }

        protected string _mapUid;
        /*
        the UID of the current map
        `App.RootMap.EdChallengeId`
        */
        string get_mapUid() final { return _mapUid; }

        protected bool _paused = false;
        /*
        whether the pause menu is shown
        `App.Network.PlaygroundClientScriptAPI.IsInGameMenuDisplayed`
        */
        bool get_paused() final { return _paused; }

        protected bool _playgroundScript = false;
        /*
        whether there exists a valid playground script
        `App.PlaygroundScript`
        */
        bool get_playgroundScript() final { return _playgroundScript; }

        protected uint _silverTime = 0;
        /*
        the current map's silver medal time
        `App.RootMap.TMObjective_SilverTime`
        */
        uint get_silverTime() final { return _silverTime; }

        protected CGamePlaygroundUIConfig::EUISequence _sequence = CGamePlaygroundUIConfig::EUISequence::None;
        /*
        the current UI sequence
        `App.CurrentPlayground.UIConfigs[0].UISequence`
        */
        CGamePlaygroundUIConfig::EUISequence get_sequence() final { return _sequence; }

        protected string _viewingLogin;
        /*
        the login of the current viewed player
        `VehicleState::GetViewingPlayer().ScriptAPI.Login`
        */
        string get_viewingLogin() final { return _viewingLogin; }

        /*/////////////////////////////////////////////////////////////////////////////////////////////////////////////
        logic properties
        derived from base properties
        calculate values once per frame
        t[ier]funcCallCount.totalPrivateAccesses
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

        private bool _driving = false;
        private uint64 _last_driving = 0;
        // whether the player has control of the car
        bool get_driving() final {  // t4.11
            if (_last_driving != _frameCount) {
                _last_driving = _frameCount;

                _driving = true
                    && _inPlayground
                    && _sequence == CGamePlaygroundUIConfig::EUISequence::Playing
                    && _localLogin.Length > 0
                    && _localLogin == _viewingLogin
                    && !viewingReplay
                ;
            }

            return _driving;
        }

        private bool _inMainMenu = false;
        private uint64 _last_inMainMenu = 0;
        // whether we're at the main menu
        bool get_inMainMenu() final {  // t1.3
            if (_last_inMainMenu != _frameCount) {
                _last_inMainMenu = _frameCount;

                _inMainMenu = true
                    && !_inEditor
                    && !_inMap
                    && _inMenu
                ;
            }

            return _inMainMenu;
        }

        private bool _inMapEditor = false;
        private uint64 _last_inMapEditor = 0;
        // whether we're in the map editor
        bool get_inMapEditor() final {  // t1.3
            if (_last_inMapEditor != _frameCount) {
                _last_inMapEditor = _frameCount;

                _inMapEditor = true
                    && _inEditor
                    && _inMap
                    && _playgroundScript
                ;
            }

            return _inMapEditor;
        }

        private bool _inMapEditorTesting = false;
        private uint64 _last_inMapEditorTesting = 0;
        // whether we're testing/validating a map in the editor
        bool get_inMapEditorTesting() final {  // t2.4
            if (_last_inMapEditorTesting != _frameCount) {
                _last_inMapEditorTesting = _frameCount;

                _inMapEditorTesting = true
                    && _inPlayground
                    && inMapEditor
                ;
            }

            return _inMapEditorTesting;
        }

        private bool _inReplayEditorEditing = false;
        private uint64 _last_inReplayEditorEditing = 0;
        // whether we're editing a replay
        bool get_inReplayEditorEditing() final {  // t1.2
            if (_last_inReplayEditorEditing != _frameCount) {
                _last_inReplayEditorEditing = _frameCount;

                _inReplayEditorEditing = true
                    && _inEditor
                    && !_playgroundScript
                ;
            }

            return _inReplayEditorEditing;
        }

        private bool _inReplayEditorViewing = false;
        private uint64 _last_inReplayEditorViewing = 0;
        // whether we're viewing a local replay file
        bool get_inReplayEditorViewing() final {  // t1.4
            if (_last_inReplayEditorViewing != _frameCount) {
                _last_inReplayEditorViewing = _frameCount;

                _inReplayEditorViewing = true
                    && !_inEditor
                    && _inMap
                    && !_inPlayground
                    && !_loading
                ;
            }

            return _inReplayEditorViewing;
        }

        private bool _inSkinEditor = false;
        private uint64 _last_inSkinEditor = 0;
        // whether we're editing a skin in the garage
        bool get_inSkinEditor() final {  // t1.2
            if (_last_inSkinEditor != _frameCount) {
                _last_inSkinEditor = _frameCount;

                _inSkinEditor = true
                    && _inEditor
                    && !_inMap
                ;
            }

            return _inSkinEditor;
        }

        private bool _playingLocalMap = false;
        private uint64 _last_playingLocalMap = 0;
        // whether we're playing a map locally (solo)
        bool get_playingLocalMap() final {  // t2.4
            if (_last_playingLocalMap != _frameCount) {
                _last_playingLocalMap = _frameCount;

                _playingLocalMap = true
                    && _playgroundScript
                    && playingMap
                ;
            }

            return _playingLocalMap;
        }

        private bool _playingMap = false;
        private uint64 _last_playingMap = 0;
        // whether we're playing a map
        bool get_playingMap() final {  // t1.3
            if (_last_playingMap != _frameCount) {
                _last_playingMap = _frameCount;

                _playingMap = true
                    && !_inEditor
                    && _inMap
                    && _inPlayground
                ;
            }

            return _playingMap;
        }

        private bool _spectating = false;
        private uint64 _last_spectating = 0;
        // whether we're spectating another player
        bool get_spectating() final {  // t4.14
            if (_last_spectating != _frameCount) {
                _last_spectating = _frameCount;

                _spectating = true
                    && _inPlayground
                    && _localLogin.Length > 0
                    && _localLogin != _viewingLogin
                    && !playingLocalMap
                    && !viewingReplay
                ;
            }

            return _spectating;
        }

        private bool _viewingReplay = false;
        private uint64 _last_viewingreplay = 0;
        // whether we're viewing a replay from the leaderboard
        bool get_viewingReplay() final {  // t3.6
            if (_last_viewingreplay != _frameCount) {
                _last_viewingreplay = _frameCount;

                _viewingReplay = true
                    && !_guiPlayer
                    && _sequence == CGamePlaygroundUIConfig::EUISequence::Playing
                    && playingLocalMap
                ;
            }

            return _viewingReplay;
        }

        /*/////////////////////////////////////////////////////////////////////////////////////////////////////////////
        cached properties
        saved once at boot
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

#if MANIA32
        private uint _bits = 32;
#elif MANIA64
        private uint _bits = 64;
#endif
        uint get_bits() final { return _bits; }
        private void set_bits(uint u) final { };

        private string _exeVersion;
        /*
        the game's executable version
        `App.ManiaPlanetScriptAPI.System.ExeVersion`
        */
        string get_exeVersion() final { return _exeVersion; }
        private void set_exeVersion(const string &in e) final { }

#if UNITED
        private Game _game = Game::United;
#elif MP3 || MP4
        private Game _game = Game::Tm2;
#elif TURBO
        private Game _game = Game::Turbo;
#elif TMNEXT
        private Game _game = Game::Tm2020;
#endif
        // the game the player is playing
        Game get_game() final { return _game; }
        private void set_game(Game g) final { }

        private AccessLevel _localAccessLevel;
        /*
        the player's subscription tier
        do not use for actual permission checks, only as a reference
        */
        AccessLevel get_localAccessLevel() final { return _localAccessLevel; }
        private void set_localAccessLevel(AccessLevel a) final { }

        private MwId _localId;
        /*
        the player's game ID (used for PBs)
        `App.UserManagerScript.Users[0].Id`
        */
        MwId get_localId() final { return _localId; }
        private void set_localId(MwId l) final { }

        private string _localLogin;
        /*
        the player's login (not password)
        `App.LocalPlayerInfo.Login`
        */
        string get_localLogin() final { return _localLogin; }
        private void set_localLogin(const string &in l) final { }

        private string _localUsername;
        /*
        the player's username
        `App.LocalPlayerInfo.Name`
        */
        string get_localUsername() final { return _localUsername; }
        private void set_localUsername(const string &in l) final { }

        private string _localWsid;
        /*
        the player's web services ID
        `App.LocalPlayerInfo.WebServicesUserId`
        */
        string get_localWsid() final { return _localWsid; }
        private void set_localWsid(const string &in l) final { }

#if WINDOWS
        private OperatingSystem _os = OperatingSystem::Windows;
#elif WINDOWS_WINE
        private OperatingSystem _os = OperatingSystem::Wine;
#elif LINUX
        private OperatingSystem _os = OperatingSystem::Linux;
#endif
        // the player's operating system
        OperatingSystem get_os() final { return _os; }
        private void set_os(OperatingSystem o) final { }

        /*/////////////////////////////////////////////////////////////////////////////////////////////////////////////
        functions
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

        protected void CountAsync() final {
            while (true) {
                _frameCount++;
                yield();
            }
        }

        protected void GetCachedInfoAsync() final {
            auto App = cast<CTrackMania@>(GetApp());

            _exeVersion = (true
                && App.ManiaPlanetScriptAPI !is null
                && App.ManiaPlanetScriptAPI.System !is null
            )
                ? App.ManiaPlanetScriptAPI.System.ExeVersion
                : ""
            ;

            if (Permissions::CreateClub())
                _localAccessLevel = AccessLevel::Club;
            else if (Permissions::PlayLocalMap())
                _localAccessLevel = AccessLevel::Standard;
            else
                _localAccessLevel = AccessLevel::Starter;

            while (App.LocalPlayerInfo is null)
                yield();

            _localLogin = App.LocalPlayerInfo.Login;
            _localUsername = string(App.LocalPlayerInfo.Name);
            _localWsid = App.LocalPlayerInfo.WebServicesUserId;

            while (false
                || App.UserManagerScript is null
                || App.UserManagerScript.Users.Length == 0
                || App.UserManagerScript.Users[0] is null
            )
                yield();

            _localId = App.UserManagerScript.Users[0].Id;
        }
    }
}
