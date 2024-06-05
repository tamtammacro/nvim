local exports = {}

function exports.deepcopy(o, seen)
    seen = seen or {}
    if o == nil then return nil end
    if seen[o] then return seen[o] end

    local no
    if type(o) == 'table' then
    no = {}
    seen[o] = no

    for k, v in next, o, nil do
      no[exports.deepcopy(k, seen)] = exports.deepcopy(v, seen)
    end
    setmetatable(no, exports.deepcopy(getmetatable(o), seen))
    else -- number, string, boolean, etc
    no = o
    end
    return no
end

return exports
