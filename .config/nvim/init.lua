local pass, err = pcall(require, "core")

if not pass then
	error("Error loading core configuration" .. "\n\n" .. err)
end
