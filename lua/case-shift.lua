local M = {}

local function to_snake_case(str)
    local s = str:gsub("(%u)", "_%1"):lower()
    return s:sub(1,1) == "_" and s:sub(2) or s
end

local function to_camel_case(str)
    return str:gsub("_%l", function(letter) return letter:sub(2):upper() end)
end

local function to_kebab_case(str)
    return str:gsub("_", "-")
end

function M.toggle_case()
    -- カーソル下の単語を選択
    vim.api.nvim_command("normal! viw")

    local old_clipboard = vim.fn.getreg('"')
    local selected_text = vim.fn.getreg('"')
    
    if selected_text:match("_") then
        if selected_text:match("-") then
            selected_text = to_snake_case(selected_text)
        else
            selected_text = to_camel_case(selected_text)
        end
    elseif selected_text:match("%u") then
        selected_text = to_kebab_case(selected_text)
    else
        selected_text = to_snake_case(selected_text)
    end

    vim.api.nvim_command("normal! c" .. selected_text)
    vim.fn.setreg('"', old_clipboard)
end

return M

