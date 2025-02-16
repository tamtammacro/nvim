xpcall(function()
    local wk = require("which-key")

    if not wk.add then return print("INFO: which-key 'add' function is missing") end

    wk.add({"<Space>f",group = "Find"}) 
    wk.add({"<Space>fs",group = "Symbol"}) 

    wk.add({"<Space>k",group = "Document"}) 
    wk.add({"<Space>h",group = "Harpoon"}) 
    wk.add({"<Space>r",group = "Refactor"}) 
    wk.add({"<Space>d",group = "Debug"}) 
end, print)
