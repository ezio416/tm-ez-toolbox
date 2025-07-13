// c 2025-04-08
// m 2025-07-13

/*
This module is for anything involving the Dev:: API. Most things are are courtesy of XertroV.
*/

namespace EzDev {
#if MANIA64
    uint64 CheckPointer(const uint64 ptr) {
        if (ptr == 0) {
            return 0;
        }

        try {
            Dev::SafeReadUInt8(ptr);
            return ptr;
        } catch {
            return 0;
        }
    }
#else
    uint CheckPointer(const uint ptr) {
        if (ptr == 0) {
            return 0;
        }

        try {
            Dev::SafeReadUInt8(ptr);
            return ptr;
        } catch {
            return 0;
        }
    }
#endif

#if MANIA64
    uint64 GetNodPointer(CMwNod@ nod) {
        if (nod is null) {
            return 0;
        }

        const uint64 vtablePtr = Dev::GetOffsetUint64(nod, 0);
        Dev::SetOffset(nod, 0, nod);
        const uint64 nodPtr = Dev::GetOffsetUint64(nod, 0);
        Dev::SetOffset(nod, 0, vtablePtr);

        return nodPtr;
    }
#else
    uint GetNodPointer(CMwNod@ nod) {
        if (nod is null) {
            return 0;
        }

        const uint vtablePtr = Dev::GetOffsetUint32(nod, 0);
        Dev::SetOffset(nod, 0, nod);
        const uint nodPtr = Dev::GetOffsetUint32(nod, 0);
        Dev::SetOffset(nod, 0, vtablePtr);

        return nodPtr;
    }
#endif
}
