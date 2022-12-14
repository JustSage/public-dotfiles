local present, null_ls = pcall(require, "null-ls")

if not present then
    return
end

local builtins = null_ls.builtins

local sources = {
    -- JS html css stuff
    builtins.formatting.prettier.with {
        filetypes = { "html", "json", "markdown", "css", "javascript", "javascriptreact" }
    },

    builtins.diagnostics.eslint_d.with {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        command = "eslint_d",
        args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" }
    },

   -- -- python
   builtins.diagnostics.flake8.with {
       filetypes = { "python" },
       command = "flake8",
       args = { "--stdin-display-name", "$FILENAME", "-" }
   },

   builtins.formatting.black.with {
       filetypes = { "python" },
       command = "black",
       args = { "--quiet", "--fast", "-" }
   },

   -- -- c/cpp formatter
   builtins.formatting.clang_format.with {
       filetypes = { "c", "cpp", "cs"},
       command = "clang-format"
   },

   -- -- Java
   builtins.formatting.google_java_format.with {
     filetypes = { "java" },
     extra_args = { "--aosp" }
   },

   builtins.formatting.json_tool.with {
    filetypes = { "json" },
    command = "python",
    args = { "-m", "json.tool" }
   },

   -- Lua
   builtins.formatting.stylua.with {
       filetypes = { "lua" },
   },

   -- -- Shell
   builtins.formatting.shfmt,
   builtins.diagnostics.shellcheck.with {
       diagnostics_format = "#{m} [#{c}]"
   },
}

local M = {}
M.setup = function(on_attach)
    null_ls.config {
        sources = sources,
    }
    require("lspconfig")["null-ls"].setup { on_attach = on_attach }
end
return M

