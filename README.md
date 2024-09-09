## install 
### requirements

0. you should know vim basic editing like three vim modes, copy, paste, undo...  
1. network for github
2. neovim > 0.10.0

### install steps

0. copy **nvim** folder to **~/.config/**  
1. if use windows, copy **nvim** to C:/Users/\<NAME\>/AppData/Local/, then copy **nvim/windows/init.vim** to C:/Users/\<NAME\>/AppData/Local/nvim. if you want autocomplete using LSP, markdownpreview, install latest nodejs, https://nodejs.org/en/download , if you want file content search, install rg https://github.com/BurntSushi/ripgrepif , if you want git commandline, install lazygit https://github.com/jesseduffield/lazygit
2. open neovim, run :PlugInstall and wait installation complete
3. run `:checkhealth` to see whether any other dependencies are not installed.

### basic key mappings

| cmd                               | description                                    |
|-----------------------------------|------------------------------------------------|
| S                                 | save file                                      |
| Q                                 | quit file                                      |
| space Q                           | quit neovim                                    |
| H                                 | goto line begining                             |
| L                                 | goto line end                                  |
| ti                                | create new tab to before current tab           |
| ta                                | create new tab to after current tab            |
| th                                | previous tab                                   |
| tl                                | next tab                                       |
| tfs                               | tab fullscreen                                 |
| {{                                | jump to previous symbol                        |
| }}                                | jump to next symbol                            |
| [[                                | jump to previous git hunk                      |
| ]]                                | jump to next git hunk                          |
| S' or S" or S( in visual mode     | surround you select with ""or''or()            |
| U                                 | open file modify history                       |
| /                                 | current file search                            |
| space space                       | comment code                                   |
| space sv                          | open init.vim                                  |
| space sl or space sj              | split windows right/below                      |
| space h/j/k/l                     | jump between split windows                     |
| space fs                          | toggle windows fullscreen                      |
| space e                           | toggle file explorer                           |
| tt                                | open ranger(require ranger installed)          |
|-----------------------------------|------------------------------------------------|
| space ff                          | search file in project(require fzf installed)  |
| space fw                          | search string in project(require rg installed) |
| space fb                          | search opened file name                        |
| space fr                          | search opened once history file                |
| space ft                          | search symbol in current file                  |
| space ft                          | search symbol in vimwiki folder                |
| space fh                          | resume last searching result                   |
|-----------------------------------|------------------------------------------------|
| ctrl space(insert mode)           | autocomplete(using LSP)                        |
| gk                                | show under cursor method doc(using LSP)        |
| gd                                | goto under cursor symbol definition(using LSP) |
| gi                                | goto implementation(using LSP)                 |
| gy                                | goto type(using LSP)                           |
| gf                                | open under cursor file path                    |
| space tg                          | show current file symbol outline               |
| space gd                          | go to definition/implementatio(using anyjump)  |
| alt+o or alt+i                    | jump back/forward between file                 |
|-----------------------------------|------------------------------------------------|
| ty (normal or visual mode)        | translate
| ctrl+nnnnnn                       | mutiple cursor increase                        |
| shift Q                           | mutiple cursor decrease                        |
| space enter                       | select block                                   |
| space ww                          | open vimwiki notebook                          |
| space oa/oc                       | nvim orgmode menu/action                       |
| ctrl+p                            | markdown preview using chrome                  |
|-----------------------------------|------------------------------------------------|
| space log (normal or visual mode) | open git log for this project                  |
| space logc                        | open git log for current file                  |
| space bl  (normal or visual mode) | git blame                                      |
| space lg                          | open lazygit(awesome git tool)                 |

**For more features, please check init.vim file.

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

### install lsp
:Mason to install lsp, then add config below to init.vim
```lua
 require('lspconfig')['<YOURLSP"'].setup {
      capabilities = capabilities,
```
### markdown table mode

`:TableModeEnable` 
After enabled, when you can use '|' to create markdown table, table will automatically align.

### install language server
`:LspInstall` install current opened file type language server to enable autocomplete/document/semantic jump/highlighting feature.

### ranger(suggest to use Ranger as file explorer)
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
