local Lexer = {}

local Token = require "helper.token"

function Lexer.new(source)
    if type(source) ~= "string" then return end

    return setmetatable({
       source = source,
       tokens = {},
       cursor = 0,
       source_len = #source,
       should_exit = false,
    },{__index = Lexer})
end

function Lexer:advance()
    if self.cursor <= self.source_len then
        self.cursor = self.cursor + 1
        self.curr_char = self.source:sub(self.cursor,self.cursor)
    else
        self.should_exit = true
    end
end

function Lexer:make_number()
    local number = ""

    while not self.should_exit do
        if not tonumber(self.curr_char) then break end
        number = number..self.curr_char
        self:advance()
    end

    if #number > 0 then
        local token = Token.new()
        token.type = Token.NUMBER
        token.value = number
        table.insert(self.tokens,Token.new(Token.NUMBER,number))
    end
end

function Lexer:make_name()
    if tonumber(self.curr_char) or self.curr_char == "" then
        return self:advance()
    end
    
    local name = ""

    while not self.should_exit and self.curr_char ~= "" and self.curr_char ~= " " do
        name = name..self.curr_char
        self:advance()
    end

    if #name > 0 then
        table.insert(self.tokens,Token.new(Token.NAME,name))
    end
end

function Lexer:make_tokens()
    self:advance()

    while not self.should_exit do
        if tonumber(self.curr_char) then
            self:make_number()
        elseif self.curr_char ~= "" then
            self:make_name()
        end
        self:advance()
    end
end

return Lexer
