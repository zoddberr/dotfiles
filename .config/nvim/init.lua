-- BASICS
vim.o.clipboard = 'unnamedplus'
vim.o.termguicolors = true

vim.o.number = true

vim.g.mapleader = " "

vim.o.splitbelow = true
vim.o.splitright = true

-- disable auto comment on new line
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

-- LSP
vim.lsp.config['clangd'] = {
	cmd = { 'clangd', '--background-index', '--clang-tidy', '--header-insertion=never' },
	filetypes = { 'c' },
}

vim.lsp.enable('clangd')

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		local opts = { buffer = ev.buf }

		-- General bindings when any LSP attaches
		vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K',  vim.lsp.buf.hover, opts)

		-- lua being lua... (new goto_next())
		vim.keymap.set('n', '<leader>n', function()
			vim.diagnostic.jump({ count = 1, on_jump = function() vim.diagnostic.open_float() end }) end)

		if client:supports_method('textDocument/implementation') then
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		end

		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
		end
	end
})

vim.diagnostic.config({
	underline = false,

	virtual_text = {
		spacing = 8,
		prefix = '<',
		severity = {min = vim.diagnostic.severity.WARN }
	},

	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '*',
			[vim.diagnostic.severity.WARN] = '*',
			[vim.diagnostic.severity.HINT] = '>',
			[vim.diagnostic.severity.INFO] = '>'
		}
	}
})

vim.opt.completeopt = {'menuone', 'menu', 'popup', 'noselect'}

-- PLUGINS
vim.pack.add({
	{ src = 'https://github.com/nvim-mini/mini.pairs', version = 'stable' },
	{ src = 'https://github.com/nvim-mini/mini.trailspace', version = 'stable' },
	{ src = 'https://github.com/ibhagwan/fzf-lua' },

	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/ej-shafran/compile-mode.nvim' },

	{ src = 'https://github.com/ellisonleao/gruvbox.nvim' }
})

require('mini.pairs').setup()
require('mini.trailspace').setup()

require('fzf-lua').setup()
vim.keymap.set('n', '<leader>f', '<cmd>FzfLua files<cr>')
vim.keymap.set('n', '<leader>b', '<cmd>FzfLua buffers<cr>')
vim.keymap.set('n', '<leader>p', '<cmd>FzfLua live_grep<cr>')

vim.g.compile_mode = {
	default_command = "",
	focus_compilation_buffer = true
}
vim.keymap.set('n', '<leader>C', '<cmd>Compile<cr>')
vim.keymap.set('n', '<leader>c', '<cmd>Recompile<cr>')

require('gruvbox').setup()
vim.cmd.colorscheme('gruvbox')
