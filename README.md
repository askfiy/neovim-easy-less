                  _   _       _                 ______                       _
                 | \ | |     (_)               |  ____|                     | |
                 |  \| |_   ___ _ __ ___ ______| |__   __ _ ___ _   _ ______| |     ___  ___ ___
                 | . ` \ \ / / | '_ ` _ \______|  __| / _` / __| | | |______| |    / _ \/ __/ __|
                 | |\  |\ V /| | | | | | |     | |___| (_| \__ \ |_| |      | |___|  __/\__ \__ \
                 |_| \_| \_/ |_|_| |_| |_|     |______\__,_|___/\__, |      |______\___||___/___/
                                                                 __/ |
                                                                |___/

                           · automatically generate CSS files when writing less ·

![](https://img.shields.io/badge/Perfect-neovim%20easy%20less-green)

**Neovim Easy Less** is a simple Neovim plugin that facilitates the compilation of Less files to CSS using the `lessc` command. It streamlines the process of converting Less to CSS each time you save a Less file.

## Installation

1. **Install `lessc`**:

   Before using this plugin, ensure that you have `lessc` installed on your system. You can install it via npm with the following command:

   ```shell
   npm install -g less
   ```

2. **Install the plugin**

   It is recommended to use [lazy.nvim](https://github.com/folke/lazy.nvim) to install the plugin:

   ```lua
   {
     "askfiy/neovim-easy-less",
     ft = { "less" },
     config = function()
       require("easy-less").setup()
     end
   }
   ```

## Usage

The plugin will automatically compile Less to CSS when you save a .less file. You can customize the behavior with the following configuration option:

```lua
require("easy-less").setup({
    -- Is an error message displayed? Default false
    show_error_message = true,
})
```

## License

This plugin is licensed under the MIT License. See the [LICENSE](https://github.com/askfiy/neovim-easy-less/blob/master/LICENSE) file for details.

## Contributing

Contributions are welcome! If you encounter a bug or want to enhance this plugin, feel free to open an issue or create a pull request.
