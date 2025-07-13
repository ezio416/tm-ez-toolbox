// c 2025-07-13
// m 2025-07-13

/*
Stores information about things that do not change.
*/
namespace EzStatic {
#if TMNEXT
    shared enum AccessLevel {
        Starter,
        Standard,
        Club
    }
#endif

    shared enum GameType {
        TmForever,
        Tm2,
        TmTurbo,
        Tm2020
    }

    shared enum OperatingSystem {
        Windows,
        Wine,
        Linux
    }
}
