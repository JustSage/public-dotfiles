local present1, lspconfig = pcall(require, "lspconfig")
local present2, lspinstall = pcall(require, "lspinstall")
if not (present1 or present2) then
    return
end

local function on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = {noremap = true, silent = true}

    local function buf_set_keymap(...) 
        vim.api.nvim_buf_set_keymap(bufnr, ...) 
    end

    -- Mappings.
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "[d", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<Space>e", "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "<Space>q", "<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    buf_set_keymap("n", "<Space>wa", "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<Space>wr", "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<Space>wl", "<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<Space>D", "<Cmd>lua vim.lsp.buf.type_defiition()<CR>", opts)
    buf_set_keymap("n", "<Space>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<Space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<Space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- lspInstall + lspconfig stuff

local function setup_servers()
    lspinstall.setup()
    local servers = lspinstall.installed_servers()

    for _, lang in pairs(servers) do
        if lang ~= "lua" then
            lspconfig[lang].setup {
                on_attach = on_attach,
                capabilities = capabilities,
                root_dir = vim.loop.cwd
            }
        elseif lang == "lua" then
            lspconfig[lang].setup {
                root_dir = vim.loop.cwd,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {"vim"}
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                            },
                            maxPreload = 100000,
                            preloadFileSize = 10000
                        },
                        telemetry = {
                            enable = false
                        }
                    }
                }
            }
        end
    end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lspinstall.post_install_hook = function()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- triggers FileType autocmd that starts the server
end

-- replace the default lsp diagnostic symbols
function LspSymbol(name, icon)
    vim.fn.sign_define("LspDiagnosticsSign" .. name, {text = icon, numhl = "LspDiagnosticsDefaul" .. name})
end

LspSymbol("Error", "")
LspSymbol("Warning", "")
LspSymbol("Information", "")
LspSymbol("Hint", "")

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = {
            prefix = "",
            spacing = 0
        },
        signs = true,
        underline = true,

        -- set this to true if you want diagnostics to show in insert mode
        update_in_insert = false
    }
)

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
    if msg:match("exit code") then
        return
    end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
        vim.api.nvim_echo({{msg}}, true, {})
    end
end

-- specific language server settings
-- c/c++ lsp
lspconfig.ccls.setup {
   init_options = {
       compilationDatabaseDirectory = "build",
       index = {
           threads = 0
       },
       clang = {
           excludeArgs = {"-frounding-math"}
       }
   }
}

local configs = require'lspconfig/configs'

if not lspconfig.emmet_ls then
  configs.emmet_ls = {
    default_config = {
      cmd = {'emmet-ls', '--stdio'};
      filetypes = {'html', 'css'};
      root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd())
    };
  }
end

lspconfig.emmet_ls.setup{
    on_attach = on_attach;
    capabilities = capabilities;
}
