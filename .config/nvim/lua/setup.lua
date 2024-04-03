-- Review
vim.opt.mouse                 = "a"
vim.opt.scrolloff             = 10
vim.opt.wildmode              = "list:longest,list:full"
vim.o.completeopt             = 'menuone,noselect'
vim.g.python_host_skip_check  = 1
vim.g.python3_host_skip_check = 1
vim.g.python_host_prog        = '~/.config/nvim/venv/bin/python'
-- vim.g.python3_host_prog       = '/usr/local/bin/python3'
vim.g.python3_host_prog  = '~/.config/nvim/venv/bin/python3'
vim.g.perl_host_prog          = '/usr/local/bin/perl'
vim.g.loaded_perl_provider    = 0

vim.g.mapleader               = ","
vim.opt.inccommand            = "split"
vim.opt.cindent               = true
vim.opt.cursorline            = true
vim.opt.ignorecase            = true
vim.opt.linebreak             = true
vim.opt.breakindent           = true
vim.opt.number                = true
vim.opt.relativenumber        = true
vim.opt.smartcase             = true
vim.opt.smartindent           = true
vim.opt.smarttab              = true
vim.opt.expandtab             = true
vim.opt.tabstop               = 4
vim.opt.softtabstop           = 4
vim.opt.shiftwidth            = 4
vim.opt.updatetime            = 300
vim.opt.signcolumn              = "yes"
vim.opt.clipboard             = "unnamedplus"
vim.opt.splitright = true
vim.opt.shell = "/bin/zsh -i"

vim.api.nvim_create_user_command('GitConfig', 'vsplit ~/.gitconfig', {})
vim.api.nvim_create_user_command('ZshConfig', 'vsplit ~/.zshrc', {})
vim.api.nvim_create_user_command('NvimConfig', 'vsplit ~/.config/nvim/lua/keymap.lua', {})


-- Only show relative numbers in the current pane
-- Toggle when switching between panes
vim.api.nvim_exec([[
    function! SetRelativeNumber() abort
        if (bufname("%") =~ "NERD_Tree_")
            return
        endif
        set relativenumber
    endfunction

    function! SetNoRelativeNumber() abort
        set norelativenumber
    endfunction

    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * call SetRelativeNumber()
        autocmd BufLeave,FocusLost,InsertEnter   * call SetNoRelativeNumber()
    augroup END
]], false)

-- Selenized colorscheme and thin seperator
vim.cmd([[
     set termguicolors
     set background=dark
     colorscheme selenized
     set fillchars+=vert:\|
     highlight VertSplit guibg=NONE guifg=#93a1a1
     highlight LineNr guibg=NONE
]])

require("CopilotChat").setup {}
