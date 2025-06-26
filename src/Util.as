// c 2025-04-03
// m 2025-06-25

string ColoredBool(const bool b) {
    return (b ? "\\$0F0" : "\\$F00") + b + "\\$G";
}
