// c 2025-04-03
// m 2025-04-03

void CleanUp(const string &in type = "") {
    if (type.Length > 0)
        warn(type + ", cleaning up...");

    @_state = null;
}

string ColoredBool(bool b) {
    return (b ? "\\$0F0" : "\\$F00") + b;
}
