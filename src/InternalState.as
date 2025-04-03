// c 2025-04-03
// m 2025-04-03

class InternalState : Ez2::State {
    InternalState() {
        if (_state !is null)
            throw("state should be a singleton!");

        startnew(CoroutineFunc(CountAsync));
        startnew(CoroutineFunc(GetLocalPlayerInfoAsync));
    }

    void set_authorTime      (uint a)                                 { _authorTime = a;       }
    void set_bronzeTime      (uint b)                                 { _bronzeTime = b;       }
    void set_championTime    (uint c)                                 { _championTime = c;     }
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
    void set_warriorTime     (uint w)                                 { _warriorTime = w;      }
}
