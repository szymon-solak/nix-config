local status_ok, tabby = pcall(require, "tabby.tabline")
if not status_ok then
	return
end

local theme = {
	fill = 'TabLineFill',
	head = 'TabLine',
	current_tab = 'TabLineSel',
	tab = 'TabLine',
	win = 'TabLine',
	tail = 'TabLine',
}

tabby.set(function(line)
  return {
    {
      { '  ', hl = theme.head },
      -- line.sep('', theme.head, theme.fill),
      line.sep('', theme.head, theme.fill),
    },
    line.tabs().foreach(function(tab)
      local hl = tab.is_current() and theme.current_tab or theme.tab
      return {
        -- line.sep('', hl, theme.fill),
        line.sep('', hl, theme.fill),
        tab.is_current() and '' or '󰆣',
        tab.number(),
        tab.name(),
        tab.close_btn(''),
        -- line.sep('', hl, theme.fill),
        line.sep('', hl, theme.fill),
        hl = hl,
        margin = ' ',
      }
    end),
    line.spacer(),
    line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
      return {
        -- line.sep('', theme.win, theme.fill),
        line.sep('', theme.win, theme.fill),
        win.is_current() and '' or '',
        win.buf_name(),
        -- line.sep('', theme.win, theme.fill),
        line.sep('', theme.win, theme.fill),
        hl = theme.win,
        margin = ' ',
      }
    end),
    {
      -- line.sep('', theme.tail, theme.fill),
    },
    hl = theme.fill,
  }
end)

-- tabby.use_preset('active_wins_at_tail', {
-- 	theme,
-- })
