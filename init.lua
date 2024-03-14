-- Default VIM

-- Packer  plugin manager config stuff
require('packer').startup(function(use)
-- Packer can manage itself
	use "wbthomason/packer.nvim"

	use {
		"williamboman/mason.nvim",
		run = ":MasonUpdate" -- :MasonUpdate updattes registry contents
	}
 
	use {
		'goolord/alpha-nvim',
		requires = { 'nvim-tree/nvim-web-devicons' },
		config = function ()
			require'alpha'.setup(require'alpha.themes.startify'.config)
		end
	}

	use 'neovim/nvim-lspconfig'
 	use 'hrsh7th/cmp-nvim-lsp'
 	use 'hrsh7th/cmp-buffer'
 	use 'hrsh7th/cmp-path'
 	use 'hrsh7th/cmp-cmdline'
 	use 'hrsh7th/nvim-cmp'

	use 'airblade/vim-gitgutter'

	use 'nvim-tree/nvim-tree.lua'

	-- multi comment
	use 'tpope/vim-commentary'

-- fzf
	use { 'junegunn/fzf', run = ":call fzf#install()" }
	use { 'junegunn/fzf.vim' }

end)

require("mason").setup()

-- Set up nvim-cmp.
local cmp = require'cmp'
cmp.setup({ })

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--   capabilities = capabilities
-- }
--
-- TODO
--
--

require("nvim-tree").setup()

-- fzf settings
vim.env.FZF_DEFAULT_OPTS = "--layout=reverse"
vim.env.FZF_jEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**'"
vim.g.fzf_layout = { window = { width = 1, height = 0.5, yoffset = 1, xoffset = 0.5, border = 'sharp' } }

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--                                 keymap
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.opt.number = true
vim.opt.ignorecase = true
vim.o.clipboard = "unnamedplus"

-- スペースキーを <leader> に設定する
vim.api.nvim_set_keymap('n', '<Space>', '<Nop>', {noremap = true, silent = true})
vim.g.mapleader = ' '

-- スペースキーが押されたときに <leader> を実行する
vim.api.nvim_set_keymap('n', '<Leader>', '<Space>', {noremap = true, silent = true})

-- nvim-tree setting
vim.keymap.set('n', '<leader>l', ':NvimTreeToggle<CR>', {})

-- fzf setting
vim.keymap.set('n', '<leader>f', ':Files<CR>', {})
vim.keymap.set('n', '<leader>g', ':GFiles?<CR>', {})
vim.keymap.set('n', '<leader>G', ':GFiles<CR>', {})
vim.keymap.set('n', '<leader>b', ':Buffers<CR>', {})
vim.keymap.set('n', '<leader>h', ':History<CR>', {})
vim.keymap.set('n', '<leader>r', ':Rg<CR>', {})
