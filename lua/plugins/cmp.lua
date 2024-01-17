return {
  {
    'zbirenbaum/copilot-cmp',
    dependencies = {'zbirenbaum/copilot.lua'},
    enabled=false,
    config = function()
      require('copilot_cmp').setup({
        formatters = {
          insert_text = require("copilot_cmp.format").remove_existing
        },
      })
    end
  },
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    enabled=false,
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
    cmd = 'Copilot'
  },
  {
    "Dynge/gitmoji.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    opts = { -- the values below are the defaults
      filetypes = {},
      completion = {
        append_space = true,
        complete_as = "emoji",
      },
    },
    -- ft = "gitcommit",
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'onsails/lspkind-nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-calc',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'ziontee113/color-picker.nvim',
    },
    event = {'InsertEnter', 'CmdlineEnter'},
    config = function()
      vim.cmd([[
        set completeopt=menu,menuone,noselect
      ]])

      -- Setup nvim-cmp.
      local cmp = require('cmp')
      local luasnip = require("luasnip")
      local lspkind = require('lspkind')

      -- lspkind.init({ 
      --   mode = "symbol_text",
      --   preset = 'codicons',
      --   symbol_map = { Text = "u" }
      -- })
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})

      -- Utils
      local check_backspace = function()
        local col = vim.fn.col "." - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
      end

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
          sources = {
            { name = 'buffer' },
          }
        })

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
      end


      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
          sources = cmp.config.sources(
            {
              { name = 'path' }
            },
            {
              { name = 'cmdline', keyword_pattern = [[\!\@<!\w*]] },
              { name = 'gitmoji', keyword_pattern = [[Git commit.*\%('\|"\|\s\|^\)\zs:\w*:\?]]},
            }
            )
        })


      -- Mappings.
      local opts = { noremap=true, silent=true }
      vim.api.nvim_set_keymap('i', '<C-Space>', "<cmd>lua require('cmp').complete()<cr>", opts)

      cmp.setup({
          snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          preselect = cmp.PreselectMode.None,
          confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
          },
          window = {
            documentation = {
              -- border = "rounded",
              winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
            },
            completion = {
              -- border = "rounded",
              winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
            },
          },
          experimental = {
            ghost_text = true,
          },
          sorting = {
            priority_weight = 2,
            comparators = {
              -- require("copilot_cmp.comparators").prioritize,

              -- Below is the default comparitor list and order for nvim-cmp
              cmp.config.compare.offset,
              -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
              cmp.config.compare.exact,
              cmp.config.compare.score,
              cmp.config.compare.recently_used,
              cmp.config.compare.locality,
              cmp.config.compare.kind,
              cmp.config.compare.sort_text,
              cmp.config.compare.length,
              cmp.config.compare.order,
            },
          },
          mapping = {
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            -- ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Select}), { 'i', 'c' }),
            ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
            ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
            ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ['<C-e>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
              }),
            ['<CR>'] = function(fallback)

              if cmp.visible() then
                cmp.mapping.confirm({
                    select = false,
                    behaviour = cmp.ConfirmBehavior.Insert,
                  })(fallback)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-o>ma<C-o>=ip<C-o>`a',true,false,true), 'n', true)
              else
                fallback()
              end
              end,
            ["<Tab>"] = cmp.mapping(function(fallback)
              if luasnip.expandable() then
                luasnip.expand()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                -- elseif cmp.visible() then
                --   cmp.select_next_item()
                -- elseif check_backspace() then
                --   fallback()
              else
                fallback()
              end
            end, {
              "i",
              "s",
            }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
      },
      sources = cmp.config.sources({
          { name = "copilot" },
          { name = 'nvim_lsp' },
          -- { name = 'vsnip' }, -- For vsnip users.
          { name = 'luasnip', keyword_pattern = [[.\+]] }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          {
            name = 'buffer',
            keyword_pattern = '.\\+',
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            },
          },
          -- { name = 'snippy' }, -- For snippy users.
          { name = 'calc' },
        }, {
          { name = 'buffer', keyword_pattern = [[\w\+]] },
          { name = 'calc' },
          { name = 'path' },
        },{
          { name = 'buffer', keyword_pattern = [[\w\+]] },
        }, {
          { name = 'buffer' },
        }
        ),
      formatting = {
        -- format = function (entry, vim_item)
        --   vim_item = lspkind.cmp_format()(entry,vim_item)
        --   -- vim_item.dup = { cmdline = 0, path = 0 }
        --
        --   return vim_item
        -- end,
        format = lspkind.cmp_format({
          mode = "symbol_text",
          max_width = 50,
          symbol_map = { Copilot = "" }
        })
      },

      --[[ window = {
          completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
          },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. strings[1] .. " "
            kind.menu = "    (" .. strings[2] .. ")"

            return kind
          end,
        }, ]]

    })


end
  }
}
