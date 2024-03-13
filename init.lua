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

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      {'nvim-lua/plenary.nvim'},
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
	}

	-- fzf
	-- use { 'junegunn/fzf', run = ":call fzf#install()" }
	-- use { 'junegunn/fzf.vim' }

	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }


end)
require("mason").setup()
-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
--   snippet = {
--     -- REQUIRED - you must specify a snippet engine
--     expand = function(args)
--       vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--       -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--       -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--       -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--     end,
--   },
--   window = {
--     -- completion = cmp.config.window.bordered(),
--     -- documentation = cmp.config.window.bordered(),
--   },
--   mapping = cmp.mapping.preset.insert({
--     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.abort(),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--   }),
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' }, -- For vsnip users.
--     -- { name = 'luasnip' }, -- For luasnip users.
--     -- { name = 'ultisnips' }, -- For ultisnips users.
--     -- { name = 'snippy' }, -- For snippy users.
--   }, {
--     { name = 'buffer' },
--   })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
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

local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")

require('telescope').setup{
	extentions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		live_grep_args = {
			auto_quoting = true, -- enable/disable auto-quoting
			-- define mappings, e.g.
			mappings = { -- extend mappings
			i = {
				["<C-k>"] = lga_actions.quote_prompt(),
				["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
			},
		},
		-- ... also accepts theme settings, for example:
		-- theme = "dropdown", -- use dropdown theme
		-- theme = { }, -- use own theme spec
		-- layout_config = { mirror=true }, -- mirror preview pane
	}
}
}
require('telescope').load_extension('fzf')


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

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.git_files, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
-- vim.keymap.set('n', '<leader>l', builtin.live_grep, {})
vim.keymap.set("n", "<leader>l", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

vim.api.nvim_set_keymap('n', '<F3>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- function _G.fzf_files()
--   vim.fn['fzf#run']({
--     source = 'rg --files',
--     sink = 'e',
--     options = '--height 30% --prompt "Files> " --multi --preview "bat --color=always {}"'
--   })
-- end

-- <leader>f にキーバインドを設定
-- vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua fzf_files()<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>f', ':lua fzf_files()<CR>', {noremap = true, silent = true})
