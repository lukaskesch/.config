local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = true,         -- shows a list of your marks on ' and `
        registers = true,     -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false,   -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true,      -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true,      -- default bindings on <c-w>
            nav = true,          -- misc bindings to work with windows
            z = true,            -- bindings for folds, spelling and others prefixed with z
            g = true,            -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded",       -- none, single, double, shadow
        position = "bottom",      -- bottom, top
        margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 },                                           -- min and max height of the columns
        width = { min = 20, max = 50 },                                           -- min and max width of the columns
        spacing = 3,                                                              -- spacing between columns
        align = "left",                                                           -- align columns left, center or right
    },
    ignore_missing = false,                                                       -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true,                                                             -- show help message on the command line when the popup is visible
    triggers = "auto",                                                            -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {

    ["k"] = { "<cmd>bdelete<CR>", "Kill Buffer" }, -- Close current file
    -- ["p"] = { "<cmd>Lazy<CR>", "Plugin Manager" }, -- Invoking plugin manager
    ["q"] = { "<cmd>wqall!<CR>", "Quit" },         -- Quit Neovim after saving the file
    ["w"] = { "<cmd>w!<CR>", "Save" },             -- Save current file
    ["r"] = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Reformat Code" },
    b = {
        name = "Buffers",
        h = { "<cmd>Telescope oldfiles<CR>", "prev. opend" },
        n = { "<cmd>ene<CR>", "new buffer" },
    },
    c = {
        name = "Terminal",
        f = { "<cmd>ToggleTerm direction=\"float\"<CR>", "float" },
        h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "horizontal" },
        t = { "<cmd>ToggleTerm <cr>", "toggle" },
        v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "vertical" },
    },
    f = {
        name = "Files",
        e = { "<cmd>Ex<CR>", "file explorer" },
        n = { "<cmd>ene<CR>", "new file" },
        r = { ":GMove " .. vim.api.nvim_buf_get_name(0) .. "", "rename file", silent = false }
    },
    g = {
        name = "Git",
        f = { "<cmd>Telescope git_files<CR>", "find git files" },
    },
    s = {
        name = "Search",
        b = { "<cmd>Telescope buffers<CR>", "buffers" },
        c = { "<cmd>Telescope colorscheme<CR>", "colorscheme" },
        d = { "<cmd>Telescope diagnostics<CR>", "diagnostics" },
        f = { "<cmd>Telescope find_files<CR>", "files" },
        g = { "<cmd>Telescope live_grep<CR>", "live grep" },
        h = { "<cmd>Telescope command_history<CR>", "command history" },
        H = { "<cmd>Telescope help_tags<CR>", "help tags" },
        j = { "<cmd>Telescope jumplist<CR>", "jumplist" },
        k = { "<cmd>Telescope keymaps<CR>", "keymaps" },
        m = { "<cmd>Telescope marks<CR>", "marks" },
        M = { "<cmd>Telescope man_pages<CR>", "man pages" },
        o = { "<cmd>Telescope oldfiles<CR>", "oldfiles" },
        w = { "<cmd>Telescope grep_string<CR>", "grep string" },
        q = { "<cmd>Telescope quickfix<CR>", "quickfixes" },
        r = { "<cmd>Telescope resume<CR>", "resume" },
        R = { "<cmd>Telescope registers<CR>", "registers" },
        v = { "<cmd>Telescope vim_options<CR>", "vim options" },
    },
    t = {
        name = "Tabs",
        c = { "<cmd>tabclose<CR>", "close tab" },
        e = { "<cmd>tabnew | Ex <CR>", "file explorer in new tab" },
        f = { ":tabnew | Telescope find_files<CR>", "search file in new tab" },
        m = { ":tabmove ", "tab move", silent = false },
        n = { "<cmd>tabnew<CR>", "empty buffer in new tab" },
        o = { "<cmd>tabonly<CR>", "tab only" },
        t = { "<cmd>ToggleTerm direction=\"tab\" <CR>", "terminal in new tab" },
    },
}

vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { desc = '[p]revious hunk' })
vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { desc = '[n]ext hunk' })
vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk, { desc = 'preview [h]unk' })
vim.keymap.set('n', '<leader>gr', require('gitsigns').reset_hunk, { desc = '[r]eset hunk' })
vim.keymap.set('n', '<leader>gR', require('gitsigns').reset_buffer, { desc = '[R]eset buffer' })
vim.keymap.set('n', '<leader>gB', require('gitsigns').blame_line, { desc = '[B]lame line' })
vim.keymap.set('n', '<leader>gs', require('gitsigns').stage_hunk, { desc = '[s]tage hunk' })
vim.keymap.set('n', '<leader>gu', require('gitsigns').undo_stage_hunk, { desc = '[u]ndo stage hunk' })
vim.keymap.set('n', '<leader>gd', '<cmd>Gitsigns diffthis HEAD<cr>', { desc = '[d]iff' })
vim.keymap.set('n', '<leader>gf', '<cmd>Telescope git_status<cr>', { desc = 'changed [f]iles' })
vim.keymap.set('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', { desc = '[b]ranches' })
vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', { desc = '[c]ommits' })
vim.keymap.set('n', '<leader>gh', '<cmd>Telescope git_bcommits<cr>', { desc = '[h]istory of file' })


vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { silent = true })
vim.keymap.set('n', '<esc>', '<cmd>ToggleTerm<CR>', { silent = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- greatest remaps ever
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- yank to and past from system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])


-- moving selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

which_key.setup(setup)
which_key.register(mappings, opts)
