// c 2025-03-27
// m 2025-06-24

[Setting category="Menu Info" name="Enabled"]
bool S_MenuInfo = false;

[Setting category="Menu Info" name="Padding between elements" min=1 max=100 if="S_MenuInfo"]
uint S_MenuInfo_Padding = 5;

[Setting category="Menu Info" name="Show icons" if="S_MenuInfo"]
bool S_MenuInfo_Icons = true;

[Setting category="Menu Info" name="FPS" if="S_MenuInfo"]
bool S_MenuInfo_FPS = true;

[Setting category="Menu Info" name="Clock" if="S_MenuInfo"]
bool S_MenuInfo_Clock = true;


[Setting category="Debug" name="Enabled"]
bool S_Debug = true;

[Setting category="Debug" name="Show/hide with game UI" if="S_Debug"]
bool S_Debug_HideWithGame = true;

[Setting category="Debug" name="Show/hide with Openplanet UI" if="S_Debug"]
bool S_Debug_HideWithOP = false;
