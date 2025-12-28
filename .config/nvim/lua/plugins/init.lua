-- Create a table to hold all plugin specs
local plugins = {}

-- Get list of all Lua files in this folder
local plugin_files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/plugins", "*.lua", false, true)

for _, file in ipairs(plugin_files) do
  -- Skip init.lua itself
  if not file:match("init%.lua$") then
    -- Convert full path to module name
    local module = file
      :gsub(vim.fn.stdpath("config") .. "/lua/", "")  -- remove base path
      :gsub("%.lua$", "")                              -- remove .lua extension
      :gsub("/", ".")                                  -- convert / to .
    
    local ok, plugin = pcall(require, module)
    if ok then
      table.insert(plugins, plugin)
    else
      vim.notify("Failed to load plugin: " .. module, vim.log.levels.ERROR)
    end
  end
end

return plugins
