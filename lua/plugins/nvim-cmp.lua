return {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
                -- Snippet Engine & its associated nvim-cmp source
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',

                -- Adds LSP completion capabilities
                'hrsh7th/cmp-nvim-lsp',

                -- Adds a number of user-friendly snippets
                'rafamadriz/friendly-snippets',
        },
        opts = function()
                vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
                local cmp = require("cmp")
                local defaults = require("cmp.config.default")()
                local luasnip = require 'luasnip'
                require('luasnip.loaders.from_vscode').lazy_load()
                luasnip.config.setup {}

                return {
                        completion = {
                                completeopt = "menu,menuone,noinsert",
                        },
                        snippet = {
                                expand = function(args)
                                        require("luasnip").lsp_expand(args.body)
                                end,
                        },
                        mapping = cmp.mapping.preset.insert({
                                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                                ["<C-Space>"] = cmp.mapping.complete(),
                                ["<C-e>"] = cmp.mapping.abort(),
                                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                                ["<S-CR>"] = cmp.mapping.confirm({
                                        behavior = cmp.ConfirmBehavior.Replace,
                                        select = true,
                                }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                        }),
                        sources = cmp.config.sources({
                                { name = "nvim_lsp" },
                                { name = "luasnip" },
                                { name = "buffer" },
                                { name = "path" },
                        }),
                        experimental = {
                                ghost_text = {
                                        hl_group = "CmpGhostText",
                                },
                        },
                        sorting = defaults.sorting,
                }
        end,
}
