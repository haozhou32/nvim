# Miscellaneous

`<leader> = <space>`


## 1. Quickfix

Here is how you interact with the Quickfix list in this configuration:

*   **`<leader>oq` (Open Quickfix):** 
    This opens the Quickfix window at the bottom of your screen. 
*   **Navigating the List:** 
    Once the window is open, you can move up and down using `j` and `k`. Press `<Enter>` on any line to jump straight to that error in your document.
*   **`:cc` (Current Error):** 
    Sometimes, a LaTeX compiler error or a Python traceback is too long to fit on a single line in the Quickfix window. If you want to see the complete, uncut message for the error your cursor is currently on, type `:cc` and press Enter. It will print the full error message at the bottom of your screen.
*   **`<leader>cq` (Close Quickfix):** 
    This safely closes the Quickfix window and gives you your screen space back once you have fixed your typos.

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


## 6. Chinese input supports
- [Require additonal commandline tools](https://github.com/keaising/im-select.nvim?tab=readme-ov-file)
- These commandline tools (im-select/macism) ensure that the input method is English.
- For editing LaTeX files, choose ChineseArticle.tex or ChineseBeamer.tex as the template. They contain the magic comments:"%!TEX program = xelatex" and "%!TEX view = sioyek". The second one is not essential and one should delete it if the OS doesn't have sioyek been installed.


