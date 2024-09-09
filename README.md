## install 
### requirements

1. you should know vim basic editing like three vim modes, copy, paste, undo...  
2. network for github
3. neovim > 0.10.0

### install steps

1. copy **nvim** folder to **~/.config/**  
2. if use windows, copy **nvim** to C:/Users/\<NAME\>/AppData/Local/, then copy **nvim/windows/init.vim** to C:/Users/\<NAME\>/AppData/Local/nvim. if you want autocomplete using LSP, markdownpreview, install latest nodejs, https://nodejs.org/en/download , if you want file content search, install rg https://github.com/BurntSushi/ripgrepif , if you want git commandline, install lazygit https://github.com/jesseduffield/lazygit
3. open neovim, run :PlugInstall and wait installation complete
4. run `:checkhealth` to see whether any other dependencies are not installed.

### basic key mappings

| cmd                               | description                                  |
|-----------------------------------|----------------------------------------------|
| S                                 | save file                                    |
| Q                                 | quit file                                    |
| space Q                           | quit neovim                                  |
| H                                 | goto line begining                           |
| L                                 | goto line end                                |
| ti                                | create new tab to before current tab         |
| ta                                | create new tab to after current tab          |
| th                                | previous tab                                 |
| tl                                | next tab                                     |
| tfs                               | Tab FullScreen                               |
| {{                                | jump to previous symbol                      |
| }}                                | jump to next symbol                          |
| [[                                | jump to previous git hunk                    |
| ]]                                | jump to next git hunk                        |
| S' or S" or S( in visual mode     | Surround you select with ""or''or()          |
| U                                 | open Undo history                            |
| /                                 | current file search                          |
| space space                       | comment code                                 |
| space sv                          | open init.vim(Vimrc)                         |
| space sl or space sj              | split windows right/below                    |
| space h/j/k/l                     | jump between split windows using hjkl        |
| space fs                          | toggle windows FullScreen                    |
| space e                           | toggle file Explorer                         |
| tt                                | open ranger(require ranger installed)        |
|-----------------------------------|----------------------------------------------|
| space ff                          | search File in project                       |
| space fw                          | search Word in project(require rg installed) |
| space fb                          | search file opened Buffer                    |
| space fr                          | search Recent file                           |
| space ft                          | search Tag in current file                   |
| space fv                          | search word in Vimwiki folder                |
| space fh                          | resume searching History                     |
|-----------------------------------|----------------------------------------------|
| ctrl space(insert mode)           | complete code(using LSP)                     |
| gk                                | show doc(using LSP)                          |
| gd                                | goto Definition(using LSP)                   |
| gi                                | goto Implementation(using LSP)               |
| gy                                | goto Type(using LSP)                         |
| gf                                | open under cursor File                       |
| space fm                          | ForMat code                                  |
| space tg                          | show current file Tags                       |
| space gd                          | go to Definition(using anyjump)              |
| alt o or alt i                    | jump back/forward between file               |
|-----------------------------------|----------------------------------------------|
| ty (normal or visual mode)        | translate                                    |
| ctrl nnnnnn                       | mutiple cursor increase                      |
| shift Q                           | mutiple cursor decrease                      |
| space enter                       | select block                                 |
| space ww                          | open vimwiki notebook                        |
| space oa/oc                       | nvim orgmode menu/action                     |
| ctrl p                            | markdown preview                             |
|-----------------------------------|----------------------------------------------|
| space log (normal or visual mode) | open git log for this project                |
| space logc                        | open git log for current file                |
| space bl  (normal or visual mode) | git blame                                    |
| space lg                          | open lazygit(awesome git tool)               |

**For more features, please check init.vim file.

### markdown support
| command(insert mode) | description                          |
|----------------------|--------------------------------------|
| ,<number1~3>         | level 1~3 title                      |
| ,c                   | Code with language(need close twice) |
| ,d                   | single line command                  |
| ,b                   | Bold                                 |
| ,a                   | link                                 |
| ,f                   | Finish and close insert!             |
**for more, see nvim/ftplugin/markdown.vim** 

**example**  
type `,3Hello,f` in insert mode, will create a 'Hello' title with level 3

### install lsp
:Mason to install lsp, then add config below to similar other lspconfig config in init.vim
```lua
 require('lspconfig')['<YOURLSP"'].setup {
      capabilities = capabilities,
```
### markdown table mode

`:TableModeEnable` 
After enabled, when you can use '|' to create markdown table, table will automatically get aligned.

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
