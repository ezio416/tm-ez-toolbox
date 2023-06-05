/*
c 2023-06-04
m 2023-06-05
*/

void Main() { }

void OnSettingsChanged() {
    if (MenuInfo::MI_colorCode.Length > 3)
        MenuInfo::MI_colorCode = MenuInfo::MI_colorCode.SubStr(0, 3);
}

void Render() {
    OnlineChecker::Render();
    WhereAmI::Render();
}

void RenderMenuMain() {
    MenuInfo::Render();
}