local ls = require("luasnip")

local utils = require("luasnip-latex-snippets.util.utils")
local pipe = utils.pipe
local no_backslash = utils.no_backslash

local with_priority = require("luasnip-latex-snippets.util.utils").with_priority

local opts = {
  use_treesitter = false,
}

local M = {}

M.setup = function()
  local is_math = utils.with_opts(utils.is_math, opts.use_treesitter)
  local not_math = utils.with_opts(utils.not_math, opts.use_treesitter)

  ls.config.setup({ enable_autosnippets = true })
  local autosnippets = {}

  -- define snippets ---------------
  local math_iA_no_backslash = {
    ls.parser.parse_snippet({ trig = "we", name = "\\wedge" }, "\\wedge "),
    ls.parser.parse_snippet({ trig = "spp", name = "\\:" }, " \\: "),
    ls.parser.parse_snippet({ trig = "inp", name = "\\langle,\\rangle" }, "\\langle $1\\rangle $0"),
    ls.parser.parse_snippet({ trig = "lvn", name = "list of vectors" }, "($1_1,$1_2,\\dots,$1_n)$0"),
    ls.parser.parse_snippet({ trig = "([%a])ii", name = "x_i" }, "$1_{i}"),
  }

  local vec_node = {
    ls.function_node(function(_, snip)
      return string.format("%s_i ", snip.captures[1])
    end, {}),
  }

  local math_wrA_no_backslash = {
    ls.snippet({ trig = "([%w])ii" }, vim.deepcopy(vec_node)),
  }

  local normal_wA = {
    ls.parser.parse_snippet({ trig = "ml", name = "Math" }, "$ ${1:${TM_SELECTED_TEXT}} $$0"),
  }

  -- subscribe snippets --------------
  for _, snip in ipairs(math_iA_no_backslash) do
    snip.wordTrig = false
    snip.condition = pipe({ is_math, no_backslash })
    table.insert(autosnippets, snip)
  end

  for _, snip in ipairs(math_wrA_no_backslash) do
    snip.regTrig = true
    snip.condition = pipe({ is_math, no_backslash })
    table.insert(autosnippets, snip)
  end

  for _, snip in ipairs(normal_wA) do
    snip.condition = pipe({ not_math })
    table.insert(autosnippets, snip)
  end


  -- apply snippets ---------------
  ls.add_snippets("tex", autosnippets, {
    type = "autosnippets",
    default_priority = 0,
  })
end

return M


