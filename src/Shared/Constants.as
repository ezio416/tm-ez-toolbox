// c 2025-03-29
// m 2025-07-13

/*
This module is not namespaced for convenience. If a dependent plugin wishes
to define these variables, they should be the same values anyway.
*/

const int8   MAX_INT8   = (1 << 7) - 1;
const int16  MAX_INT16  = (1 << 15) - 1;
const int    MAX_INT32  = (1 << 31) - 1;
const int8   MIN_INT8   = -MAX_INT8 - 1;
const int16  MIN_INT16  = -MAX_INT16 - 1;
const int    MIN_INT32  = -MAX_INT32 - 1;
const uint8  MAX_UINT8  = uint8(-1);
const uint16 MAX_UINT16 = uint16(-1);
const uint   MAX_UINT32 = uint(-1);
#if MANIA64
const int64  MAX_INT64  = (int64(1) << 63) - 1;
const int64  MIN_INT64  = MAX_INT64 + 1;
const uint64 MAX_UINT64 = uint64(-1);
#endif
