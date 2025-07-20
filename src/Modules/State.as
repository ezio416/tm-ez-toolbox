// c 2025-04-04
// m 2025-07-14

/*
Stores information about the game that changes. Although most things in this module are shared,
it is recommended that you do not use them in shared code in case of future plugin updates.
*/
namespace EzState {
    MapInfo _mapInfo;
    /*
    info on the current map
    */
    MapInfo@ get_mapInfo() {
        return _mapInfo.Update();
    }
}
