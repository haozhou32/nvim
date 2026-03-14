
# Mastering Text Objects in Neovim

In Neovim, **text objects** allow you to perform editing actions on structural blocks of text—like words, sentences, parentheses, or LaTeX environments—without having to highlight them character by character. 

This tutorial is broken down into three sections based on the configuration: Native Neovim objects, LaTeX-specific objects (`vimtex`), and surrounding text objects (`mini.surround`).

## 1. Native Neovim Text Objects

In native Neovim, dealing with text objects typically relies on a simple three-part formula:

**`Verb` + `Select Type` (Modifier) + `Text Object Type`**

### Step 1: Choose your Verb (Action)
What do you want to do with the text?
* `v` - **Select** in visual mode
* `c` - **Change** (deletes the target and drops you into insert mode)
* `d` - **Delete**
* `y` - **Yank** (copy)

### Step 2: Choose your Select Type (Modifier)
* `a` (**Around**): Includes the object *and* its surrounding whitespace or delimiters.
* `i` (**Inside**): Includes *only* the inner contents of the object.

### Step 3: Choose your Text Object
* `w` - Word (standard alphanumeric word)
* `W` - WORD (A sequence of non-blank characters, omitting punctuation)
* `s` - Sentence
* `p` - Paragraph
* `t` - HTML/XML tag
* `f` - Function
* `Surroundings` - Any paired delimiter like `(`, `[`, `{`, `"`, or `'`

**Practical Examples:**
* **`diw`**: **D**elete **I**nside **W**ord. (Deletes the word your cursor is currently on).
* **`yap`**: **Y**ank **A**round **P**aragraph. (Copies the entire paragraph).
* **`ci"`**: **C**hange **I**nside **"**. (Deletes everything inside `" "` and enters insert mode).

---

## 2. LaTeX Objects via `vimtex`

When editing `.tex` files, the `vimtex` plugin massively extends Neovim's built-in text objects to understand LaTeX syntax. It acts as an add-on to the formula mentioned above.

### A. Vimtex Text Object Types
You can combine standard verbs (`d`, `c`, `y`) and modifiers (`i`, `a`) with the following LaTeX-specific targets:

| Key | Target Text Object | Example Use Case |
| :---: | :--- | :--- |
| **`c`** | LaTeX commands (e.g., `\textbf{text}`) | `dic` deletes the text inside the braces. |
| **`d`** | Delimiters (e.g., `[...]` or `(...)`) | `yad` yanks around the delimiter. |
| **`e`** | Environments (`\begin{}...\end{}`) | `yae` copies the entire environment block. |
| **`m`** | Math zones (`$...$`) | `cim` changes the equation inside the `$` symbols. |
| **`P`** | Sections | `dap` deletes an entire LaTeX section. |
| **`i`** | List items (in `itemize` / `enumerate`) | `cii` changes an individual bullet point. |

### B. Vimtex Surrounding Shortcuts
To speed up editing, `vimtex` also maps direct shortcuts (in Normal mode) to delete, change, or toggle LaTeX environments and commands:

* **Delete/Change Surroundings:**
  * `dse` / `cse`: **D**elete / **C**hange **s**urrounding **e**nvironment.
  * `dsc` / `csc`: **D**elete / **C**hange **s**urrounding **c**ommand.
  * `dsd` / `csd`: **D**elete / **C**hange **s**urrounding **d**elimiter.
  * `dsm` / `csm`: **D**elete / **C**hange **s**urrounding **m**ath zone.
* **Toggling Surroundings:**
  * `tsc` / `tse`: Toggle starred versions of **c**ommands and **e**nvironments (e.g., changing `\begin{equation}` to `\begin{equation*}`).
  * `tsm`: Toggle inline and display **m**ath (`$...$` vs `\[...\]`).
  * `tsd`: Toggle surrounding **d**elimiters.
  * `tsf`: Toggle surrounding **f**ractions.

---

## 3. `mini.surround` Text Objects

The `mini.surround` plugin replaces standard plugins like `vim-surround` to give you lightning-fast keyboard bindings to Add, Delete, or Replace surrounding character pairs (like quotes, brackets, and parentheses).

In this configuration, operations use an `s` (surround) prefix followed by the action:

### A. Adding Surroundings (`sa`)
**Formula:** `sa` + `Text Object` + `Surrounding Character`
* **Example:** `saiw)` 
  * Breakdown: **S**urround **A**dd **I**nner **W**ord with **)**
  * *Result:* The word `hello` becomes `(hello)`.

### B. Deleting Surroundings (`sd`)
**Formula:** `sd` + `Surrounding Character`
* **Example:** `sd'`
  * Breakdown: **S**urround **D**elete **'** (single quotes)
  * *Result:* `'hello'` becomes `hello`.

### C. Replacing Surroundings (`sr`)
**Formula:** `sr` + `Old Surrounding` + `New Surrounding`
* **Example:** `sr)'`
  * Breakdown: **S**urround **R**eplace **)** with **'**
  * *Result:* `(hello)` becomes `'hello'`.

---

### 💡 Quick Cheat Sheet

Want to memorize the most common flows? Try practicing these:
1. Delete a standard word: `diw`
2. Change the text inside a LaTeX equation: `cim`
3. Delete the `\textbf{}` command but keep the text inside: `dsc`
4. Add brackets around a paragraph: `sap]`
5. Change double quotes to single quotes: `sr"'`
