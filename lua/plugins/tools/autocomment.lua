---@diagnostic disable: missing-fields
return {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
        require('Comment').setup({
            padding = true,

            pre_hook = function()
                return vim.bo.commentstring
            end,
        })
    end
}
