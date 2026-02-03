-- jsonls schema catalog
local catalog_data = require("data.schema-catalog")
local schemas = catalog_data.schemas

return {
	-- add pyright to lspconfig
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				-- pyright will be automatically installed with mason and loaded with lspconfig
				pyright = {},
				nixd = {},
			},
		},
	},

	-- add tsserver and setup with typescript.nvim instead of lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/typescript.nvim",
			init = function()
				local group = vim.api.nvim_create_augroup("kurumi_typescript_mappings", { clear = true })
				vim.api.nvim_create_autocmd("LspAttach", {
					group = group,
					callback = function(event)
						local client = vim.lsp.get_client_by_id(event.data.client_id)
						if not client or (client.name ~= "tsserver" and client.name ~= "ts_ls") then
							return
						end
						local function run_first_available(cmds)
							for _, cmd in ipairs(cmds) do
								if vim.fn.exists(":" .. cmd) == 2 then
									vim.cmd(cmd)
									return
								end
							end
							vim.notify("TypeScript helper command is not available", vim.log.levels.WARN)
						end
						vim.keymap.set("n", "<leader>co", function()
							run_first_available({ "TypescriptOrganizeImports", "TSToolsOrganizeImports" })
						end, { buffer = event.buf, desc = "Organize Imports" })
						vim.keymap.set("n", "<leader>cR", function()
							run_first_available({ "TypescriptRenameFile", "TSToolsRenameFile" })
						end, { buffer = event.buf, desc = "Rename File" })
					end,
				})
			end,
		},
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				-- tsserver will be automatically installed with mason and loaded with lspconfig
				tsserver = {},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				tsserver = function(_, opts)
					require("typescript").setup({ server = opts })
					return true
				end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
	},
	-- jsonls with schema catalog
	-- https://zenn.dev/nazo6/articles/989d44e16b1abb
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				jsonls = {},
			},
			setup = {
				jsonls = function(_, opts)
					opts.settings = {
						json = {
							schemas = schemas,
						},
					}
				end,
			},
		},
	},

	-- php intelephense
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				intelephense = {},
			},
			setup = {
				intelephense = function(_, opts)
					opts.settings = {
						intelephense = {
							files = {
								exclude = {
									"**/worktrees/**",
								},
							},
							stubs = {
								"apache",
								"bcmath",
								"bz2",
								"calendar",
								"com_dotnet",
								"Core",
								"ctype",
								"curl",
								"date",
								"dom",
								"fileinfo",
								"filter",
								"ftp",
								"gd",
								"gettext",
								"hash",
								"iconv",
								"imap",
								"intl",
								"json",
								"libxml",
								"mbstring",
								"mysqli",
								"mysqlnd",
								"oci8",
								"openssl",
								"pcntl",
								"pcre",
								"PDO",
								"pdo_mysql",
								"Phar",
								"posix",
								"readline",
								"Reflection",
								"session",
								"shmop",
								"SimpleXML",
								"snmp",
								"soap",
								"sockets",
								"SPL",
								"standard",
								"sysvmsg",
								"sysvsem",
								"sysvshm",
								"tidy",
								"tokenizer",
								"xml",
								"xmlreader",
								"xmlwriter",
								"xsl",
								"zip",
								"zlib",
								"ssh2",
							},
						},
					}
				end,
			},
		},
	},
}
