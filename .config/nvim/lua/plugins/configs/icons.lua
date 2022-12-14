local present, icons = pcall(require, "nvim-web-devicons")
if not present then
    return
end

icons.setup {
    override = {
        html = {
            icon = "",
            name = "html"
        },
        css = {
            icon = "",
            name = "css"
        },
        js = {
            icon = "",
            name = "js"
        },
        ts = {
            icon = "ﯤ",
            name = "ts"
        },
        png = {
            icon = "",
            name = "png"
        },
        jpg = {
            icon = "",
            name = "jpg"
        },
        jpeg = {
            icon = "",
            name = "jpeg"
        },
        mp3 = {
            icon = "",
            name = "mp3"
        },
        mp4 = {
            icon = "",
            name = "mp4"
        },
        out = {
            icon = "",
            name = "out"
        },
        Dockerfile = {
            icon = "",
            name = "Dockerfile"
        },
        rb = {
            icon = "",
            name = "rb"
        },
        vue = {
            icon = "﵂",
            name = "vue"
        },
        py = {
            icon = "",
            name = "py"
        },
        toml = {
            icon = "",
            name = "toml"
        },
        lock = {
            icon = "",
            name = "lock"
        },
        zip = {
            icon = "",
            name = "zip"
        },
        xz = {
            icon = "",
            name = "xz"
        },
        lua = {
            icon = "",
            name = "lua"
        },
        xlsx = {
          icon = "",
          name = "excel"
        },
        csv = {
          icon = "",
          name = "csv"
        },
        ipynb = {
          icon = "",
          name = "ipynb"
        },
        md = {
          icon = "",
          name = "markdown"
        }
    }
}
