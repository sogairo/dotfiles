local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "shaunsingh/nord.nvim",
    priority = 1000,
    config = function() vim.cmd.colorscheme("nord") end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        theme = "nord",
        component_separators = { left = "::", right = "::" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          { "branch", icon = "󰘬" },
          "diff",
          "diagnostics",
        },
        lualine_c = {
          { "filename", path = 0 },
          { "filesize" },
        },
        lualine_x = {
          { "encoding" },
          { "filetype" },
          { "lsp" },
          { "searchcount" },
          { "selectioncount" },
        },
        lualine_y = {
          "progress",
          { function() return os.date("%H:%M") end },
        },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    },
  },
})

vim.opt.fillchars = "eob: "
