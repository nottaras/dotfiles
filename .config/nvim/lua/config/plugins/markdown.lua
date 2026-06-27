return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        ft = { "markdown" },
        opts = {},
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = { markdown = { "markdownlint-cli2" } }

            local md = lint.linters["markdownlint-cli2"]
            md.stdin = true
            md.args = { "--config", vim.fn.expand("~/.markdownlint.json"), "-" }

            vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
                callback = function() lint.try_lint() end,
            })
        end,
    },
}