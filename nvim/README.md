## install 
### requirements

0. you should know vim basic editing like three vim modes, copy, paste, undo...  
1. network for github
2. neovim > 0.8.0

### install steps

0. copy **nvim** folder to **~/.config/**  
1. if use windows, copy **nvim** to C:/Users/<NAME>/AppData/Local/, then copy **nvim/windows/init.vim** to C:/Users/<NAME>/AppData/Local/nvim. if you want autocomplete using LSP, markdownpreview, install latest nodejs, https://nodejs.org/en/download , if you want file fuzzy search, install fzf https://github.com/junegunn/fzf#installation, if you want git commandline, install lazygit https://github.com/jesseduffield/lazygit
2. open neovim and wait installation complete
3. run `:checkhealth` to see whether any other dependencies are not installed.

### basic key mappings

| cmd                                 | description                                        |
|-------------------------------------|----------------------------------------------------|
| shift + s                           | save file                                          |
| shift + q                           | quit                                               |
| shift + h                           | goto line begining                                 |
| shift + l                           | goto line end                                      |
| shift + j                           | 5 lines down                                       |
| shift + k                           | 5 lines up                                         |
| shift s+ ' or " or ( in visual mode | surround you select with ""/ ''/ ()                |
| shift + u                           | open file modify history                           |
| /                                   | enhanced current file search                       |
| space + space                       | comment code                                       |
| space + sl/sj                       | split windows right/below                          |
| space + h/j/k/l                     | jump between split windows                         |
| space fs                            | windows fullscreen                                 |
| tt                                  | file explorer                                      |
|-------------------------------------|----------------------------------------------------|
| ctrl+f                              | search file in project(need fzf installed)         |
| ctrl+h                              | search opened once history file                    |
| ctrl+j                              | search string in project(need rg installed)        |
| ctrl+j, ctrl+k                      | next/previous item in search result window         |
|-------------------------------------|----------------------------------------------------|
| tab(insert mode)                    | autocomplete(using LSP)                            |
| gk                                  | show under cursor method doc(using LSP)            |
| gd                                  | goto under cursor symbol definition(using LSP)     |
| gi                                  | goto implementation(using LSP)                     |
| go                                  | goto type(using LSP)                               |
| gb                                  | jump back(using LSP)                               |
| gf                                  | open under cursor file path                        |
| tg                                  | show current file symbol outline                   |
| space + gd                          | go to definition/implementatio(using anyjump)      |
| alt+o/alt+i                         | jump back/forward between file                     |
|-------------------------------------|----------------------------------------------------|
| ctrl+n....nnnnn                     | mutiple cursor  enter/increase                     |
| shift + Q                           | mutiple cursor decrease                            |
| <space>+enter...enter enter         | select block                                       |
| space + ww                          | open vimwiki notebook                              |
| space + oa/oc                       | nvim orgmode menu/action                           |
| ctrl+g                              | open lazygit(awesome git tool)                     |
| ty                                  | translate under cursor/selected content to chinese |
| <space>sv                           | open vim plugin configuration                      |
| ctrl + p                            | markdown preview using chrome                      |

**For more features, please check configuration file with 'sv' keymap

### markdown support
| command(insert mode) | description                     |
|----------------------|---------------------------------|
| ,+f                  | close insert                    |
| ,+<number> 1~3       | level 1~3 title                 |
| ,+c                  | code with language(close twice) |
| ,+d                  | single line command             |
| ,+b                  | bold                            |
| ,+a                  | link                            |
**for more, see nvim/ftplugin/markdown.vim** 

**example**  
type `,3Hello,f` in insert mode, will create a 'Hello' title with level 3

### markdown table mode

`:TableModeEnable` 
After enabled, when you can use '|' to create markdown table, table will automatically align.

### install language server
`:LspInstall` install current opened file type language server to enable autocomplete/document/semantic jump/highlighting feature.

### file explorer
see [../ranger/README.md](../ranger/README.md) 

### vimwiki note
<CR> to create sub link for under cursor/selected keyword, <backspace> jump back.

### additional text-object
s: substitute with clipboard, you can use it as motion like c, d
example: siw

s:surround, you can use it as operator like i, a
example: cs" or ds"

f:function(partially support), you can use it as operator like w, "
example: cif or dif
