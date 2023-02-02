# lazy_nvim_config

Implementing github.com/folke/lazy.nvim I'm bringing a neovim rice-a-like configuration to you with a more robust UI, trying to get a usual IDE experience with all neovim's power included.

Requirements:
- ripgrep (for fuzzy finding)
- lazygit (TUI git integration)
- lazydocker (TUI docker integration)

Installation steps:
1. Having neovim downloaded.
2. At your $HOME, create .config/nvim directory.
3. git clone https://github.com/NachoNievaG/lazy_nvim_config ~/.config/nvim
4. Launch nvim and expect the plugin installation process to finish in a couple of minutes.
5. Enjoy!

Keymaps can be found at /lua/keymaps.lua
which-key guidelines can be found at /lua/plugins/which-key.lua
