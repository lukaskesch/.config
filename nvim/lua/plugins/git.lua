return {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[p]revious hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[n]ext hunk' })
        vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'preview [h]unk' })
        vim.keymap.set('n', '<leader>gr', require('gitsigns').reset_hunk, { buffer = bufnr, desc = '[r]eset hunk' })
        vim.keymap.set('n', '<leader>gR', require('gitsigns').reset_buffer, { buffer = bufnr, desc = '[R]eset buffer' })
        vim.keymap.set('n', '<leader>gB', require('gitsigns').blame_line, { buffer = bufnr, desc = '[B]lame line' })
        vim.keymap.set('n', '<leader>gs', require('gitsigns').stage_hunk, { buffer = bufnr, desc = '[s]tage hunk' })
        vim.keymap.set('n', '<leader>gu', require('gitsigns').undo_stage_hunk, { buffer = bufnr, desc = '[u]ndo stage hunk' })
        vim.keymap.set('n', '<leader>gd', '<cmd>Gitsigns diffthis HEAD<cr>', { buffer = bufnr, desc = '[d]iff' })
        vim.keymap.set('n', '<leader>gf', '<cmd>Telescope git_status<cr>', { buffer = bufnr, desc = 'changed [f]iles' })
        vim.keymap.set('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', { buffer = bufnr, desc = '[b]ranches' })
        vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', { buffer = bufnr, desc = '[c]ommits' })
        vim.keymap.set('n', '<leader>gh', '<cmd>Telescope git_bcommits<cr>', { buffer = bufnr, desc = '[h]istory of file' })
      end,
    },
  },
}
