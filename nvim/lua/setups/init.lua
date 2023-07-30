-- require('setups.onedark');
-- require('setups.onenord');
require('setups.whichkey');
require('setups.lsp');
require('setups.telescope');
require('setups.treesitter');
require('setups.cmp');
require('setups.lualine');
require('setups.toggleterm');
-- require('setups.indent_blankline');
-- require('setups.dashboard');
require('setups.autotag')

require('darkplus').setup()


require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
