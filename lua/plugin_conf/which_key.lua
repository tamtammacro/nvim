xpcall(function()
    local wk = require("which-key")
    wk.add({"<Space>f",group = "Find"}) 
    wk.add({"<Space>fs",group = "Symbol"}) 

    wk.add({"<Space>k",group = "Document"}) 
    wk.add({"<Space>h",group = "Harpoon"}) 
    wk.add({"<Space>r",group = "Refactor"}) 
end, print)
