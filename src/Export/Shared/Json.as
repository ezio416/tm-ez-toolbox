// c 2024-10-21
// m 2025-03-06

/*
Pure functions for safely interacting with Json data.
In case of errors:
    - boolean types return `false`
    - integer types return `-1`
    - string  types return `""` (empty)
    - handle  types return `null`
*/
namespace EzJson {
    /*
    Checks whether a value is of the specified type.
    */
    bool CheckType(Json::Value@ json, Json::Type type = Json::Type::Object) {
        if (json is null)
            return false;

        return json.GetType() == type;
    }

    /*
    Gets a boolean (true/false).
    */
    bool GetBool(Json::Value@ json, const string &in key) {
        try {
            return bool(GetValue(json, key, Json::Type::Boolean));
        } catch {
            return false;
        }
    }

    /*
    Gets a signed 32-bit integer.
    */
    int GetInt(Json::Value@ json, const string &in key) {
        return GetInt32(json, key);
    }

    /*
    Gets a signed 32-bit integer.
    */
    int32 GetInt32(Json::Value@ json, const string &in key) {
        try {
            return int(GetValue(json, key, Json::Type::Number));
        } catch {
            return -1;
        }
    }

    /*
    Gets a signed 64-bit integer.
    */
    int64 GetInt64(Json::Value@ json, const string &in key) {
        try {
            return int64(GetValue(json, key, Json::Type::Number));
        } catch {
            return -1;
        }
    }

    /*
    Gets a string of characters.
    */
    string GetString(Json::Value@ json, const string &in key) {
        try {
            return string(GetValue(json, key, Json::Type::String));
        } catch {
            return "";
        }
    }

    /*
    Gets an unsigned 32-bit integer.
    */
    int GetUint(Json::Value@ json, const string &in key) {
        return GetUint32(json, key);
    }

    /*
    Gets an unsigned 32-bit integer.
    */
    uint32 GetUint32(Json::Value@ json, const string &in key) {
        try {
            return uint32(GetValue(json, key, Json::Type::Number));
        } catch {
            return uint32(-1);
        }
    }

    /*
    Gets an unsigned 64-bit integer.
    */
    uint64 GetUint64(Json::Value@ json, const string &in key) {
        try {
            return uint64(GetValue(json, key, Json::Type::Number));
        } catch {
            return uint64(-1);
        }
    }

    /*
    Gets a nested value and ensures it is of the specified type.
    */
    Json::Value@ GetValue(Json::Value@ json, const string &in key, Json::Type type = Json::Type::Object) {
        if (json is null || !json.HasKey(key))
            return null;

        Json::Value@ value = json.Get(key);

        if (!CheckType(value, type))
            return null;

        return value;
    }
}
