vim.schedule(function()
	vim.pack.add({
		"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	})
	require("render-markdown").setup({
		-- Pre configured settings that will attempt to mimic various target user experiences.
		-- User provided settings will take precedence.
		-- | obsidian | mimic Obsidian UI                                          |
		-- | lazy     | will attempt to stay up to date with LazyVim configuration |
		-- | none     | does nothing                                               |
		preset = "lazy",
		-- Filetypes this plugin will run on.
		file_types = { "markdown" },
		completions = {
			-- Settings for blink.cmp completions source
			blink = { enabled = true },
		},
	})
end)
