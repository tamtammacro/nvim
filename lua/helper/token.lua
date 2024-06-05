local Token = {}

Token.NUMBER = 1
Token.STRING = 2
Token.BOOLEAN = 3
Token.NAME = 4

function Token:tostring()
    if self.type == Token.STRING then
        return "STRING"
    elseif self.type == Token.NAME then
        return "NAME"
    elseif self.type == Token.NUMBER then
        return "NUMBER"
    elseif self.type == Token.BOOLEAN then
        return "BOOLEAN"
    end
end

function Token.new(token_type,value)
    return setmetatable({type = token_type,value = value},{
        __index = Token,
        __tostring = function(self)
            return string.format("Token { type: %s | value: %s }",self:tostring(),self.value)
        end
    })
end

return Token
