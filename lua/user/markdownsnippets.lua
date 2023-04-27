local ls = require("luasnip")
local conds = require("luasnip.extras.expand_conditions")

local utils = require("luasnip-latex-snippets.util.utils")
local pipe = utils.pipe
local no_backslash = utils.no_backslash

local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node
local s = ls.snippet

local M = {}

local default_opts = {
  use_treesitter = false,
}

M.setup = function(opts)
  opts = vim.tbl_deep_extend("force", default_opts, opts or {})

  local is_math = utils.with_opts(utils.is_math, opts.use_treesitter)
  local not_math = utils.with_opts(utils.not_math, opts.use_treesitter)

  ls.config.setup({ enable_autosnippets = true })

  local math_i = require("luasnip-latex-snippets/math_i")
  for _, snip in ipairs(math_i) do
    snip.condition = pipe({ is_math })
    snip.show_condition = is_math
    snip.wordTrig = false
  end

  ls.add_snippets("markdown", math_i, { default_priority = 0 })

  local autosnippets = {
    s({ trig = "(%a)dot", name = "\\dot{x}", wordTrig = true, priority = 100 },
        f(function(_, snip) return string.format("\\dot{%s}", snip.captures[1])
    end, {})),
    s({ trig = "(%a)ddot", name = "\\ddot{x}", wordTrig = false, priority = 100 },
        f(function(_, snip) return string.format("\\ddot{%s}", snip.captures[1])
    end, {})),
    s({ trig = "(%a)([0-9])", name = "x_0", wordTrig = true, priority = 100 },
        f(function(_, snip) return string.format("%s_%s", snip.captures[1], snip.captures[2]) end, {})
    ),
    s({ trig = "([%a0-9_\\{\\}\\\\]+)/", name = "num frac", wordTrig = true, priority = 100 },
      {
        t"\\frac{",
          f(function(_, snip) return snip.captures[1] end, {}),
        t"}{",
          i(1),
        t"}",
        i(0)
      }
    ),
  }

  for _, snip in ipairs(autosnippets) do
    snip.regTrig = true
    snip.condition = pipe({ is_math, no_backslash })
  end

  for _, snip in ipairs(require("luasnip-latex-snippets/math_wRA_no_backslash")) do
    snip.regTrig = true
    snip.condition = pipe({ is_math, no_backslash })
    table.insert(autosnippets, snip)
  end

  for _, snip in ipairs(require("luasnip-latex-snippets/math_rA_no_backslash")) do
    snip.wordTrig = false
    snip.regTrig = true
    snip.condition = pipe({ is_math, no_backslash })
    table.insert(autosnippets, snip)
  end
  local normal_wa = require("luasnip-latex-snippets/normal_wA")

  for _, snip in ipairs(normal_wa) do
    if snip['dscr'][1] == 'mk' then
       snip = ls.parser.parse_snippet({ trig = "mk", name = "Math" },
         "\\$${1:${TM_SELECTED_TEXT}}\\$$0")
     elseif snip['dscr'][1] == 'dm' then
       snip = ls.parser.parse_snippet({ trig = "dm", name = "Math" },
        "\\$\\$\n${1:${TM_SELECTED_TEXT}}\n\\$\\$ $0")
    end
    snip.condition = pipe({ not_math })

    table.insert(autosnippets, snip)
  end

  local math_wrA = {
    unpack(require("luasnip-latex-snippets/math_wrA")),
    -- "$1_{i}$0"
    ls.snippet({ trig = "(%a)ii", name = "x_i" },
        f(function(_, snip) return snip.captures[1] .. "_{i}" end, {})
    ),
  }

  for _, snip in ipairs(math_wrA) do
    snip.regTrig = true
    snip.condition = pipe({ is_math })
    table.insert(autosnippets, snip)
  end




  for _, snip in ipairs(require("luasnip-latex-snippets/math_wA_no_backslash")) do
    snip.condition = pipe({ is_math, no_backslash })
    table.insert(autosnippets, snip)
  end

  for _, snip in ipairs(require("luasnip-latex-snippets/math_iA")) do
    snip.wordTrig = false
    snip.condition = pipe({ is_math })
    table.insert(autosnippets, snip)
  end


  local math_iA_no_backslash = {
    unpack(require("luasnip-latex-snippets/math_iA_no_backslash")),
    ls.parser.parse_snippet({ trig = "we", name = "\\wedge" }, "\\wedge "),
    ls.parser.parse_snippet({ trig = "pm", name = "easy plus" }, "+"),
    ls.parser.parse_snippet({ trig = "pn", name = "easy minus" }, "-"),
    ls.parser.parse_snippet({ trig = "tm", name = "easy times" }, "*"),
    ls.parser.parse_snippet({ trig = "spp", name = "\\:" }, " \\: "),
    ls.parser.parse_snippet({ trig = "beg", name = "begin end" }, "\\begin{$1}\n$2\n\\end{$1}$0"),

    -- linear algebra

    ls.parser.parse_snippet({ trig = "inp", name = "\\langle,\\rangle" }, "\\langle $1\\rangle $0"),
    ls.parser.parse_snippet({ trig = "lvn", name = "list of vectors" }, "($1_1,$1_2,\\dots,$1_n)$0"),
    ls.parser.parse_snippet({ trig = "tran", name = "linear transformation" }, "T \\colon $1 \\to $2 $0"),
    ls.parser.parse_snippet({ trig = "dim", name = "dimension" }, "\\text{dim } $0"),
    ls.parser.parse_snippet({ trig = "det", name = "determinant" }, "\\text{det } $0"),
    ls.parser.parse_snippet({ trig = "TT", name = "transformation matrix" }, "[$1] _{\\mathbb{$2}}$0"),
    ls.parser.parse_snippet({ trig = "bb", name = "mathbb" }, "\\mathbb{$1}$0"),
  }

  for _, snip in ipairs(math_iA_no_backslash) do
    snip.wordTrig = false
    snip.condition = pipe({ is_math, no_backslash })
    table.insert(autosnippets, snip)
  end

  for _, snip in ipairs(require("luasnip-latex-snippets/math_bwA")) do
    snip.condition = pipe({ conds.line_begin, is_math })
    table.insert(autosnippets, snip)
  end

  for _, snip in ipairs(require("luasnip-latex-snippets/bwA")) do
    snip.condition = pipe({ conds.line_begin, not_math })

    if snip['dscr'][1] ~= 'beg' then
      table.insert(autosnippets, snip)
    end
  end

  ls.add_snippets("markdown", autosnippets, {
    type = "autosnippets",
    default_priority = 0,
  })
end

return M
