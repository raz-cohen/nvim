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

lsp.set_preferences({
	sign_icons = {}
})


lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()
