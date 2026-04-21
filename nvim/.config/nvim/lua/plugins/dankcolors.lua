return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#111414',
				base01 = '#111414',
				base02 = '#818b8c',
				base03 = '#818b8c',
				base04 = '#d5e1e2',
				base05 = '#f8feff',
				base06 = '#f8feff',
				base07 = '#f8feff',
				base08 = '#ff9fc0',
				base09 = '#ff9fc0',
				base0A = '#aee7ed',
				base0B = '#a5ffae',
				base0C = '#dbfbff',
				base0D = '#aee7ed',
				base0E = '#c7f9ff',
				base0F = '#c7f9ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#818b8c',
				fg = '#f8feff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#aee7ed',
				fg = '#111414',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#818b8c' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#dbfbff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#c7f9ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#aee7ed',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#aee7ed',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#dbfbff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffae',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#d5e1e2' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#d5e1e2' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#818b8c',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
