vim.o.completeopt = "menuone,noselect"

-- Setup nvim-cmp.
local cmp = require("cmp")
local kind = dofile("/home/wlvs/.config/nixos/modules/home/neovim/nvim/lua/plugins/lsp/kind.lua")

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    -- { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "emoji" },
    -- { name = "neorg" },
    { name = "nvim_lsp_signature_help" },
  }),
  formatting = {
    format = kind.cmp_format(),
  },
  -- documentation = {
  --   border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  --   winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
  -- },
  experimental = {
    ghost_text = {
      hl_group = "LspCodeLens",
    },
  },
  -- sorting = {
  --   comparators = {
  --     cmp.config.compare.sort_text,
  --     cmp.config.compare.offset,
  --     -- cmp.config.compare.exact,
  --     cmp.config.compare.score,
  --     -- cmp.config.compare.kind,
  --     -- cmp.config.compare.length,
  --     cmp.config.compare.order,
  --   },
  -- },
})

-- cmp.setup.cmdline(":", {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     -- { name = "noice_popupmenu" },
--     { name = "path" },
--     { name = "cmdline" },
--     -- { name = "cmdline_history" },
--   }),
-- })

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
