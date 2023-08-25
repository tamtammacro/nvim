local strings = {}

function strings.capitilize_word(str,can_uncap)
    if not str then print "invalid input" end
    if not can_uncap then return str:sub(1,1):upper()..str:sub(2,#str):lower() end
    local first_char = str:sub(1,1)
    if first_char:match("%u") ~= nil then first_char = first_char:lower() else first_char = first_char:upper() end

    return first_char..str:sub(2,#str):lower()
end

local function get_char_at(str,index)
    return str:sub(index,index)
end

local function get_char_left_of(str,index)
    return str:sub(index-1,index-1)
end

local function get_char_right_of(str,index)
    return str:sub(index+1,index+1)
end

local function is_entire_word(str,index)
    local char_left = get_char_left_of(str,index)

    return char_left == " " and char_left:match("%p")
end

function strings.get_partial_word_by_index(str,index)
    if not str then return print "invalid input" end

    return str:sub(index,#str):gmatch("%w+")()
end

function strings.get_word_by_index(str,index)
    if not str then return end

    local curr_index = index - 1

    if get_char_at(str,index):match("%p") then return end

    if not is_entire_word(str,index) then
        local b_w = ""
        local char
        local attempts = 0

        while attempts < 69 do
            attempts = attempts + 1
            char = str:sub(curr_index,curr_index)

            if char == " " or curr_index < 1 then break end

            if not char:match"^%p" then
                b_w = b_w..char
                curr_index = curr_index - 1
            end
        end

        return b_w:reverse()..strings.get_partial_word_by_index(str,index)
    end

    return strings.get_partial_word_by_index(str,index)
end

return strings
