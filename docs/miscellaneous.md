# Miscellaneous

`<leader> = <space>`


## 1. Diagnostic Location List

These shortcuts use the window-local location list, not Vim's global Quickfix list:

*   **`<leader>oq` (Open diagnostics):**
    This opens the current buffer's diagnostics in the location-list window at the bottom of your screen.
*   **Navigating the List:**
    Move up and down using `j` and `k`. Press `<Enter>` on an entry to jump to that diagnostic in your document.
*   **`:ll` (Current Diagnostic):**
    Jump to the current location-list entry and display its diagnostic message. For a separate global Quickfix list, use `:cc` instead.
*   **`<leader>cq` (Close diagnostics):**
    This closes the location-list window.

---


## 2. The Magic of `gf`: "Go to File"

In Vim, **`gf`** stands for **"Go to File"**. 

Imagine you are reading through your main `paper.tex` file, and you see a line like this:
`\input{sections/appendix.tex}`

In a normal editor, if you want to edit the appendix, you have to take your hands off the keyboard, grab your mouse, navigate to your file explorer, open the `sections` folder, and click on `appendix.tex`.

In Neovim, you simply move your cursor anywhere over the text `sections/appendix.tex` and type:
**`gf`**

Instantly, Neovim will open `appendix.tex` right in front of you. 

### Why this is a Superpower for Academics
*   **LaTeX modularity:** If you write long papers or books by breaking them up into smaller files (using `\input{}`, `\include{}`, or referencing a `references.bib` file), `gf` allows you to seamlessly "dive into" those files without ever touching a mouse.
*   **Markdown linking:** If you take notes in Markdown and have a link to another note like `[Read my proof here](proof_details.md)`, putting your cursor on `proof_details.md` and pressing `gf` will immediately open that note.
*   **Python imports:** If you are looking at a line of Python code like `import my_data_script` (provided the file `my_data_script.py` is in the same folder), `gf` will often jump straight into that script so you can see how the functions are written.

---


## 3. Make comments
| Key | Action                             | Mode |
|-----|------------------------------------|------|
| `gc`  | comment and uncomment a code block | x    |
| `gcc` | comment and uncomment a line       | n    |



## 4. Auto_formatter 
| Key         | Action              | Mode                           |
|-------------|---------------------|--------------------------------|
| `<leader>f`   | auto formatting     | n                              |

- Currently, it only supports `lua` and `python`. You can add more formatter at conform.lua.


## 5. Installing lsp and other tools by mason
- put the lsp under the table of the variable `servers`
- put other tools (e.g. formatters) under the table of mason-tool-installer.
- re-open nvim and all the tools will be installed automatically.
- :Mason to check the status of the tools.


## 6. PDF viewers

VimTeX selects the PDF viewer automatically:

- **macOS:** Sioyek, using VimTeX's native viewer integration.
- **Linux:** Zathura, using VimTeX's native viewer integration.
- **OrbStack Linux:** the macOS Sioyek app, launched with `mac open -a sioyek`. OrbStack translates shared macOS paths and Linux VM paths for the host app. This opens PDFs only; cross-OS SyncTeX forward/inverse search is not configured. If the `mac` bridge is unavailable, the configuration falls back to Zathura.

## 7. Chinese input supports
- [Require additonal commandline tools](https://github.com/keaising/im-select.nvim?tab=readme-ov-file)
- These commandline tools (im-select/macism) ensure that the input method is English.
- For editing LaTeX files, choose ChineseArticle.tex or ChineseBeamer.tex as the template. They contain the magic comments:"%!TEX program = xelatex" and "%!TEX view = sioyek". The second one is not essential and one should delete it if the OS doesn't have sioyek been installed.


