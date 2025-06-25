// c 2025-03-27
// m 2025-06-24

[Setting category="General" name="Enabled"]
bool S_Enabled = true;

[Setting category="Debug" name="Enabled"]
bool S_Debug = true;

[Setting category="Debug" name="Show/hide with game UI" if="S_Debug"]
bool S_Debug_HideWithGame = true;

[Setting category="Debug" name="Show/hide with Openplanet UI" if="S_Debug"]
bool S_Debug_HideWithOP = false;
