local M = {}
local http = require("socket.http")
local ltn12 = require("ltn12")

M.counter = 0
M.keySequence = {}
-- Target sequences of keys for specific actions


-- il problema sta sul fatto che sono array dentro array, non so se la funzione e' gisuta probabilmente e' sbaglaita
M.targetSequences = {
    -- Sequence to swap two characters
    -- Sequence to select a block including the line before the '{'
    vaBV = {'k','k','k','k'},
    -- Sequence to select the whole function if the cursor is on the function name
    VdollaroPercentuale = {'j','j','j','j'},
    ggg = {'g','g','g','g'},
    ar = {'j','g'}
}

function M.setup()
    vim.on_key(function(key)
        local key_char = vim.api.nvim_replace_termcodes(key, true, false, true)
        M.show_key(key_char)
    end)
end

function M.show_key(key)
    local key_hex = string.format("%02x", string.byte(key, 1))

    -- Filtra gli input del mouse
    if key_hex == "80" then
        vim.o.statusline = "matched mouse | Count: " .. M.counter
        vim.api.nvim_command('redrawstatus')
        return
    end

    -- Inserisci il tasto nella sequenza e mantieni solo gli ultimi 4 tasti
    table.insert(M.keySequence, key)
    if #M.keySequence > 4 then
        table.remove(M.keySequence, 1)
    end

    -- Controlla se la sequenza corrisponde a una delle sequenze target
    if M.check_sequence() then
        M.counter = M.counter + 500
        vim.o.statusline = "key combo +500! Count: " .. M.counter
        M.keySequence = {}  -- Resetta la sequenza dopo una corrispondenza
    else
        M.counter = M.counter + 1
        vim.o.statusline = string.format("Key pressed: %s | Count: %d", key, M.counter)
    end
    vim.api.nvim_command('redrawstatus')
end

-- Funzione per confrontare la sequenza corrente con tutte le sequenze target
function M.check_sequence()
    for name, sequence in pairs(M.targetSequences) do
        if M.compareSequences(M.keySequence, sequence) then
            return true
        end
    end
    return false
end

-- Funzione per confrontare due sequenze
function M.compareSequences(keySequence, targetSequence)
    if not keySequence or not targetSequence then
        return false
    end

    for i, v in ipairs(targetSequence) do
        if keySequence[i] ~= v then
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
