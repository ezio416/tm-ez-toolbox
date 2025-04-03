// c 2025-03-29
// m 2025-04-03

const string   pluginColor   = "\\$FFF";
const string   pluginIcon    = Icons::Arrows;
Meta::Plugin@  pluginMeta    = Meta::ExecutingPlugin();
const string   pluginTitle   = pluginColor + pluginIcon + "\\$G " + pluginMeta.Name;
InternalState@ _state;

/*
when plugin is unloaded
stops coroutines and garbage collects everything
not yieldable
*/
void OnDestroyed() {
    CleanUp("destroyed");
}

/*
when plugin is disabled
pauses coroutines
not yieldable
*/
void OnDisabled() {
    CleanUp("disabled");
}

/*
when plugin is enabled, except if it was reloaded while it was disabled
resumes coroutines
not yieldable
*/
// void OnEnabled() {
//     print("welcome back!");
//     // stop = false;
//     startnew(Main);
// }

UI::InputBlocking OnKeyPress(bool down, VirtualKey key) {
    if (!down || (key != VirtualKey::LButton && key != VirtualKey::Return))
        return UI::InputBlocking::DoNothing;

    if (!Ez2::state.playingMap)
        return UI::InputBlocking::DoNothing;

    print("key pressed: " + tostring(key));
        return UI::InputBlocking::DoNothing;
}

/*
when plugin is loaded
could also be thought of as OnCreated to oppose OnDestroyed
yieldable (is ran as a coroutine by the engine)
*/
void Main() {
    trace("new loop");

    auto App = cast<CTrackMania@>(GetApp());
    auto Network = cast<CTrackManiaNetwork@>(App.Network);
    auto ServerInfo = cast<CTrackManiaNetworkServerInfo@>(Network.ServerInfo);

    Ez2::state;

    while (true) {
        _state.gameMode = string(ServerInfo.CurGameModeStr);

        _state.inEditor = App.Editor !is null;
        _state.inMap = App.RootMap !is null;
        _state.inMenu = App.ActiveMenus.Length > 0;
        _state.inPlayground = App.CurrentPlayground !is null;

        _state.loading = true
            && App.LoadProgress !is null
            && App.LoadProgress.State != NGameLoadProgress::EState::Disabled
        ;

        if (_state.inMap) {
            _state.mapType    = App.RootMap.MapType;
            _state.mapUid     = App.RootMap.EdChallengeId;
            _state.authorTime = App.RootMap.TMObjective_AuthorTime;
            _state.bronzeTime = App.RootMap.TMObjective_BronzeTime;
            _state.goldTime   = App.RootMap.TMObjective_GoldTime;
            _state.silverTime = App.RootMap.TMObjective_SilverTime;

#if DEPENDENCY_CHAMPIONMEDALS
            _state.championTime = ChampionMedals::GetCMTime();
#endif
#if DEPENDENCY_WARRIORMEDALS
            _state.warriorTime = WarriorMedals::GetWMTime();
#endif

        } else {
            _state.mapType    = "";
            _state.mapUid     = "";
            _state.authorTime = 0;
            _state.bronzeTime = 0;
            _state.goldTime   = 0;
            _state.silverTime = 0;
        }

        _state.guiPlayer = true
            && _state.inPlayground
            && App.CurrentPlayground.GameTerminals.Length > 0
            && App.CurrentPlayground.GameTerminals[0] !is null
            && cast<CSmPlayer@>(App.CurrentPlayground.GameTerminals[0].GUIPlayer) !is null
        ;

        _state.paused = true
            && App.Network.PlaygroundClientScriptAPI !is null
            && App.Network.PlaygroundClientScriptAPI.IsInGameMenuDisplayed
        ;

        _state.playgroundScript = App.PlaygroundScript !is null;

        _state.sequence = (true
            && _state.inPlayground
            && App.CurrentPlayground.UIConfigs.Length > 0
            && App.CurrentPlayground.UIConfigs[0] !is null
        )
            ? App.CurrentPlayground.UIConfigs[0].UISequence
            : CGamePlaygroundUIConfig::EUISequence::None
        ;

        CSmPlayer@ ViewingPlayer;
        if (_state.inPlayground)
            @ViewingPlayer = VehicleState::GetViewingPlayer();

        _state.viewingLogin = (true
            && ViewingPlayer !is null
            && ViewingPlayer.ScriptAPI !is null
        )
            ? ViewingPlayer.ScriptAPI.Login
            : ""
        ;

        yield();
    }

    warn("loop broke!");
    CleanUp();
    startnew(Main);
}

void Render() {
    if (false
        || !S_Enabled
        || (S_HideWithGame && !UI::IsGameUIVisible())
        || (S_HideWithOP && !UI::IsOverlayShown())
    )
        return;

    if (UI::Begin(pluginTitle, S_Enabled, UI::WindowFlags::None))
        RenderWindow();
    UI::End();
}

void RenderMenu() {
    if (UI::MenuItem(pluginTitle, "", S_Enabled))
        S_Enabled = !S_Enabled;
}

void CleanUp(const string &in type = "") {
    if (type.Length > 0)
        warn(type + ", cleaning up...");

    @_state = null;
}

