// c 2025-04-03
// m 2025-04-03

namespace Ez2 {
    State@ get_state() {
        return _state !is null ? _state : (@_state = InternalState());
    }
}
