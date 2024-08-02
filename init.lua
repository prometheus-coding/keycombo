-- Registra un comando Neovim che chiama la funzione sendRequest
vim.api.nvim_create_user_command('Send', function()
  require('keycombo').sendRequest()
end, {desc = 'Send data to server using keycombo plugin'})

