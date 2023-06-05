/*
c 2023-06-04
m 2023-06-05
*/

void Main() {
    startnew(CoroutineFunc(OnlineChecker::Run));
}

void OnSettingsChanged() {
    if (MenuInfo::MI_colorCode.Length > 3)
        MenuInfo::MI_colorCode = MenuInfo::MI_colorCode.SubStr(0, 3);

    if (OnlineChecker::OC_freq < 10)
        OnlineChecker::OC_freq = 10;
    if (OnlineChecker::OC_warn)
        startnew(CoroutineFunc(OnlineChecker::Run));
}

void Render() {
    WhereAmI::Render();
}

void RenderMenuMain() {
    MenuInfo::Render();
}