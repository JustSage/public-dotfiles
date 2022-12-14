local modules = {
	"core.options",
	"core.mappings",
	"core.utils",
	"core.functions",
    "core.commands"
}

for _, module in ipairs(modules) do
	local pass, err = pcall(require, module)
	if not pass then
		error("Error loading " .. module .. "\n\n" .. err)
	end
end
