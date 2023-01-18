local status, neotest = pcall(require, 'neotest')
if (not status) then return end

neotest.setup({
    adapters = {
        require("neotest-python")({
            runner = "pytest",
            dap = { justMyCode = false }
        }),
        require('neotest-jest')({
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
                return vim.fn.getcwd()
            end,
        })
    }
})
