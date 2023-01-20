local present, impatient = pcall(require, "impatient")
local compiled_path = vim.fn.stdpath("config") .. "/lua/plugin/packer_compiled.lua"

if not present then
	return
end

impatient.enable_profile()
require(compiled_path)
