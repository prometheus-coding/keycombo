local M = {}

M.counter = 0
M.keySequence = {}
M.targetSequence = {'g', 'g', 'V', 'G'}

function M.setup()
    vim.on_key(function(key)
        local key_char = vim.api.nvim_replace_termcodes(key, true, false, true)
        M.show_key(key_char)
    end)
end

function M.show_key(key)
    table.insert(M.keySequence, key)
    if #M.keySequence > 4 then
        table.remove(M.keySequence, 1)  -- Keep only the last 4 keys pressed
    end

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











return M
