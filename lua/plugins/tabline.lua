return {
  'kdheepak/tabline.nvim',
  config = function()
    require'tabline'.setup()
    vim.cmd[[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
    ]]
  end,
}
