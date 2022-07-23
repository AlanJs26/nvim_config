require'lightspeed'.setup {
  ignore_case = true,
  exit_after_idle_msecs = { unlabeled = 1000, labeled = 1200 },
  --- s/x ---
  jump_to_unique_chars = { safety_timeout = 400 },
  match_only_the_start_of_same_char_seqs = true,
  force_beacons_into_match_width = false,
  -- Display characters in a custom way in the highlighted matches.
  substitute_chars = { ['\r'] = '¬', },
  -- Leaving the appropriate list empty effectively disables "smart" mode,
  -- and forces auto-jump to be on or off.
  -- These keys are captured directly by the plugin at runtime.
  limit_ft_matches = 4,
  repeat_ft_with_target_char = false,
}

vim.cmd([[
noremap ; <Plug>Lightspeed_;_sx
noremap , <Plug>Lightspeed_,_sx
noremap gs <Plug>Lightspeed_omni_s
noremap X <Plug>Lightspeed_omni_gs
]])
