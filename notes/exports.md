- important note on shared exports: possible unexpected bugs when reloading plugins
    - https://github.com/openplanet-nl/issues/issues/451
    - hard to reproduce consistently
    - forces me to restart the whole game regularly to make sure things still work as expected
    - should only cause issues during development but not in deployment
- importing functions in a shared file (very unconventional) seems to work fine and lets me use them within this plugin, testing namespace stuff, but I must do it in a particular way:
    - imports are only valid from a namespace that matches the module name
        - ```asc
            namespace NamespaceA {  // module name
                void FunctionA() { }

                namespace NamespaceB {
                    void FunctionB() { }
                }
            }

            namespace NamespaceC {
                void FunctionC() { }
            }

            namespace NamespaceA {
                // valid
                import void FunctionA() from "NamespaceA";

                // invalid - nested namespaces are not supported
                import void FunctionB() from "NamespaceA::NamespaceB";

                // invalid - NamespaceC is not the module name
                import void FunctionC() from "NamespaceC";
            }
            ```
    - imports themselves can be in any namespace in or under `NamespaceA`
        - ```asc
            namespace NamespaceA {
                import void FunctionA() from "NamespaceA";

                namespace NamespaceB {
                    import void FunctionB() from "NamespaceA";
                }
            }

            namespace NamespaceC {
                // invalid - works for a normal export but not shared? idk it's weird
                import void FunctionC() from "NamespaceA";
            }
            ```
- actually, doing namespaces in the way I want will require normal exports. Not a huge deal I guess
