-- local M = {
--   event = "BufReadPre",
-- }
--
-- function M.config()
--require("mason")
--
-- require("plugins.lsp.diagnostics").setup()
dofile("/home/wlvs/.config/nixos/modules/home/neovim/nvim/lua/plugins/lsp/diagnostics.lua").setup()
-- require("plugins.lsp.handlers").setup()
dofile("/home/wlvs/.config/nixos/modules/home/neovim/nvim/lua/plugins/lsp/handlers.lua").setup()

local function on_attach(client, bufnr)
  -- require("plugins.lsp.formatting").setup(client, bufnr)
  dofile("/home/wlvs/.config/nixos/modules/home/neovim/nvim/lua/plugins/lsp/formatting.lua").setup(client, bufnr)
  -- require("plugins.lsp.keys").setup(client, bufnr)
  dofile("/home/wlvs/.config/nixos/modules/home/neovim/nvim/lua/plugins/lsp/keys.lua").setup(client, bufnr)
end

local servers = {
  --ansiblels = {},
  bashls = {},
  --clangd = {},
  cssls = {},
  --dockerls = {},
  tsserver = {},
  -- eslint = {},
  -- gopls = {},
  html = {},
  jsonls = {
    settings = {
      json = {
        format = {
          enable = true,
        },
        -- schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  marksman = {},
  -- pyright = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = {
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
      },
    },
  },
  yamlls = {},
  sumneko_lua = {
    -- cmd = { vim.fn.stdpath("data") .. "/mason/bin/lua-language-server" },
    single_file_support = true,
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          workspaceWord = true,
        },
        misc = {
          parameters = {
            "--log-level=trace",
          },
        },
        diagnostics = {
          -- enable = false,
          -- groupFileStatus = {
          --   ["ambiguity"] = "Opened",
          --   ["await"] = "Opened",
          --   ["codestyle"] = "None",
          --   ["duplicate"] = "Opened",
          --   ["global"] = "Opened",
          --   ["luadoc"] = "Opened",
          --   ["redefined"] = "Opened",
          --   ["strict"] = "Opened",
          --   ["strong"] = "Opened",
          --   ["type-check"] = "Opened",
          --   ["unbalanced"] = "Opened",
          --   ["unused"] = "Opened",
          -- },
          unusedLocalExclude = { "_*" },
          globals = { "vim" },
        },
        format = {
          enable = false,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
            continuation_indent_size = "2",
          },
        },
      },
    },
  },
  svelte = {},
  -- teal_ls = {},
  vimls = {},
  tailwindcss = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local options = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_test_changes = 150,
  },
}

for server, opts in pairs(servers) do
  opts = vim.tbl_deep_extend("force", {}, options, opts or {})

  --if server == "tsserver" then
  --  require("typescript").setup({ server = opts })
  --else
  require("lspconfig")[server].setup(opts)
  --end
end

-- require("plugins.null-ls").setup(options)
dofile("/home/wlvs/.config/nixos/modules/home/neovim/nvim/lua/plugins/null-ls.lua").setup(options)
-- end
--
-- return M
