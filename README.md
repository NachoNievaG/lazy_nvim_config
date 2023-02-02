# lazy_nvim_config

Implementing [folke/lazy.nvim](https://github.com/folke/lazy.nvim) I'm bringing a neovim rice-a-like configuration to you with a more robust UI, trying to get a usual IDE experience with all neovim's power included.

Requirements:
- ripgrep (for fuzzy finding)
- lazygit (TUI git integration)
- lazydocker (TUI docker integration)

Installation steps:
1. Having [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) downloaded.
2. At your $HOME, create .config/nvim directory.
3. `git clone https://github.com/NachoNievaG/lazy_nvim_config ~/.config/nvim`
4. `brew install ripgrep lazygit lazydocker`
5. Launch nvim and expect the plugin installation process to finish in a couple of minutes.
6. Enjoy!

Keymaps can be found at /lua/keymaps.lua
which-key guidelines can be found at /lua/plugins/which-key.lua
