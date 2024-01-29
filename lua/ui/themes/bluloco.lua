return {
    'uloco/bluloco.nvim',
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    setup = {
        italics = true,
        terminal = vim.fn.has("gui_running") == 1
    }
}
