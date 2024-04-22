local lsp = require("lsp-zero")
local mason = require("mason")
local masonLSP = require("mason-lspconfig")

mason.setup({})
masonLSP.setup({
	ensure_installed = {
		'tsserver',
		'eslint',
	},
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end
	}
})


lsp.preset("recommended")

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
})
local cmp_format = lsp.cmp_format({details = true})

cmp.setup({
	source = {
		{name = 'nvim_lsp'},
		{name = 'buffer'},
	},
	formatting = cmp_format,
	mapping = cmp_mappings,
})

lsp.set_preferences({
	sign_icons = {}
})


lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = fale}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()
