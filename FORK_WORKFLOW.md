# Fork workflow

Recommended branch model for this repository:

- `upstream/master`: current base from `fredlcore/BSB-LAN`
- `custom`: your maintained branch with your own changes
- `dukess/*`: reference branches for selectively importing changes

Current remotes:

- `origin`: `https://github.com/hkiam/BSB-LAN.git`
- `upstream`: `https://github.com/fredlcore/BSB-LAN.git`
- `dukess`: `https://github.com/dukess/BSB-LAN.git`

Notes about the current fork state:

- `origin/master` is 1 commit ahead of `upstream/master`
- the extra commit only updates `BSB_LAN/bsb-version.h`
- `dukess/master` is not ahead of `upstream/master`
- the only `dukess` branch with obvious additional work on top of a shared history is `dukess/BLE-sensors`

Recommended regular update cycle:

```sh
scripts/update-custom.sh
git cherry-pick <wanted-dukess-commit>
git push origin custom
```

Useful inspection commands:

```sh
git log --oneline custom..dukess/BLE-sensors
git diff --stat upstream/master...dukess/BLE-sensors
git log --oneline origin/master..upstream/master
```

Do not maintain a long-lived patch file. Keep your own changes and imported `dukess` changes as normal commits on `custom`.
