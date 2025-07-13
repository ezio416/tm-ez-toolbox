// c 2025-07-13
// m 2025-07-13

/*
Safely interacts with Json data.
In case of errors:
    - boolean types return `false`
    - integer types return `0`
    - string types return `""` (empty)
    - handle types return `null`
*/
namespace EzJson {
    shared bool CheckType(Json::Value@ json, const Json::Type type = Json::Type::Object) {
        if (json is null) {
            return false;
        }

        return json.GetType() == type;
    }

    shared bool GetBool(Json::Value@ json, const string&in key) {
        try {
            return bool(GetValue(json, key, Json::Type::Boolean));
        } catch {
            return false;
        }
    }

    shared int GetInt(Json::Value@ json, const string&in key) {
        return GetInt32(json, key);
    }

    shared int GetInt32(Json::Value@ json, const string&in key) {
        try {
            return int(GetValue(json, key, Json::Type::Number));
        } catch {
            return 0;
        }
    }

    shared int64 GetInt64(Json::Value@ json, const string&in key) {
        try {
            return int64(GetValue(json, key, Json::Type::Number));
        } catch {
            return 0;
        }
    }

    shared string GetString(Json::Value@ json, const string&in key) {
        try {
            return string(GetValue(json, key, Json::Type::String));
        } catch {
            return "";
        }
    }

    shared uint GetUint(Json::Value@ json, const string&in key) {
        return GetUint32(json, key);
    }

    shared uint GetUint32(Json::Value@ json, const string&in key) {
        try {
            return uint32(GetValue(json, key, Json::Type::Number));
        } catch {
            return 0;
        }
    }

    shared uint64 GetUint64(Json::Value@ json, const string&in key) {
        try {
            return uint64(GetValue(json, key, Json::Type::Number));
        } catch {
            return 0;
        }
    }

    shared Json::Value@ GetValue(Json::Value@ json, const string&in key, const Json::Type type = Json::Type::Object) {
        if (false
            or json is null
            or !json.HasKey(key)
        ) {
            return null;
        }

        Json::Value@ value = json.Get(key);

        if (!CheckType(value, type)) {
            return null;
        }

        return value;
    }
}
