require "basic_config"

local plugins_conf = require "core.load_plugins"
if not plugins_conf then return end

plugins_conf:use_plugins()
plugins_conf:use_visuals()
