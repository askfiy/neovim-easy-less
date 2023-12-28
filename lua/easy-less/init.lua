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
    generate_suffix = "css",
}

local command = "lessc"
local enable_tag = true

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
            if not enable_tag then
                return
            end
            local less_path = vim.fn.expand("%:p")
            local css_path = vim.fn.expand("%:p:h")
            local css_file = ("%s.%s"):format(
                vim.fn.expand("%:t:r"),
                default_config.generate_suffix
            )

            vim.fn.jobstart({
                command,
                less_path,
                table.concat(vim.tbl_flatten({ css_path, css_file }), "/"),
                "--no-color",
            }, {
                on_stdout = callback,
                on_stderr = callback,
            })
        end,
        desc = "Auto generate file in BufWritePost event",
    })

    vim.api.nvim_create_user_command("DisableEasyLess", function(ctx)
        enable_tag = false
    end, { desc = "Disable Easy Less auto generate file" })

    vim.api.nvim_create_user_command("EnableEasyLess", function(ctx)
        enable_tag = true
    end, { desc = "Enable Easy Less auto generate file" })

    vim.api.nvim_create_user_command("ToggleEasyLess", function(ctx)
        enable_tag = not enable_tag
    end, { desc = "Toggle Easy Less auto generate file" })
end

function M.set_output(suffix)
    default_config.generate_suffix = suffix
end

return M
