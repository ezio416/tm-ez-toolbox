// c 2025-06-23
// m 2025-06-24

/*
This module provides information about the player/game/Openplanet/plugin etc. that does not change.
*/

namespace Ez2 {
    Static::AccessLevel _accessLevel;
    /*
    the player's subscription tier
    do not use for actual permission checks, only as a reference
    */
    Static::AccessLevel accessLevel {
        get {
            return _accessLevel;
        }
    }

    /*
    number of bits in the CPU architecture (32 or 64)
    */
    uint8 bits {
        get {
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
            return _exeVersion;
        }
    }

    /*
    the game the player is playing
    */
    Static::GameType gameType {
        get {
#if UNITED
            return Static::GameType::TmForever;
#elif MP3 || MP4
            return Static::GameType::Tm2;
#elif TURBO
            return Static::GameType::TmTurbo;
#elif TMNEXT
            return Static::GameType::Tm2020;
#endif
        }
    }

    /*
    the player's operating system
    */
    Static::OperatingSystem os {
        get {
#if WINDOWS
            return Static::OperatingSystem::Windows;
#elif WINDOWS_WINE
            return Static::OperatingSystem::Wine;
#elif LINUX
            return Static::OperatingSystem::Linux;
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
            return _playerWsid;
        }
    }

    void InitStatic() {
        startnew(InitStaticAsync);
    }

    void InitStaticAsync() {
        auto App = cast<CTrackMania>(GetApp());

        _accessLevel = Permissions::CreateClub()
            ? Static::AccessLevel::Club
            : Permissions::PlayLocalMap()
                ? Static::AccessLevel::Standard
                : Static::AccessLevel::Starter
        ;

        while (false
            or App.ManiaPlanetScriptAPI is null
            or App.ManiaPlanetScriptAPI.System is null
        ) {
            yield();
        }
        _exeVersion = App.ManiaPlanetScriptAPI.System.ExeVersion;

        while (false
            or App.UserManagerScript is null
            or App.UserManagerScript.Users.Length == 0
            or App.UserManagerScript.Users[0] is null
        ) {
            yield();
        }
        _playerId = App.UserManagerScript.Users[0].Id;

        while (App.LocalPlayerInfo is null) {
            yield();
        }
        _playerLogin = App.LocalPlayerInfo.Login;
        _playerUsername = App.LocalPlayerInfo.Name;
        _playerWsid = App.LocalPlayerInfo.WebServicesUserId;
    }
}
