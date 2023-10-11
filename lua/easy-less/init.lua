-- author: askfiy
-- date: 2023-10-11
-- name: neovim-easy-less
-- description: A simple Neovim plugin for compiling Less to CSS using the lessc command.
-- repository: https://github.com/askfiy/neovim-easy-less
-- license: MIT

--[[
    This is a simple less compilation CSS tool
    It relies on external lessc commands throughout, so you'll need to install less via npm
]]

local M = {}

local default_config = {
    show_error_message = false,
}

local command = "lessc"

local function callback(job_id, data, event)
    local msg = data[1]
    if "stderr" == event then
        if default_config.show_error_message then
            vim.api.nvim_echo({ { msg, "ErrorMsg" } }, true, {})
        else
        end
    elseif "stdout" == event then
        vim.api.nvim_echo({ { msg, "MoreMsg" } }, true, {})
    end
end

function M.setup(conf)
    if vim.fn.executable(command) ~= 1 then
        vim.api.nvim_echo({
            {
                "Missing lessc command, Please `npm install -g less`",
                "ErrorMsg",
            },
        }, true, {})
        return
    end

    default_config = vim.tbl_extend("force", default_config, conf or {})

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        pattern = { "*.less" },
        callback = function()
            local current_less_file = vim.fn.expand("%:t")
            local target_css_file = ("%s.css"):format(vim.fn.expand("%:t:r"))

            vim.fn.jobstart(
                { command, current_less_file, target_css_file, "--no-color" },
                {
                    on_stdout = callback,
                    on_stderr = callback,
                }
            )
        end,
    })
end

return M
