-- Sync clipboard between OS and Nvim.
-- Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.opt.clipboard = 'unnamed'

-- enable line number and relative line number
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true -- highlight the current line
vim.opt.ruler = false

-- disable mouse 
vim.opt.mouse = ""

-- tab width
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.wrap = false -- display lines as one long line

-- screen
vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 8
vim.opt.title = false
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.pumblend = 10
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
-- vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
-- colorcolumn = "80",
-- colorcolumn = "120",

-- creates a backups file
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- use number of spaces to insert <Tab>
vim.opt.expandtab = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.smartindent = true -- make indenting smarter again

-- Terminal options
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.termguicolors = true -- NOTE: You should make sure your terminal supports this
vim.opt.showcmd = false

-- Miscelianous
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]

vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars:append {
  stl = " ",
}

vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.laststatus = 3
vim.opt.shortmess:append "c"

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
