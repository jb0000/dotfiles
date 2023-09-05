local opts = { noremap = true }

-- EXPERIMENTAL
vim.api.nvim_set_keymap('n', '<C-w>', '<C-W>x', opts)
vim.api.nvim_set_keymap('n', '<Leader>u', ':GitGutterUndoHunk<CR>', opts)
vim.api.nvim_create_user_command('ReviewM', 'let g:gitgutter_diff_base = "master" | GitGutterQuickFix', {})
vim.api.nvim_create_user_command('Review', 'let g:gitgutter_diff_base = "main" | GitGutterQuickFix', {})
vim.api.nvim_create_user_command('Diff', 'GitGutterDiffOrig', {})

-- Paste yank buffer over a given movement
-- https://www.vikasraj.dev/blog/vim-dot-repeat
function _G.__paste_over_movement(motion)
 local is_visual = string.match(motion or '', "[vV]")
    if motion == nil then
        vim.o.operatorfunc = "v:lua.__paste_over_movement"
        return "g@"
    end
 
    if is_visual then
        vim.api.nvim_command('execute "normal! `<v`>\"0p`<')
    else
        vim.api.nvim_command("execute 'normal! `[v`]\"0p`['")
    end
end
 
vim.keymap.set("n", "x", _G.__paste_over_movement, { expr = true }) -- 1.


-- Quickfix
vim.api.nvim_set_keymap('n', '∆', ':cn<CR>', opts)
vim.api.nvim_set_keymap('n', '˚', ':cp<CR>', opts)

-- Window swap
vim.api.nvim_set_keymap('n', '<C-w>', '<C-W>x', opts)

-- write and quit
vim.api.nvim_set_keymap('n', '<Leader>s', ':w<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>q', ':q<CR>', opts)
vim.api.nvim_set_keymap('t', '<Leader>q', '<C-\\><C-n>:q<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>a', ':qa<CR>', opts)

-- normal mode
vim.api.nvim_set_keymap('i', 'jk',        '<ESC>l', opts)
vim.api.nvim_set_keymap('t', 'jk',        '<C-\\><C-n>', opts)

-- open terminal
vim.api.nvim_set_keymap('n', '<Leader>.', ':vsplit | term<CR>i', opts)

-- movement
vim.api.nvim_set_keymap('n', 'j',         'gj',     opts)
vim.api.nvim_set_keymap('n', 'k',         'gk',     opts)

vim.api.nvim_set_keymap('n', 'Y', 'y$', opts)
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', opts)
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', opts)

-- line inserting/ deleting
vim.api.nvim_set_keymap('n', '<leader>o', 'o<ESC>k', opts)
vim.api.nvim_set_keymap('n', '<leader>O', 'O<ESC>j', opts)
vim.api.nvim_set_keymap('n', 'J', 'mzJ`z', opts)

-- search and replace
vim.api.nvim_set_keymap('n', 's', ':%s/', opts)
vim.api.nvim_set_keymap('v', 's', ':s/', opts)

-- Pane hopping
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', opts)
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', opts)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', opts)

vim.api.nvim_set_keymap('t', '<C-j>', '<C-\\><C-n><C-w>j', opts)
vim.api.nvim_set_keymap('t', '<C-k>', '<C-\\><C-n><C-w>k', opts)
vim.api.nvim_set_keymap('t', '<C-h>', '<C-\\><C-n><C-w>h', opts)
vim.api.nvim_set_keymap('t', '<C-l>', '<C-\\><C-n><C-w>l', opts)

-- Git
vim.api.nvim_set_keymap('n', '<Leader>c', ':GitGutterNextHunkWrap<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>p', ':GitGutterPreviewHunk<CR>', opts)

-- Nerdtree
vim.api.nvim_set_keymap('', '<C-b>', ':NERDTreeFind<CR>',  opts)

-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>f', '<Cmd>Telescope find_files<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>g', '<Cmd>Telescope live_grep<CR>',  opts)
vim.api.nvim_set_keymap('n', '<Leader>h', '<Cmd>Telescope lsp_document_symbols<CR>',    opts)
vim.api.nvim_set_keymap('n', '<Leader>,', '<Cmd>Telescope buffers<CR>',    opts)
-- vim.api.nvim_set_keymap('n', '<Leader>h', '<Cmd>Telescope help_tags<CR>',  opts)

-- Commentary
vim.api.nvim_set_keymap('n', '<C-a>', ':Commentary<CR>', opts)
vim.api.nvim_set_keymap('x', '<C-a>', ':Commentary<CR>', opts)

-- Debug
vim.api.nvim_set_keymap('n', '<Leader>b', ':DlvToggleBreakpoint<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>B', ':DlvClearAll<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>D', ':DlvTestCurrent<CR>', opts)

-- Test
vim.api.nvim_set_keymap('n', '<Leader>t', ':GoTest<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>T', ':GoCoverage<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>r', ':GoCoverageClear<CR>', opts)

-- Diagnostics
vim.api.nvim_set_keymap('n', '<Leader>d', '<Cmd>lua vim.diagnostic.goto_next()<CR>',  opts)
