local components = {
    active = {},
    inactive = {}
}
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active[1], {
    provider = function() 
        return " " .. require('feline.providers.vi_mode').get_vim_mode() .." "
    end,
    icon = '',
    hl = function()
        return {
            name = ' ' .. require('feline.providers.vi_mode').get_mode_highlight_name() .. ' ',
            bg = require('feline.providers.vi_mode').get_mode_color(),
            fg = 'snow3',
            style = 'bold'
        }
    end,
    padding = 'center',
    right_sep = ' ',
})
table.insert(components.active[1], {
    provider = {
        name = 'file_info',
        opts = {
            type = 'relative',
        },
    },
    hl = function() 
        return {
            fg = 'cyan',
        }
    end,
    right_sep = ' ',
})
table.insert(components.active[1], {
    provider = 'git_branch',
    hl = function () 
        return { 
        fg = 'snow2',
        bg = 'firebrick2'
        }
    end,
    left_sep = ' ',
    right_sep = ' '
})
table.insert(components.active[1], {
    provider = 'git_diff_changed',
})
table.insert(components.active[1], {
    provider = 'git_diff_added',
})
table.insert(components.active[1], {
    provider = 'git_diff_removed',
})

table.insert(components.active[2], {
    provider = 'file_type',
})
table.insert(components.active[2], {
    provider = '[',
})
table.insert(components.active[2], {
    provider = 'file_encoding',
})
table.insert(components.active[2], {
    provider = ']',
})

table.insert(components.active[3], {
    provider = 'position',
    padding = 'true',
    right_sep = 'vertical_bar'
})
table.insert(components.active[3], {
    provider = 'line_percentage',
})

table.insert(components.active[4], {
    provider = 'lsp_client_names',
})
table.insert(components.active[4], {
    provider = 'diagnostic_errors',
})
table.insert(components.active[4], {
    provider = 'diagnostic_warnings',
})
table.insert(components.active[4], {
    provider = 'diagnostic_hints',
})
table.insert(components.active[4], {
    provider = 'diagnostic_info',
})

require('feline').setup({
    components = components,
    vi_mode_colors = {
        NORMAL = 'OliveDrab',
        OP = 'OliveDrab',
        INSERT = 'DarkGoldenrod3',
        VISUAL = 'skyblue',
        LINES = 'skyblue',
        BLOCK = 'skyblue',
        REPLACE = 'violet',
        ['V-REPLACE'] = 'violet',
        ENTER = 'cyan',
        MORE = 'cyan',
        SELECT = 'goldenrod2',
        COMMAND = 'OliveDrab',
        SHELL = 'OliveDrab',
        TERM = 'OliveDrab',
        NONE = 'yellow',
    }
})
