require'nvim-tree'.setup {
    update_focused_file = {
        update_cwd = false
    },
    filters = {
        custom = {
            '.git', 'node_modules', '.cache'
        }
    },
    renderer = {
        highlight_opened_files = "none",
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            }
        }
    },
    view = {
        width = 40,
    },
}
