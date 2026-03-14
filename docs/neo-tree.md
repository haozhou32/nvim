Here is the complete table of **Neo-tree’s keybindings**, organized by category. 

> **Note on my custom config:** In the configuration I changed three keys: `<space>` (disabled), `l` (open), and `h` (close node). The tables below reflect Neo-tree's **official defaults**, but I have added notes where my custom bindings apply!

### 📂 Navigation & Opening Files
| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `<CR>` | `open` | Open file or toggle directory |
| `S` | `open_split` | Open file in a **horizontal** split |
| `s` | `open_vsplit` | Open file in a **vertical** split |
| `t` | `open_tabnew` | Open file in a **new tab** |
| `w` | `open_with_window_picker` | Select which window to open the file in |
| `<BS>` | `navigate_up` | Go up to the **parent** directory |
| `.` | `set_root` | Make the hovered directory the new tree root |
| `<space>` | `toggle_node` | Toggle directory open/closed *(We disabled this in my config)* |
| `l` | `focus_preview` | Focus preview window *(We mapped this to `open` in my config)* |
| `h` | *(vim default)* | Move left *(We mapped this to `close_node` in my config)* |


### 📝 File System Operations
| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `a` | `add` | Create a new file (type `folder/` to create a directory) |
| `A` | `add_directory` | Create a new directory |
| `d` | `delete` | Delete file or directory (prompts for confirmation) |
| `r` | `rename` | Rename file or directory |
| `y` | `copy_to_clipboard` | Copy the file to Neo-tree's internal clipboard |
| `x` | `cut_to_clipboard` | Cut the file to Neo-tree's internal clipboard |
| `p` | `paste_from_clipboard` | Paste the copied/cut file into the current directory |
| `c` | `copy` | Copy file to a specific destination (prompts for path) |
| `m` | `move` | Move file to a specific destination (prompts for path) |


### 🔍 Filtering, Searching & Sorting
| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `/` | `fuzzy_finder` | Filter/search files in the tree |
| `D` | `fuzzy_finder_directory` | Filter/search for directories only |
| `#` | `fuzzy_sorter` | Fuzzy sort the current directory |
| `f` | `filter_on_submit` | Apply the current filter |
| `<C-x>` | `clear_filter` | Clear the active filter/search |
| `H` | `toggle_hidden` | Toggle visibility of hidden files (`.dotfiles`) |
| `on` | `order_by_name` | Sort the tree by name |
| `os` | `order_by_size` | Sort the tree by file size |
| `ot` | `order_by_type` | Sort the tree by file type |
| `om` | `order_by_modified` | Sort the tree by last modified date |
| `oc` | `order_by_created` | Sort the tree by creation date |
| `od` | `order_by_diagnostics`| Sort the tree by LSP diagnostic errors/warnings |
| `og` | `order_by_git_status` | Sort the tree by Git status |


### 🌳 Tree Manipulation & Windows
| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `q` | `close_window` | Close the Neo-tree sidebar |
| `R` | `refresh` | Refresh the tree (useful if files changed outside Neovim) |
| `C` | `close_node` | Close the current expanded directory |
| `z` | `close_all_nodes` | Close all expanded directories at once |
| `<` | `prev_source` | Switch to the previous Neo-tree source (e.g., Buffers) |
| `>` | `next_source` | Switch to the next Neo-tree source (e.g., Git Status) |


### 👁️ Preview Mode & Information
| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `P` | `toggle_preview` | Open a floating preview window of the hovered file |
| `i` | `show_file_details` | Show file details (size, created time, modified time) |
| `?` | `show_help` | **Open the help menu showing all of these mappings** |


### 🌿 Git Navigation
| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `]g` | `next_git_modified` | Jump down to the next modified file in Git |