void RenderWindow() {
    UI::Text("frames: " + Ez2::state.frameCount);

    UI::Separator();

    if (UI::BeginTable("##table-debug", 2, UI::TableFlags::RowBg | UI::TableFlags::ScrollY)) {
        UI::PushStyleColor(UI::Col::TableRowBgAlt, vec4(vec3(), 0.5f));

        // UI::TableSetupScrollFreeze(0, 1);
        UI::TableSetupColumn("name", UI::TableColumnFlags::WidthFixed);
        UI::TableSetupColumn("value", UI::TableColumnFlags::WidthFixed);
        // UI::TableHeadersRow();

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("\\$0FFbase");
        UI::TableNextColumn();
        UI::Text("\\$0FF==================================================");

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("game mode");
        UI::TableNextColumn();
        UI::Text(Ez2::state.gameMode);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("gui player");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.guiPlayer));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in editor");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inEditor));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inMap));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in menu");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inMenu));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in playground");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inPlayground));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("loading");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.loading));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("map type");
        UI::TableNextColumn();
        UI::Text(Ez2::state.mapType);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("map uid");
        UI::TableNextColumn();
        UI::Text(Ez2::state.mapUid);

#if DEPENDENCY_CHAMPIONMEDALS
        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("champion time");
        UI::TableNextColumn();
        UI::Text(Time::Format(Ez2::state.championTime));
#endif

#if DEPENDENCY_WARRIORMEDALS
        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("warrior time");
        UI::TableNextColumn();
        UI::Text(Time::Format(Ez2::state.warriorTime));
#endif

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("author time");
        UI::TableNextColumn();
        UI::Text(Time::Format(Ez2::state.authorTime));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("gold time");
        UI::TableNextColumn();
        UI::Text(Time::Format(Ez2::state.goldTime));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("silver time");
        UI::TableNextColumn();
        UI::Text(Time::Format(Ez2::state.silverTime));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("bronze time");
        UI::TableNextColumn();
        UI::Text(Time::Format(Ez2::state.bronzeTime));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("paused");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.paused));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("playground script");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.playgroundScript));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("sequence");
        UI::TableNextColumn();
        UI::Text(tostring(Ez2::state.sequence));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("viewing login");
        UI::TableNextColumn();
        UI::Text(Ez2::state.viewingLogin);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("\\$0FFlogic");
        UI::TableNextColumn();
        UI::Text("\\$0FF==================================================");

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("driving");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.driving));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("in main menu");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inMainMenu));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("editing map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inMapEditor));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("testing map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inMapEditorTesting));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("editing local replay");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inReplayEditorEditing));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("viewing local replay");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inReplayEditorViewing));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("editing skin");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.inSkinEditor));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("playing local map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.playingLocalMap));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("playing map");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.playingMap));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("spectating");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.spectating));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("viewing replay");
        UI::TableNextColumn();
        UI::Text(ColoredBool(Ez2::state.viewingReplay));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("\\$0FFcached");
        UI::TableNextColumn();
        UI::Text("\\$0FF==================================================");

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("bits");
        UI::TableNextColumn();
        UI::Text(tostring(Ez2::state.bits));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("game");
        UI::TableNextColumn();
        UI::Text(tostring(Ez2::state.game));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local access level");
        UI::TableNextColumn();
        UI::Text(tostring(Ez2::state.localAccessLevel));

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local id");
        UI::TableNextColumn();
        UI::Text(tostring(Ez2::state.localId.Value) + " (" + Ez2::state.localId.GetName() + ")");

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local login");
        UI::TableNextColumn();
        UI::Text(Ez2::state.localLogin);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local username");
        UI::TableNextColumn();
        UI::Text(Ez2::state.localUsername);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("local wsid");
        UI::TableNextColumn();
        UI::Text(Ez2::state.localWsid);

        UI::TableNextRow();
        UI::TableNextColumn();
        UI::Text("operating system");
        UI::TableNextColumn();
        UI::Text(tostring(Ez2::state.os));

        UI::PopStyleColor();
        UI::EndTable();
    }
}

class InternalState : Ez2::State {
    InternalState() {
        if (_state !is null)
            throw("state should be a singleton!");

        startnew(CoroutineFunc(CountAsync));
        startnew(CoroutineFunc(GetLocalPlayerInfoAsync));
    }

#if DEPENDENCY_CHAMPIONMEDALS
    void set_championTime    (uint c)                                 { _championTime = c;     }
#endif
#if DEPENDENCY_WARRIORMEDALS
    void set_warriorTime     (uint w)                                 { _warriorTime = w;      }
#endif
    void set_authorTime      (uint a)                                 { _authorTime = a;       }
    void set_bronzeTime      (uint b)                                 { _bronzeTime = b;       }
    void set_gameMode        (const string &in g)                     { _gameMode = g;         }
    void set_goldTime        (uint g)                                 { _goldTime = g;         }
    void set_guiPlayer       (bool g)                                 { _guiPlayer = g;        }
    void set_inEditor        (bool i)                                 { _inEditor = i;         }
    void set_inMap           (bool i)                                 { _inMap = i;            }
    void set_inMenu          (bool i)                                 { _inMenu = i;           }
    void set_inPlayground    (bool i)                                 { _inPlayground = i;     }
    void set_loading         (bool l)                                 { _loading = l;          }
    void set_mapType         (const string &in m)                     { _mapType = m;          }
    void set_mapUid          (const string &in m)                     { _mapUid = m;           }
    void set_paused          (bool p)                                 { _paused = p;           }
    void set_playgroundScript(bool p)                                 { _playgroundScript = p; }
    void set_sequence        (CGamePlaygroundUIConfig::EUISequence s) { _sequence = s;         }
    void set_silverTime      (uint s)                                 { _silverTime = s;       }
    void set_viewingLogin    (const string &in v)                     { _viewingLogin = v;     }
}

namespace Ez2 {
    State@ get_state() {
        return _state !is null ? _state : (@_state = InternalState());
    }
}

string ColoredBool(bool b) {
    return (b ? "\\$0F0" : "\\$F00") + b;
}
