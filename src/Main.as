/*
c 2023-06-04
m 2023-10-18
*/

void Main() {
#if DEPENDENCY_NADEOSERVICES
    startnew(CoroutineFunc(OnlineChecker::Run));
#endif
}

void OnSettingsChanged() {
    if (MenuInfo::MI_colorCode.Length > 3)
        MenuInfo::MI_colorCode = MenuInfo::MI_colorCode.SubStr(0, 3);

#if DEPENDENCY_NADEOSERVICES
    if (OnlineChecker::OC_freq < 10)
        OnlineChecker::OC_freq = 10;
    if (OnlineChecker::OC_warn)
        startnew(CoroutineFunc(OnlineChecker::Run));
#endif
}

void Render() {
#if TMNEXT
    WhereAmI::Render();
#endif
}

void RenderMenuMain() {
    MenuInfo::Render();
}