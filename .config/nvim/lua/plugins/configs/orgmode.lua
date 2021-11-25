local present, orgmode = pcall(require, "orgmode")
if not present then
    return
end

local parser_config = require("treesitter-parsers").get_parser_configs()
parser_config.org = {
    install_info = {
        url = "https://github.com/milisims/tree-sitter-org",
        revision = "main",
        files = {"src/parser.c", "src/scanner.cc"}
    },
    filetype = "org"
}

orgmode.setup(
    {
        org_agenda_files = {"~/Dropbox/org/*"},
        org_default_notes_file = "~/Dropbox/org/refile.org"
    }
)
