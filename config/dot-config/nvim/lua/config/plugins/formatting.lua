return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = {
            formatters = {
                ["markdownlint-cli2"] = {
                    prepend_args = { "--config", vim.fn.expand("~/.markdownlint.json") },
                },
                trim_blanks = {
                    command = "awk",
                    stdin = true,
                    args = { "-f", vim.fs.joinpath(vim.fn.stdpath("config"), "scripts", "trim-blanks.awk") },
                },
            },
            formatters_by_ft = {
                lua = { "stylua" },
                markdown = { "markdownlint-cli2", "trim_blanks" },
                json = { "prettier" },
                yaml = { "prettier" },
            },
            format_on_save = { timeout_ms = 500 },
        },
    },
}