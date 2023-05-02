-- auto-close brackets
-- vim.keymap.set("i", "\"", "\"\"<left>", { noremap = true })
-- vim.keymap.set("i", "\'", "\'\'<left>", { noremap = true })
-- vim.keymap.set("i", "(", "()<left>", { noremap = true })
-- vim.keymap.set("i", "[", "[]<left>", { noremap = true })
-- vim.keymap.set("i", "{", "{}<left>", { noremap = true })

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader>t", builtin.find_files, {noremap = true})

-- floaterm
vim.keymap.set("n", "<leader>ft", ":FloatermToggle<cr>", {noremap = true})
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {noremap = true})
