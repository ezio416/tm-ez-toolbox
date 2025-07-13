- important note on shared exports: possible unexpected bugs when reloading plugins
    - https://github.com/openplanet-nl/issues/issues/451
    - hard to reproduce consistently
    - forces me to restart the whole game regularly to make sure things still work as expected
    - should only cause issues during development but not in deployment
- my new understanding of exports:
    - importing is only valid from the module name regardless of namespaces, but functions must be accessible from whichever namespace is importing
        - ```asc
            // module name is ModuleA

            namespace NamespaceA {
                void FunctionA() { }

                namespace NamespaceB {
                    void FunctionB() { }
                }
            }

            namespace NamespaceA {
                // valid
                import void FunctionA() from "ModuleA";

                // invalid - NamespaceB is not the module name
                import void FunctionB() from "NamespaceB";

                namespace NamespaceB {
                    // valid
                    import void FunctionB() from "ModuleA";

                    // valid but weird
                    import void FunctionA() from "ModuleA";
                }
            }
            ```
