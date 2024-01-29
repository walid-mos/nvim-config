return {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
        'smoka7/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
        {
            mode = { 'v', 'n' },
            '<Leader>mw',
            '<cmd>MCstart<cr>',
            desc = 'Multicursor under selected word or text',
        },
        {
            mode = { 'v', 'n' },
            '<Leader>mc',
            '<cmd>MCunderCursor<cr>',
            desc = 'Multicursor under cursor',
        },
    },
}
