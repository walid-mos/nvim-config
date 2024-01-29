return {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
    opts = {
        -- Conform will run multiple formatters sequentially
        -- Use a sub-list to run only the first available formatter
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            typescript = { 'prettier' },
            typescriptreact = { 'prettier' },
            javascript = { 'prettier' },
            javascriptreact = { 'prettier' },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        formatters = {
            shfmt = {
                prepend_args = { "-i", "2" },
            },
        },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
