// c 2025-04-03
// m 2025-04-03

namespace Ez2 {
    void EditMap(const string &in url) {
        startnew(EditMapAsync, url);
    }

    void EditMapAsync(const string &in url) {
        if (!Permissions::OpenAdvancedMapEditor()) {
            warn("can't edit map: player doesn't have permission");
            return;
        }

        if (url.Length == 0) {
            warn("can't edit map: url is blank");
            return;
        }

        trace("editing map from url: " + url);

        ;
    }

    void PlayMap(const string &in url) {
        startnew(PlayMapAsync, url);
    }

    void PlayMapAsync(const string &in url) {
        if (!Permissions::PlayLocalMap()) {
            warn("can't play map: player doesn't have permission");
            return;
        }

        if (url.Length == 0) {
            warn("can't play map: url is blank");
            return;
        }

        trace("playing map from url: " + url);

        ;
    }
}
