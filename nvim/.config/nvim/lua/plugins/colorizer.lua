return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup({
            -- Enable for all file types
            "*",
            -- Customize which colors to highlight
            css = { rgb = true, rgba = true, hex = true },
        })
    end,
}
