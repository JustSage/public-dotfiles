local present, impatient = pcall(require, "impatient")

if not present then
	return
end

impatient.enable_profile()
require("plugins.packer_compiled")
