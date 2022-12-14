local pass,err = pcall(require, "core")

if not pass then
     error("Error loading core configuration" .. "\n\n" .. err)
end

-- Usage -> :lua=extAtCursor()
function extAtCursor()
    local namespaces = vim.api.nvim_get_namespaces()
    local i = vim.fn.line('.')
    local j = vim.fn.col('.')
    local hl_groups = {}
    for _, ns_id in pairs(namespaces) do
        local extmarks = vim.api.nvim_buf_get_extmarks(0, ns_id, 
            { i - 1, j - 1 }, { i, j }, { details = 1 })
        for _, extmark in pairs(extmarks) do
            hl_groups[#hl_groups + 1] = extmark[4].hl_group
        end
    end
    return hl_groups
end
