# neovim-action

This repository provides reusable GitHub Actions related to Neovim. They can be used freely.

The principles I used to build them:

- Simple, composable actions
- Prioritize correctness and speed
- Inputs should be pinned and exact
- When paired with a dependency updater such as [Renovate](https://docs.renovatebot.com/), the action can be updated
  automatically, and the builds become reproducible.
  - I use this extensively in my own projects - see
    [mikavilpas/mika-renovate](https://github.com/mikavilpas/mika-renovate) for my custom managers (also free to use).

## CI Runner Architecture support

Supported operating systems and architectures for all actions:

- [`ubuntu-24.04`](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Readme.md) (x86_64)
- [`ubuntu-24.04-arm`](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Arm64-Readme.md)
  (arm64)

Everything is tested on both architectures to maintain compatibility.

## [build-nightly](build-nightly/action.yml) and [restore-nightly](restore-nightly/action.yml) Neovim versions

[build-nightly](build-nightly/action.yml) compiles and caches a Neovim nightly based on its git commit.
[restore-nightly](restore-nightly/action.yml) restores the built Neovim nightly from cache in a later job.

Example from
[mikavilpas/yazi.nvim](https://github.com/mikavilpas/yazi.nvim/blob/23c6c3061ebae0964b1ef904390c6442c474882f/.github/workflows/test.yml#L12-L24)

```yaml
env:
  # renovate: datasource=git-refs-master packageName=https://github.com/neovim/neovim
  NEOVIM_NIGHTLY_COMMIT: 7945732ed7bb211f91112292a13b51fc3182599b

jobs:
  build-neovim-nightly:
    name: Build pinned Neovim nightly
    runs-on: ubuntu-24.04
    steps:
      - name: Build pinned Neovim nightly
        uses: mikavilpas/neovim-action/build-nightly@ef04210e60a28317d442169fbccdaa010cf90b88 # v3.2.2
        with:
          commit: ${{ env.NEOVIM_NIGHTLY_COMMIT }}

  build:
    - name: Download pinned Neovim nightly
      if: matrix.neovim.name == 'nightly'
      uses: mikavilpas/neovim-action/restore-nightly@ef04210e60a28317d442169fbccdaa010cf90b88 # v3.2.2
      with:
        commit: ${{ env.NEOVIM_NIGHTLY_COMMIT }}
```

## [busted action](busted/action.yml) - run busted tests with Neovim

[the busted action](busted/action.yml) installs lua 5.1 and luarocks, and then runs
[busted](https://lunarmodules.github.io/busted/) tests with Neovim. It can be used to run tests for Neovim plugins.

Requires a Neovim to be installed. I recommend either
[the nightly building actions](#build-nightly-and-restore-nightly-neovim-versions) or
[rhysd/action-setup-vim/](https://github.com/rhysd/action-setup-vim/).
