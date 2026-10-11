Neovim 0.12+ configuration managed with lazy.nvim.
Includes LSP, completion, snippets, Telescope, Git tools and debugging.
Supports PHP/Laravel, Blade, Vue, JavaScript/TypeScript, Go and more.

Setup
- Place this configuration in ~/.config/nvim and start Neovim.
- Git is required to bootstrap lazy.nvim.
- Plugins and configured Mason tools are installed automatically.
- Install Biome or Prettier in your project's node_modules to format web files.

Usage
- Leader key: Space.
- :Lazy manages plugins. :Mason manages development tools.
- :Format or Space + F formats the current buffer manually.
- Automatic formatting on save is disabled.
- Blade formatting uses two-space indentation.
- Completion works in insert mode and the command line.

Configuration
- plugin/: editor options and key mappings.
- lua/custom/plugins/: plugin and language server settings.
- lua/custom/autoformat.lua: manual formatter settings.
- after/ftplugin/: filetype-specific settings.
- lazy-lock.json: pinned plugin versions.
