local dap_status, dap = pcall(require, 'dap')
if not dap_status then return end

local dapui_status, dapui = pcall(require, 'dapui')
if (not dapui_status) then return end

vim.keymap.set("n", "<leader>dc", function() dap.continue() end, {})
vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, {})
vim.keymap.set("n", "<leader>dn", function() dap.step_over() end, {})
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, {})
vim.keymap.set("n", "<leader>do", function() dap.step_out() end, {})
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, {})
vim.keymap.set("n", "<leader>B", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, {})
vim.keymap.set("n", "<leader>lp", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, {})
vim.keymap.set("n", "<leader>dr", function() dap.repl.toggle() end, {})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end


dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = { os.getenv('XDG_DATA_HOME') .. '$XDG_DATA_HOME/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' }
}

dap.adapters.python = {
    type = 'executable',
    command = { os.getenv('POETRY_HOME') },
    args = { '-m', 'debugpy.adapter' }
}

require('dap-python').setup('$XDG_DATA_HOME/nvim/.virtualenvs/debugpy/bin/python')
require('dap-python').test_runner = 'pytest'
require("nvim-dap-virtual-text").setup({})

dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch';
        name = "Launch file";

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}"; -- This configuration will launch the current file if used.
        pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python3') == 1 then
                return cwd .. '/venv/bin/python3'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python3') == 1 then
                return cwd .. '/.venv/bin/python3'
            else
                return '/usr/bin/python3'
            end
        end
    },
}

dap.configurations.javascript = {
    {
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
    },
    {
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = 'Attach to process',
        type = 'node2',
        request = 'attach',
        processId = require 'dap.utils'.pick_process,
    },
}
