In this repository you will find:

- random, possibly reusable scripts;
- possibly reusable configs;
- go code, if distributing such code in go-open or go-free doesn't
  make sense;
- all code written in other languages.

Each top level folder is developed independently from the others (except for
cases where it makes sense to create a dependency link) and as a result may be
licensed under different terms from the other code/configs in the repo.

Index of contents:

- **\_archives**: Unfinished projects, experiments, old unmaintained stuff of
  varying quality, for reference only. Use not recommended.
  - go-prototype-dashboard: the precursor to knobs, in Go+GTK3; use knobs
    instead `AGPL-3.0`
  - make-picolin: minimal busybox+linux initramfs. `MIT`
  - nodejs-dire: requires a directory of other node modules. `MIT`
  - sh-sitify: shell based site/directory processor. `MIT`
  - vim-legacy-config: scaffolding/remnants of old (neo)vim configs, built
    around vim-plug and focusing on portability across vim/Linux distributions;
    see current neovim-only configs under _dotfiles/.config/nvim `MIT`
  - vim-tutorial: tutorial made for NEECT's GeekTalk of Nov 19, 2012. `MIT`
- **\_dotfiles**: Linux configs for common programs/applications. `MIT`
- **cpp-knobs**: a C++/gtkmm framework for writing custom dashboards/launchers
  for Linux. `AGPL-3.0`
