`Ez::State` uses a specific method to increase performance: functions return variables that are only updated once per frame, regardless of how many times they're called between different plugins. This has required a bit of ingenuity to get right. I tried using a variable that keeps track of how many frames the game has rendered, but no matter what I did with incrementing the value myself within the plugin, there were discrepancies against calculating new values for each call (i.e. whether we're in a map). I asked Miss to add an exposed frame counter in Openplanet, but this still did not solve the issue. The only reliable way I found was to use a counter managed by the game in `App.Viewport`. Unfortunately, this value is not exposed, so it requires a `Dev::` call to grab it via an offset which is known to be vulnerable to breaking upon a game update. I've somewhat mitigated this risk by including a way to update the offset via Openplanet's config hosting so I don't have to update the plugin, but I would much rather have a method which never requires my intervention.

- Frame counter is at:
    - Tm2020
        - `App.Viewport.(SystemWindow +0x14)` (`+0x5b4`)
        - another one `+0x4` (`+0x5b8`) from offset above for some reason
        - valid for `2024-12-12_15_15`
    - TmTurbo
        - unknown
    - Tm2
        - unknown
    - TmForever
        - unknown
