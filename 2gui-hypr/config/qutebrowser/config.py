c=c
config=config

import os
from urllib.request import urlopen

# load your autoconfig, use this, if the rest of your config is empty!
config.load_autoconfig()

if not os.path.exists(config.configdir / "theme.py"):
    theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
    with urlopen(theme) as themehtml:
        with open(config.configdir / "theme.py", "a") as file:
            file.writelines(themehtml.read().decode("utf-8"))

if os.path.exists(config.configdir / "theme.py"):
    import theme
    theme.setup(c, 'mocha', True)

# Key bindings
config.bind('10*', 'scroll up')
config.bind('H', 'tab-prev')
config.bind('J', 'scroll left')
config.bind('K', 'scroll right')
config.bind('L', 'tab-next')
config.bind('X', 'undo')
config.bind('d', 'cmd-run-with-count 15 scroll down')
config.bind('f', 'search . ;; selection-follow')
config.bind('gh', 'hint all hover')
config.unbind('h')
config.unbind('l')
config.bind('hh', 'back')
config.bind('ll', 'forward')

config.bind('s', 'hint all')
config.bind('S', 'hint all tab')
config.bind('f', 'nop')
config.bind('F', 'nop')

config.bind('u', 'cmd-run-with-count 15 scroll up')
config.bind('x', 'tab-close')

config.bind('<Space>uh', 'history')
config.bind('<Space>us', 'set')
config.bind('<Space>qq', 'home ;; tab-only ;; quit')
config.bind('<Space>wd', 'tab-close')
config.bind('<Space>un', 'clear-messages')

# Key mappings
# config.bind('<Ctrl-6>', '<Ctrl-^>')
# config.bind('<Ctrl-Enter>', '<Ctrl-Return>')
# config.bind('<Ctrl-I>', '<Tab>')
# config.bind('<Ctrl-J>', '<Return>')
# config.bind('<Ctrl-M>', '<Return>')
# config.bind('<Ctrl-[>', '<Escape>')
# config.bind('<Enter>', '<Return>')
# config.bind('<Shift-Enter>', '<Return>')
# config.bind('<Shift-Return>', '<Return>')

# Colors and appearance
config.set('colors.webpage.darkmode.enabled', True)
config.set('colors.webpage.preferred_color_scheme', 'dark')

# Editor command
config.set('editor.command', ['kitty', 'nvim', '-f', '{file}', '-c', 'normal {line}G{column0}l'])

# File select command
config.set('fileselect.folder.command', ['kitty', 'lf', '-selection-path={}'])

# Fonts
config.set('fonts.default_family', 'ProFont IIx Nerd Font Mono')
config.set('fonts.default_size', '14pt')
config.set('fonts.keyhint', '13pt default_family')
config.set('fonts.prompts', '20pt default_family')
# Hints
config.set('hints.chars', 'asdfghjkl')
# Scrolling
config.set('scrolling.smooth', True)
config.set('statusbar.show', 'in-mode')
config.set('tabs.title.alignment', 'center')

#color
c.tabs.max_width = 360
c.window.transparent = True

c.colors.tabs.selected.even.fg= '#a6e3a1'
c.colors.tabs.selected.odd.fg= '#a6e3a1'

c.colors.tabs.even.bg = "#00000000" # transparent tabs!!
c.colors.tabs.odd.bg = "#00000000"
c.colors.tabs.bar.bg = "#00000000"
# session
c.auto_save.session = True
c.session.default_name = "last"
c.session.lazy_restore = True
