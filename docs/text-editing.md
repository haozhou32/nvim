# Neovim Text Editing Guide 

This guide covers the essential keybindings and workflows for writing documents in Neovim using the `haozhou32/nvim` configuration. 

**Important Defaults:**
* **`<leader>` key:** `<Space>`
* **`<localleader>` key:** `\` (Backslash)

---

## 1. General Text Editing Utilities
Before diving into specific languages, here are some universal commands that make editing text easier across all file types.

### Window and Buffer Management
* **Window Navigation:** `<Ctrl-h>` / `<Ctrl-j>` / `<Ctrl-k>` / `<Ctrl-l>` (Left, Down, Up, Right)
* **Buffer Navigation:** `<Ctrl-n>` (Next buffer) / `<Ctrl-p>` (Previous buffer)
* **Close Buffer:** `<Ctrl-q>`

### Spell Checking
The default spell checker is highly useful for text documents:
* `zs`: Toggle the spell checker on/off in the current buffer
* `z=`: Open a list of spelling suggestions for the current word
* `]s` / `[s`: Jump to the next / previous misspelled word
* `zg` / `zw`: Mark a word as "good" (correct) or "wrong"
* `zug` / `zuw`: Undo marking a word as good or wrong

### Snippets (LuaSnip) & Auto-completion
* **Bold Text:** Highlight text in visual mode (`x`) and press `` ` `` then `tbf` to wrap the selection in bold formatting.
* **Snippet Node Navigation:** In insert mode (`i`), use `<Ctrl-j>` and `<Ctrl-k>` to cycle through snippet choice nodes.
* **Auto-completion (cmp):** Use `<Tab>`/`<S-Tab>` to navigate suggestions, `<CR>` (Enter) to expand a snippet or confirm a completion and `<Esc>` to close the completion list.

### Finding Files and Text (Telescope)
If you are working on a large document or multiple chapters, finding your way around is handled by Telescope:
* **`<leader>sf`**: Search for files
* **`<leader>sg`**: Search by grep (search the exact text inside all files)
* **`<leader>/`**: Fuzzy search inside the current buffer

---

## 2. Writing LaTeX (`vimtex`)
LaTeX support is powered by `vimtex`. Use your `<localleader>` (`\`) to trigger these LaTeX-specific commands.

### Compiling & Previewing
* **`\ll`** : Start compiling the document in continuous mode (updates automatically as you save).
* **`\lk`** : Stop compiling.
* **`\lv`** : Forward search (jumps from your cursor in Neovim to the corresponding spot in the PDF viewer).
* **`\lx`** : Clean auxiliary files (must stop compiling first).

### Inverse Search (PDF to Neovim)
If you want to click on the PDF and jump to the corresponding code in Neovim:
* **Zathura:** `<Ctrl> + Click`
* **Sioyek:** `<RightClick>`
* **Skim (macOS):** `<Shift> + <Cmd> + Click` *(Note: requires configuring Skim's sync support via `Settings > Sync > PDF-Tex Sync Support`. Then set the `Preset` field to `Custom`, the `command` field to `nvim`, and the `Arguments` field to `--headless -c "VimtexInverseSearch %line '$file'"`)*

### Navigation within LaTeX
* **`]]` / `[[`** : Jump to the next / beginning of the current section 
* **`]m` / `[m`** : Jump to the next / previous environment 
* **`]n` / `[n`** : Jump to the next / previous math zone 
* **`]r` / `[r`** : Jump to the next / previous frame (useful for Beamer presentations) 
* **`\lw`** : Count words in your document
* **`\lt`** : Open the Table of Contents

---

## 3. Writing Markdown (`obsidian.nvim`)
Markdown functionality in this configuration is heavily integrated with Obsidian, turning Neovim into a Zettelkasten/PKM system.

### Note Management
* **`<leader>on`** : Create a new note
* **`<leader>of`** : Find a file in the current Obsidian vault
* **`<leader>ot`** : List all notes associated with a specific tag

### Linking
* **`<leader>ol`** : List all links in the current note
* **`<leader>ob`** : List all backlinks (notes that link to the current note)

### Pasting Images
* **`<leader>op`** : Paste an image directly from your clipboard into the Markdown document. 
  * *macOS users must run `brew install pngpaste` for this to work.*

---

## 4. Writing Typst
Typst is a modern, fast alternative to LaTeX. The keybindings for Typst parallel the compilation workflow of LaTeX.

* **`<leader>tw`** : Start Typst Watch (compiles the document continuously as you edit)
* **`<leader>tp`** : Open Typst Preview
* **`<leader>ts`** : Open Typst Slides Preview (optimized for presentations)


