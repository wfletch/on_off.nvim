
# On Off

For those who hate toggling bools 
---

## ✨ Features

- If False, Make True
- If True, Make False
- ... for as many pairs as possible
---

## 📦 Requirements

- Neovim 0.9+

---

## 🔧 Installation (Lazy.nvim)

### From GitHub

```lua
return {
    "wfletch/on_off.nvim",
        keys = {
            {
                "<leader>tt",
                function()
                    require("on_off").ToggleBooleanOnLine()
                    end,
                desc = "Toggle boolean on line",
            },
        },
}
