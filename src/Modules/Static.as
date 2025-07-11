// c 2025-06-23
// m 2025-07-10

/*
This module provides information about the player/game/Openplanet/plugin etc. that does not change.
*/

namespace EzStatic {
#if TMNEXT
    AccessLevel _accessLevel;
    /*
    the player's subscription tier
    do not use for actual permission checks, only as a reference
    */
    AccessLevel accessLevel {
        get {
            VerifyEnabled();

            return _accessLevel;
        }
    }
#endif

    /*
    number of bits in the CPU architecture (32 or 64)
    */
    uint8 bits {
        get {
            VerifyEnabled();

#if MANIA32
            return 32;
#elif MANIA64
            return 64;
#endif
        }
    }

    string _exeVersion;
    /*
    the game's executable version
    `App.ManiaPlanetScriptAPI.System.ExeVersion`
    */
    string exeVersion {
        get {
            VerifyEnabled();

            return _exeVersion;
        }
    }

    /*
    the game the player is playing
    */
    GameType gameType {
        get {
            VerifyEnabled();

#if UNITED
            return GameType::TmForever;
#elif MP4
            return GameType::Tm2;
#elif TURBO
            return GameType::TmTurbo;
#elif TMNEXT
            return GameType::Tm2020;
#endif
        }
    }

    /*
    the player's operating system
    */
    OperatingSystem os {
        get {
            VerifyEnabled();

#if WINDOWS
            return OperatingSystem::Windows;
#elif WINDOWS_WINE
            return OperatingSystem::Wine;
#elif LINUX
            return OperatingSystem::Linux;
#endif
        }
    }

    MwId _playerId;
    /*
    the player's game ID (used for PBs)
    `App.UserManagerScript.Users[0].Id`
    */
    MwId playerId {
        get {
            VerifyEnabled();

            return _playerId;
        }
    }

    string _playerLogin;
    /*
    the player's login (not password)
    `App.LocalPlayerInfo.Login`
    */
    string playerLogin {
        get {
            VerifyEnabled();

            return _playerLogin;
        }
    }

    string _playerUsername;
    /*
    the player's username
    `App.LocalPlayerInfo.Name`
    */
    string playerUsername {
        get {
            VerifyEnabled();

            return _playerUsername;
        }
    }

    string _playerWsid;
    /*
    the player's web services ID
    `App.LocalPlayerInfo.WebServicesUserId`
    */
    string playerWsid {
        get {
            VerifyEnabled();

            return _playerWsid;
        }
    }

    void Init() {
        startnew(InitAsync);
    }

    void InitAsync() {
        CTrackMania@ App = EzGame::App;

#if TMNEXT
        _accessLevel = Permissions::CreateClub()
            ? AccessLevel::Club
            : Permissions::PlayLocalMap()
                ? AccessLevel::Standard
                : AccessLevel::Starter
        ;
#endif

        while (App.ManiaPlanetScriptAPI is null) {
            yield();
        }
        _exeVersion = App.ManiaPlanetScriptAPI.ExeVersion;

        while (false
            or App.UserManagerScript is null
            or App.UserManagerScript.Users.Length == 0
            or App.UserManagerScript.Users[0] is null
        ) {
            yield();
        }
        _playerId = App.UserManagerScript.Users[0].Id;

#if TMNEXT
        while (App.LocalPlayerInfo is null) {
            yield();
        }
        _playerLogin = App.LocalPlayerInfo.Login;
        _playerUsername = App.LocalPlayerInfo.Name;
        _playerWsid = App.LocalPlayerInfo.WebServicesUserId;
#else
        CTrackManiaNetwork@ Network = EzGame::Network;
        while (Network.PlayerInfo is null) {
            yield();
        }
        _playerLogin = Network.PlayerInfo.Login;
        _playerUsername = Network.PlayerInfo.Name;
#endif
    }
}
