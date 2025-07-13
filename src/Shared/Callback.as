// c 2025-07-13
// m 2025-07-13

/*
Allows plugins to register callback functions that will be called under certain conditions.
*/
namespace EzCallback {
    /*
    class containing callback functions a plugin desires to use
    instructions:
    - inherit this class
    - override any .On\<MethodName>() methods
    - in the constructor, call super() and set the respective .on\<MethodName> values true for any overridden methods
    - pass an instance of your class to EzCallback::Register()
    asynchronous methods are marked as such - all others are not yieldable
    */
    shared abstract class Callback {
        private Meta::Plugin@ _parent;
        Meta::Plugin@ get_parent() const final {
            return _parent;
        }
        private void set_parent(Meta::Plugin@ p) { }

        private bool _onEnteredMap = false;
        bool get_onEnteredMap() { return _onEnteredMap; }
        protected void set_onEnteredMap(bool o) { _onEnteredMap = o; }

        private bool _onEnteredMapAsync = false;
        bool get_onEnteredMapAsync() { return _onEnteredMapAsync; }
        protected void set_onEnteredMapAsync(bool o) { _onEnteredMapAsync = o; }

        private bool _onExitedMap = false;
        bool get_onExitedMap() { return _onExitedMap; }
        protected void set_onExitedMap(bool o) { _onExitedMap = o; }

        private bool _onExitedMapAsync = false;
        bool get_onExitedMapAsync() { return _onExitedMapAsync; }
        protected void set_onExitedMapAsync(bool o) { _onExitedMapAsync = o; }

        uint get_count() {
            uint ret = 0;

            if (_onEnteredMap) {
                ret += 1;
            }
            if (onEnteredMapAsync) {
                ret += 1;
            }
            if (_onExitedMap) {
                ret += 1;
            }
            if (onExitedMapAsync) {
                ret += 1;
            }

            return ret;
        }

        Callback() {
            @_parent = Meta::ExecutingPlugin();
        }

        void OnEnteredMap() {
            if (onEnteredMap) {
                throw("plugin '" + (parent !is null ? parent.ID : "") +  "' did not override callback for OnEnteredMap!");
            }
        }
        void OnEnteredMapAsync() {
            if (onEnteredMapAsync) {
                throw("plugin '" + (parent !is null ? parent.ID : "") +  "' did not override callback for OnEnteredMapAsync!");
            }
        }
        void _OnEnteredMap() final {
            if (parent !is null) {
                if (_onEnteredMap) {
                    trace("OnEnteredMap: plugin '" + parent.ID + "'");
                    this.OnEnteredMap();
                }

                if (_onEnteredMapAsync) {
                    trace("OnEnteredMapAsync: plugin '" + parent.ID + "'");
                    startnew(CoroutineFunc(this.OnEnteredMapAsync));
                }
            }
        }

        void OnExitedMap() {
            if (onExitedMap) {
                throw("plugin '" + (parent !is null ? parent.ID : "") +  "' did not override callback for OnExitedMap!");
            }
        }
        void OnExitedMapAsync() {
            if (onExitedMapAsync) {
                throw("plugin '" + (parent !is null ? parent.ID : "") +  "' did not override callback for OnExitedMapAsync!");
            }
        }
        void _OnExitedMap() final {
            if (parent !is null) {
                if (_onExitedMap) {
                    trace("OnExitedMap: plugin '" + parent.ID + "'");
                    this.OnExitedMap();
                }

                if (_onExitedMapAsync) {
                    trace("OnExitedMapAsync: plugin '" + parent.ID + "'");
                    startnew(CoroutineFunc(this.OnExitedMapAsync));
                }
            }
        }
    }
}
