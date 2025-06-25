// c 2025-04-08
// m 2025-04-08

uint64 GetPtrForNod(CMwNod@ nod) {
    if (nod is null)
        return 0;

    uint64 vtablePtr = Dev::GetOffsetUint64(nod, 0);
    Dev::SetOffset(nod, 0, nod);
    uint64 nodPtr = Dev::GetOffsetUint64(nod, 0);
    Dev::SetOffset(nod, 0, vtablePtr);
    return nodPtr;
}
