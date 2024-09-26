local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
    require "plugin_collection.functionality_plugins",
    require "plugin_collection.color_scheme_plugins",
    require "plugin_collection.lsp_plugins",
    require "plugin_collection.visual_plugins",
    require "plugin_collection.file_manager_plugins",
    require "plugin_collection.tree_sitter_plugins",
    require "plugin_collection.telescope_plugins",
    require "plugin_collection.git_integration_plugins",
}

local opts = {}

require("lazy").setup(plugins, opts)
