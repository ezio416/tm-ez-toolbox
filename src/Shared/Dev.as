// c 2025-07-13
// m 2025-07-20

/*
Uses the Dev:: API for direct memory interaction. Many things here are courtesy of XertroV.
*/
namespace EzDev {
    shared bool CheckClassType(const Reflection::MwClassInfo@ info, const string&in name) {
        if (info is null) {
            return false;
        }

        if (info.Name == name) {
            return true;
        }

        return CheckClassType(info.BaseType, name);
    }

#if MANIA64
    shared uint64 CheckPointer(const uint64 ptr) {
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
    shared uint CheckPointer(const uint ptr) {
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

    shared uint16 GetMemberOffset(const string&in className, const string&in memberName) {
        const Reflection::MwClassInfo@ info = Reflection::GetType(className);
        if (info is null) {
            throw("Unable to find reflection info for '" + className + "'");
        }

        const Reflection::MwMemberInfo@ member = info.GetMember(memberName);
        if (member is null) {
            throw("Unable to find reflection info for member '" + memberName + "' in '" + className + "'");
        }

        return member.Offset != MAX_UINT16 ? member.Offset : 0;
    }

    shared uint16 GetMemberOffset(CMwNod@ nod, const string&in memberName) {
        if (nod is null) {
            throw("Passed nod is null!");
        }

        const Reflection::MwClassInfo@ info = Reflection::TypeOf(nod);

        const Reflection::MwMemberInfo@ member = info.GetMember(memberName);
        if (member is null) {
            throw("Unable to find reflection info for member '" + memberName + "' in '" + info.Name + "'");
        }

        return member.Offset != MAX_UINT16 ? member.Offset : 0;
    }

#if MANIA64
    shared uint64 GetNodPointer(CMwNod@ nod) {
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
    shared uint GetNodPointer(CMwNod@ nod) {
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

    shared CMwNod@ SafeGetOffsetNod(const CMwNod@ nod, const uint16 offset) {
        if (false
            or nod is null
            or offset == 0
            or offset == MAX_UINT16
        ) {
            return null;
        }

#if MANIA64
        const uint64 nodPtr = CheckPointer(Dev::GetOffsetUint64(nod, offset));
        if (nodPtr == 0) {
            return null;
        }

        const uint64 vtablePtr = CheckPointer(Dev::ReadUInt64(nodPtr));
        if (false
            or vtablePtr < Dev::BaseAddress()
            or vtablePtr > Dev::BaseAddressEnd()
        ) {
            return null;
        }
#else
        const uint nodPtr = CheckPointer(Dev::GetOffsetUint32(nod, offset));
        if (nodPtr == 0) {
            return null;
        }

        const uint vtablePtr = CheckPointer(Dev::ReadUInt32(nodPtr));
        if (false
            or vtablePtr < Dev::BaseAddress()
            or vtablePtr > Dev::BaseAddressEnd()
        ) {
            return null;
        }
#endif

        return Dev::GetOffsetNod(nod, offset);
    }

    shared CMwNod@ SafeGetOffsetNod(CMwNod@ nod, const uint16 offset, const string&in name) {
        CMwNod@ newNod = SafeGetOffsetNod(nod, offset);
        if (newNod is null) {
            return null;
        }

        return CheckClassType(Reflection::TypeOf(newNod), name) ? newNod : null;
    }
}
