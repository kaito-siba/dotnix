local M = {}

local TIMEOUT_MS = 3000
local ACTION_KINDS = {
	"source.fixAll",
	"source.organizeImports",
}

---@param bufnr integer
---@return lsp.Range
local function full_buffer_range(bufnr)
	local line_count = vim.api.nvim_buf_line_count(bufnr)
	local end_line = math.max(line_count - 1, 0)
	local last_line = vim.api.nvim_buf_get_lines(bufnr, end_line, end_line + 1, false)[1] or ""
	return {
		start = { line = 0, character = 0 },
		["end"] = { line = end_line, character = #last_line },
	}
end

---@param client vim.lsp.Client
---@param bufnr integer
---@return table[]
local function client_diagnostics(client, bufnr)
	local diagnostics = {}
	local get_namespace = vim.lsp.diagnostic and vim.lsp.diagnostic.get_namespace
	if type(get_namespace) ~= "function" then
		return diagnostics
	end

	local ns_push = get_namespace(client.id, false)
	local ns_pull = get_namespace(client.id, true)
	if ns_push then
		vim.list_extend(diagnostics, vim.diagnostic.get(bufnr, { namespace = ns_push }))
	end
	if ns_pull then
		vim.list_extend(diagnostics, vim.diagnostic.get(bufnr, { namespace = ns_pull }))
	end

	return vim.tbl_map(function(d)
		return d.user_data and d.user_data.lsp or nil
	end, diagnostics)
end

---@param client vim.lsp.Client
---@param bufnr integer
---@param action table
local function apply_action(client, bufnr, action)
	if action.edit then
		vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding or "utf-16")
	end

	local command
	if type(action.command) == "table" and type(action.command.command) == "string" then
		command = {
			command = action.command.command,
			arguments = action.command.arguments,
		}
	elseif type(action.command) == "string" then
		command = {
			command = action.command,
			arguments = action.arguments,
		}
	end

	if command and client:supports_method("workspace/executeCommand") then
		client:request_sync("workspace/executeCommand", command, TIMEOUT_MS, bufnr)
	end
end

---@param client vim.lsp.Client
---@param bufnr integer
---@param action table
---@return table
local function resolve_action(client, bufnr, action)
	if (action.edit or action.command) or not client:supports_method("codeAction/resolve") then
		return action
	end

	local resolved = client:request_sync("codeAction/resolve", action, TIMEOUT_MS, bufnr)
	if resolved and resolved.result then
		return resolved.result
	end
	return action
end

---@param client vim.lsp.Client
---@param bufnr integer
---@param kind string
local function apply_kind(client, bufnr, kind)
	if not client:supports_method("textDocument/codeAction") then
		return
	end

	local diagnostics = vim.tbl_filter(function(d)
		return d ~= nil
	end, client_diagnostics(client, bufnr))

	local response = client:request_sync("textDocument/codeAction", {
		textDocument = vim.lsp.util.make_text_document_params(bufnr),
		range = full_buffer_range(bufnr),
		context = {
			only = { kind },
			diagnostics = diagnostics,
			triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
		},
	}, TIMEOUT_MS, bufnr)

	if not response or response.err or type(response.result) ~= "table" then
		return
	end

	for _, action in ipairs(response.result) do
		if not action.disabled then
			apply_action(client, bufnr, resolve_action(client, bufnr, action))
		end
	end
end

---@param bufnr integer
function M.apply_on_save(bufnr)
	local clients = vim.lsp.get_clients({
		bufnr = bufnr,
		name = "biome",
	})
	if #clients == 0 then
		return
	end

	for _, client in ipairs(clients) do
		for _, kind in ipairs(ACTION_KINDS) do
			apply_kind(client, bufnr, kind)
		end
	end
end

return M
