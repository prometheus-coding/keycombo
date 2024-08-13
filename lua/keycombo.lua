local M = {}
local http = require("socket.http")
local ltn12 = require("ltn12")

M.counter = 0
M.keySequence = {}
-- Target sequences of keys for specific actions
M.targetSequences = {
    -- Sequence to swap two characters
    xp = {'x', 'p'},
    -- Sequence to select a block including the line before the '{'
    vaBV = {'v', 'a', 'B', 'V'},
    -- Sequence to select the whole function if the cursor is on the function name
    VdollaroPercentuale = {'V', '$', '%'},
    -- Custom sequence to yank, comment, and paste a line
    zz_nmap = {'y', 'y', 'g', 'c', 'c', 'p'},
    -- Custom sequence to select, yank, and paste with visual mode mapping
    zz_vmap = {'V', '<Esc>', 'g', 'v', 'y', 'g', 'v', 'g', 'c', '`', '>', 'p'}
}

function M.setup()
    vim.on_key(function(key)
        local key_char = vim.api.nvim_replace_termcodes(key, true, false, true)
        M.show_key(key_char)
    end)
end

function M.show_key(key)


    -- api outwrite
    local key_hex = string.format("%02x", string.byte(key, 1))

    -- Filter out mouse inputs
    if  key_hex == "80" then
        vim.o.statusline = "matched mouse | Count: " .. M.counter
        vim.api.nvim_command('redrawstatus')
        return
    end


    -- strange code there i think is not right
    table.insert(M.keySequence, key)
    if #M.keySequence > 4 then
        table.remove(M.keySequence, 1)  -- Keep only the last 4 keys pressed- add somethign to remove everything
    end

-- is okay active at everyclick seems good lookign for boolean true false
    if M.check_sequence() then
        M.counter = M.counter + 500
        vim.o.statusline = "key combo +500! Count: " .. M.counter
        M.keySequence = {}  -- Reset the sequence after a match
    else
        M.counter = M.counter + 1
        vim.o.statusline = string.format("Key pressed: %s | Count: %d", key, M.counter)
    end
    vim.api.nvim_command('redrawstatus')
end

--checking the sequence logic with != pair
function M.check_sequence()
    if #M.keySequence ~= 4 then
        return false
    end

    for i, v in ipairs(M.targetSequence) do
        if M.keySequence[i] ~= v then
            return false
        end
    end
    return true
end

-- TOKEN ##############
 local id_token = "8c7e013fcc0f5b778cbcf1f98c56938c6f6391520c4152c910677db2f0b049df"

-- 
--  nvim --cmd "set rtp+=." lua/keycombo.lua
-- :lua require("keycombo").setup()
-- :lua require('keycombo').sendRequest()
--
-- TOKEN END ###########


-- START POST REQUEST ## SENDING DATA!!!! 
-- Funzione per inviare una richiesta HTTP POST
function M.sendRequest()
    local path = "http://localhost:3000/api/v1/users/updateUserScore"
    local payload = string.format([[
    {
        "id_token": "%s",
        "userName": "userName",
        "total_key_pressed": %d
    }
    ]], id_token, M.counter)

    -- declaring local response for null {} is to prepare like a print
    local response_body = {}

    -- better understand better response, Post path, bearer
    local res, code, response_headers, status = http.request {
        url = path,
        method = "POST",
        headers = {
            ["Authorization"] = "Bearer " .. id_token, -- sistemare token  
            ["Content-Type"] = "application/json",
            ["Content-Length"] = tostring(#payload)
        },
        source = ltn12.source.string(payload),
        sink = ltn12.sink.table(response_body)
    }

    -- Stampa la risposta nel command-line di Neovim
    print('Response: ' .. table.concat(response_body) .. ' Code: ' .. tostring(code) .. ' Status: ' .. tostring(status))
end

-- Altre funzioni
-- END POST REQUEST#################

return M
