-- local util = require("util")
local util = dofile("/home/wlvs/.config/nixos/modules/home/neovim/nvim/lua/util/init.lua")

local M = {}

M.autoformat = true

function M.toggle()
  M.autoformat = not M.autoformat
  if M.autoformat then
    util.info("enabled format on save", "Formatting")
  else
    util.warn("disabled format on save", "Formatting")
  end
end

function M.format()
  if M.autoformat then
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    else
      vim.lsp.buf.formatting_sync()
    end
  end
end

function M.setup(client, buf)
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")
  -- local nls = require("plugins.null-ls")
  local nls = dofile("/home/wlvs/.config/nixos/modules/home/neovim/nvim/lua/plugins/null-ls.lua")

  local enable = false
  if nls.has_formatter(ft) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  -- if client.name == "tsserver" then
  --   enable = false
  -- end

  -- util.info(client.name .. " " .. (enable and "yes" or "no"), "format")

  client.server_capabilities.documentFormattingProvider = enable
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.cmd([[
      augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua dofile('/home/wlvs/.config/nixos/modules/home/neovim/nvim/lua/plugins/lsp/formatting.lua').format()
      augroup END
    ]])
  end
end

return M
