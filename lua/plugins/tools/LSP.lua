local on_attach = function(client, bufnr)
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('<leader>ld', require('telescope.builtin').lsp_definitions, '[D]efinition')
    nmap('<leader>lr', require('telescope.builtin').lsp_references, '[R]eferences')
    nmap('<leader>li', require('telescope.builtin').lsp_implementations, '[I]mplementation')
    nmap('<leader>lD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('<leader>ck', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<leader>cK', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    nmap('<leader>cf', ':%!npx prettier --stdin-filepath %<CR>', '[F]ormat file (Prettier)')

    if client.supports_method "textDocument/inlayHint" then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end
end

local common_capabilities = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return capabilities
end

local initialize_diagnostics = function()
    local icons = require('ui.icons')
    local default_diagnostic_config = {
        signs = {
            active = true,
            values = {
                { name = "DiagnosticSignError", text = icons.diagnostics.Error },
                { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
                { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
                { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
            },
        },
        virtual_text = false,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(default_diagnostic_config)

    for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end
end

return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', "BufNewFile" },
    dependencies = {
        {
            'williamboman/mason-lspconfig.nvim',
            'folke/neodev.nvim',
        },
    },
    config = function()
        local mason_lspconfig = require('mason-lspconfig')
        local nvim_lsp = require('lspconfig')

        require('mason').setup()
        require('mason-lspconfig').setup()
        initialize_diagnostics()

        local servers = {
            -- clangd = {},
            -- gopls = {},
            -- pyright = {},
            rust_analyzer = {},
            tsserver = {},
            -- html = { filetypes = { 'html', 'twig', 'hbs'} },

            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                    -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                    -- diagnostics = { disable = { 'missing-fields' } },
                },
            },
        }

        mason_lspconfig.setup_handlers {
            function(server_name)
                local opts = {
                    on_attach = on_attach,
                    capabilities = common_capabilities(),
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                }

                if server_name == "tsserver" then
                    opts.root_dir = nvim_lsp.util.root_pattern('.git', 'tsconfig.json', 'package.json', 'jsconfig.json')
                end

                if server_name == "lua_ls" then
                    require("neodev").setup {}
                end

                if server_name == "eslint" then
                    on_attach = function(_, bufnr)
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            command = "EslintFixAll",
                        })
                    end
                end

                require('lspconfig')[server_name].setup(opts)
            end,
        }
    end
}
