Here is a complete guide to using **Telescope** (a highly extendable fuzzy finder for Neovim) tailored exactly to this setup.

### 🔑 The Leader Key
First, it is important to know that in this configuration, the `<leader>` key is mapped to your **Spacebar** (`<space>`). All Telescope commands are accessed sequentially using the Spacebar. 

For example, `<leader>sf` means you type `Space` then `s` then `f`.

---

### 📂 File and Buffer Navigation
These shortcuts are your bread-and-butter for finding and switching between files.

*   **`<leader>sf` (Search Files):** Opens a prompt to search for any file within your current working directory.
*   **`<leader><leader>` (Search Existing Buffers):** Quickly switch between files you already have open. This is one of the fastest ways to jump back and forth between active documents.
*   **`<leader>s.` (Search Recent Files):** Searches through the history of files you have recently opened.
*   **`<leader>sn` (Search Neovim Config):** A dedicated shortcut to jump straight into your Neovim configuration files so you can quickly tweak your setup.

---

### 🔍 Text Searching (Grep)
Telescope allows you to search for specific text patterns across your files.

*   **`<leader>/` (Search Current Buffer):** Fuzzily search for text *only* inside the file you are currently looking at. 
*   **`<leader>sg` (Search by Grep):** Opens a live grep to search for a text string project-wide. As you type, it updates the matches instantly.
*   **`<leader>s/` (Search Live Grep in Open Files):** Similar to project-wide grep, but restricts the search only to the files you currently have open in Neovim buffers.
*   **`<leader>sw` (Search Current Word):** Automatically takes the word your cursor is currently hovering over and searches for it across your entire project.

---

### 🛠️ Help & Diagnostics
Use these commands to navigate Neovim's internal ecosystem and code issues.

*   **`<leader>sh` (Search Help):** Search through Neovim's built-in help documentation. This is extremely useful if you need to remember how a vim command works.
*   **`<leader>sk` (Search Keymaps):** Forgot a shortcut? Use this to pull up a fuzzy-searchable list of all currently active keybindings.
*   **`<leader>sd` (Search Diagnostics):** Lists all warnings, errors, and hints (provided by your active LSP) across your project so you can easily jump to and fix them.
*   **`<leader>ss` (Search Select Telescope):** Opens Telescope's built-in picker list, allowing you to search through all available Telescope commands and extensions.

---

### 🔄 Utility

*   **`<leader>sr` (Search Resume):** Accidentally closed a Telescope window before you found what you needed? Use this to immediately reopen your last search exactly as you left it.

---

### 💡 General Tips for Navigation 
To seamlessly maneuver through your workflow without constantly reopening Telescope, you can combine your custom buffer keymaps with Vim's powerful built-in jump list. In this specific configuration, **`<Ctrl-n>`** and **`<Ctrl-p>`** allow you to rapidly cycle next and previous through your currently open files (buffers), while **`<Ctrl-q>`** cleanly closes the active buffer when you no longer need it. Complementing this buffer management is your navigation "time machine": **`<Ctrl-o>`** (Jump Older) and **`<Ctrl-i>`** (Jump Newer). These built-in shortcuts instantly snap your cursor backward and forward through your historical jump points—even across different files. Together, these five shortcuts provide a lightning-fast way to cycle through active tasks, dive deep into a new file, and immediately trace your steps back to your exact starting position without breaking your flow.
