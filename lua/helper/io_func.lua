local exports = {}

function exports.get_config_loc()
    return exports.is_win32() and vim.env.HOME .. "\\AppData\\Local\\nvim" or vim.env.HOME .. "/.config/nvim"
end

function exports.is_win32()
    return vim.loop.os_uname().sysname == "Windows_NT"
end

function exports.read_all_file(path)
    local file = io.open(path, "rb")

    if not file then return end

    local content = file:read("*all")

    file:close()

    return content
end

function exports.file_exists(file)
    local ok, err, code = os.rename(file, file)

    if not ok then
        return code == 13
    end

    return ok, err
end

function exports.isdir(path)
    return exports.file_exists(path .. "/")
end

function exports.mkdir(dirname)
    os.execute("mkdir " .. dirname)
end

function exports.read_file_lines(path)
    local file = io.open(path, "rb")

    if not file then return nil end

    local lines = {}

    for line in io.lines(path) do
        local words = {}

        for word in line:gmatch("%w+") do
            table.insert(words, word)
        end

        table.insert(lines, words)
    end

    file:close()

    return lines;
end

function exports.write_file(path,content)
    local file = io.open(path, "w")
    if not file then return print(string.format("Could not write file: %s does not exist",path)) end

    local status = file:write(content)
    file:close()

    return status
end

return exports
