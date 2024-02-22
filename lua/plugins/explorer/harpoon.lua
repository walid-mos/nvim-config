---@diagnostic disable: missing-fields, missing-parameter
return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
        local harpoon = require("harpoon")
        harpoon.setup({
            settings = {
                save_on_toggle = true,
            }
        })

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end, { desc = '[A]ppend to harpoon' })
        vim.keymap.set("n", "<leader>hd", function() harpoon:list():remove() end, { desc = '[D]elete from harpoon' })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        -- vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
        -- vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
        -- vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
        -- vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<TAB>", function() harpoon:list():prev({ ui_nav_wrap = true }) end)
        vim.keymap.set("n", "<S-TAB>", function() harpoon:list():next({ ui_nav_wrap = true }) end)


        harpoon:extend({
            UI_CREATE = function(cx)
                vim.keymap.set("n", "ss", function()
                    harpoon.ui:select_menu_item({ vsplit = true })
                end, { buffer = cx.bufnr })

                vim.keymap.set("n", "sh", function()
                    harpoon.ui:select_menu_item({ split = true })
                end, { buffer = cx.bufnr })
            end,
        })
    end
}
