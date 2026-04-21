local map = vim.keymap.set

-- Basic
map('n', '<leader>w', ':w<CR>')
map('n', '<leader>q', ':q<CR>')

-- Clipboard
map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n', 'v' }, '<leader>p', '"+p')

--Files
map('n','<leader>e',':Ex<CR>')

-- Reload (safe)
map('n', '<leader>r', function()
	vim.cmd('source $MYVIMRC')
  print("Reloaded")
end)
