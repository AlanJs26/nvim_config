set completeopt=menu,menuone,noselect

highlight CmpItemKind guifg=#7aa2f7 
highlight CmpItemAbbrMatch guifg=#7aa2f7 
highlight CmpItemAbbrMatchFuzzy guifg=#4c68a6 

lua <<EOF
  vim.g.UltiSnipsRemoveSelectModeMappings = 0
  
  -- Setup nvim-cmp.
  local cmp = require'cmp'
  local lspkind = require('lspkind')
  lspkind.init({
    with_text = true,
  })

  local has_any_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
      return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local press = function(key)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
  end

  cmp.setup({
    formatting = {
      format = lspkind.cmp_format({with_text = true, maxwidth = 50})
    },
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ["<C-Space>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
            return press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
            -- return vim.fn["UltiSnips#ExpandSnippet"]()

          end

          cmp.select_next_item()
        elseif has_any_words_before() then
          press("<Space>")
        else
          fallback()
        end
      end, {
        "i",
        "s",
        -- add this line when using cmp-cmdline:
        -- "c",
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.get_selected_entry() == nil and vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
          -- press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
          vim.fn["UltiSnips#ExpandSnippet"]()
        elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          press("<ESC>:call UltiSnips#JumpForwards()<CR>")
          -- vim.fn["UltiSnips#JumpForwards"]()
        elseif cmp.visible() then
          cmp.select_next_item()
        elseif has_any_words_before() then
          press("<Tab>")
        else
          fallback()
        end
      end, {
        "i",
        "s",
        -- add this line when using cmp-cmdline:
        -- "c",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          press("<ESC>:call UltiSnips#JumpBackwards()<CR>")
          -- vim.fn["UltiSnips#JumpBackwards"]()
        elseif cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, {
        "i",
        "s",
        -- add this line when using cmp-cmdline:
        -- "c",
      }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
      { name = 'path' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

EOF
