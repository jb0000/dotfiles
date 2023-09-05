local nvim_lsp = require('lspconfig')
local luasnip  = require('luasnip')
local lspkind  = require('lspkind')

vim.opt.completeopt = { 'menuone', 'noselect' }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
        prefix  = "»",
        spacing = 4,
    },
    signs            = true,
    update_in_insert = false,
}
)

require('luasnip/loaders/from_lua').lazy_load({
    paths = {
        '~/.config/nvim/snippets',
    }
})
require('lspkind').init({
    with_test = true,
})

-- https://sbulav.github.io/vim/neovim-setting-up-luasnip/
local cmp = require('cmp')
cmp.setup {
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select   = true,
        },
    },
    formatting = {
        format = function (entry, vim_item)
            vim_item.menu= ({
                nvim_lsp = '[LSP]',
                luasnip  = '[LuaSnip]',
                buffer   = '[Buffer]',
                nvim_lua = '[NvimLua]',
                path     = '[Path]',
                cmp_tabnine = "[TN]",
            })[entry.source.name]

            return vim_item
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer '},
        { name = 'nvim_lua '},
        { name = 'path '},
        -- { name = 'cmp_tabnine' },
    },
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', '<Leader>k',      '<Cmd>lua vim.lsp.buf.definition()<CR>',                   opts)
    buf_set_keymap('n', 'K',          '<Cmd>lua vim.lsp.buf.hover()<CR>',                        opts)
    buf_set_keymap('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>',                       opts)
    buf_set_keymap('n', 'gr',         '<Cmd>lua vim.lsp.buf.references()<CR>',                   opts)
    buf_set_keymap('n', 'gi',         '<Cmd>lua vim.lsp.buf.implementation()<CR>',                   opts)
    buf_set_keymap('n', 'gh',         '<Cmd>lua vim.lsp.buf.document_highlight()<CR>',           opts)
    buf_set_keymap('n', 'gc',         '<Cmd>lua vim.lsp.buf.clear_references()<CR>',             opts)
    buf_set_keymap('n', 'ge',         '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',           opts)

    vim.cmd([[
    highlight LspReference guifg=NONE guibg=#665c54 guisp=NONE gui=NONE cterm=NONE ctermfg=NONE ctermbg=59
    highlight! link LspReferenceText  LspReference
    highlight! link LspReferenceRead  LspReference
    highlight! link LspReferenceWrite LspReference
    ]])

    if filetype == "rust" then
        vim.cmd([[
        augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting(nil, 5000)
        augroup END
        ]])
    elseif filetype == "typescriptreact" then
        vim.api.nvim_exec([[
        augroup LspAutocommands
        autocmd! * <buffer>
        autocmd BufWritePost <buffer> :lua vim.lsp.buf.formatting()
        augroup END
        ]], true)
    end
end

-- Go
nvim_lsp.gopls.setup {
    on_attach    = on_attach,
    capabilities = capabilities,
    flags        = {
        debounce_text_changes = 200,
    },
}

-- Rust
nvim_lsp.rust_analyzer.setup{
    on_attach    = on_attach,
    capabilities = capabilities,
}

-- TypeScript
nvim_lsp.tsserver.setup {
    on_attach    = on_attach,
    capabilities = capabilities,
}

nvim_lsp.eslint.setup {
    on_attach    = on_attach,
    capabilities = capabilities,
}

nvim_lsp.html.setup {
    on_attach    = on_attach,
    capabilities = capabilities,
}

-- Lua
require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

