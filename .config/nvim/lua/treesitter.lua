vim.opt.foldenable      = false
vim.opt.foldmethod      = "expr"
vim.opt.foldexpr        = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel       = 1
vim.opt.foldlevelstart  = 99

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "go",
        "javascript",
        "rust",
        "lua",
        "python",
        "toml",
        "typescript",
        "tsx",
        "ql",
    },

    highlight = {
        enable = true,
    },
}
