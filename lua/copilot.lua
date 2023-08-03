-- use this table to disable/enable filetypes
-- vim.g.copilot_filetypes = { xml = false, markdown = false }


-- since most are enabled by default you can turn them off using this table and only enable for a few filetypes 
-- vim.g.copilot_filetypes = { ["+"] = false, python = true }

-- Change accept suggestion
vim.cmd[[imap <silent><script><expr> π copilot#Accept("\<CR>")]]
-- vim.api.nvim_set_keymap("i", "π", "<cmd>call copilot#Accept()<CR>", { noremap = true, silent = true })
vim.g.copilot_no_tab_map = true

-- <C-]>      Dismiss the current suggestion
-- <Plug>(copilot-dismiss)


-- Copilot suggestion foreground color
vim.cmd[[highlight CopilotSuggestion guifg=#555555 ctermfg=8]]

-- Map next and previoInsensitiveIncludeus suggestion
vim.api.nvim_set_keymap("i", "ø", "<cmd>call copilot#Next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "ı", "<cmd>call copilot#Next()<CR>", { noremap = true, silent = true })
