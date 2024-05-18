require "core.basic_config"
local plugin_opts = require "core.load_plugins" 

if plugin_opts:use_plugins() then
    plugin_opts:use_visuals()
end
