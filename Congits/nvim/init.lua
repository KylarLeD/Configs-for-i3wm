vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Your other plugins
    {'daviii-lopes/pureblack.nvim'},

    -- Add nvim-tree plugin
    {
      'kyazdani42/nvim-tree.lua',
      config = function()
        -- nvim-tree setup
        require'nvim-tree'.setup {
          -- Configuration for nvim-tree, customize according to your needs
          auto_reload_on_write = true,
          open_on_tab = false,
          hijack_netrw = true,
          update_cwd = true,
          diagnostics = {
            enable = true,
            icons = {
              hint = "",
              info = "",
              warning = "",
              error = ""
            }
          },
        }

        -- Map keybinding to toggle nvim-tree
        vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
      end
    }
  },

  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Set the colorscheme
vim.cmd[[colorscheme pureblack]]
