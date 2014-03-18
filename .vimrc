set nocompatible
set nowrap
set backspace=indent,eol,start whichwrap+=<,>,[,] "允许退格键的使用
":helptags ~/.vim/doc/

"Sets how many lines of history VIM has to remember
set history=400
set hls

"Set to auto read when a file is changed from the outside
set autoread

"Have the mouse disable
set mouse=

""================================================
" Folding
"================================================
set fdm=marker
"set folding
set foldlevel=1

"================================================
" Colors and Fonts
"================================================
syntax on       "enable syntax hl
hi clear
colorscheme default
"colors inkpot 
set background=dark
":runtime syntax/colortest.vim "Test for color schema

"color scheme
if !has("gui_running")
    set t_Co=256
endif

"Display Colors (:h hi)
"Omni menu colors
hi Pmenu guifg=Yellow guibg=DarkBlue ctermbg=DarkBlue ctermfg=White 
hi PmenuSel guibg=#555555 guifg=#ffffff
"hi StatusLine term=reverse ctermfg=DarkBlue ctermbg=White gui=undercurl guisp=Magenta
hi StatusLine term=reverse ctermfg=DarkBlue ctermbg=White
function! CurDir()
   "let curdir = substitute(getcwd(), '/home/deepblue/', "~/", "g")
   let curdir = getcwd()
   return curdir
endfunction
set statusline=CWD:\ %r%{CurDir()}%h\ ,\ FilePath:\ %<%F\%r%h\ \ %w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ %4v(ASCII=%03.3b,HEX=%02.2B)\%l/%L(%P)%m

"================================================
"SessionSetting
"================================================
au VimLeave * call VimLeave()"{{{
au VimEnter * call VimEnter()
let g:PathToSessions = $HOME . "/.vim/backup/session/"

    function! VimEnter()
      if argc() == 0
        let LoadLastSession = confirm("Restore last session?", "&Yes\n&No")
        if LoadLastSession == 1
          exe "source " . g:PathToSessions . "/LastSession.vim"
        else
          call LoadSessions()
        endif
      endif
    endfunction

    function! LoadSessions()
      let result = "List of sessions:"
      let sessionfiles = glob(g:PathToSessions . "/*.vim")
      while stridx(sessionfiles, "\n") >= 0
        let index = stridx(sessionfiles, "\n")
        let sessionfile = strpart(sessionfiles, 0, index)
        let result = result . "\n " . fnamemodify(sessionfile, ":t:r")
        let sessionfiles = strpart(sessionfiles, index + 1)
      endwhile
      let result = result . "\n " . fnamemodify(sessionfiles, ":t:r")
      let result = result . "\n" . "Please enter a session name to load (or empty to start normally):"
      let sessionname = input(result)
      if sessionname != ""
        let g:SessionFileName = g:PathToSessions . "/" .sessionname . ".vim"
        exe "source " . g:PathToSessions . "/" . sessionname . ".vim"
      endif
    endfunction

    function! VimLeave()
      exe "mksession! " . g:PathToSessions . "/LastSession.vim"
      if exists("g:SessionFileName") == 1
        if g:SessionFileName != ""
          exe "mksession! " . g:SessionFileName
        endif
      endif
    endfunction

    function! KillSession()
        if argc() == 0
        endif
    endfunction

" A command for setting the session name"}}}
com -nargs=1 SetSession :let g:SessionFileName = g:PathToSessions . <args> . ".vim"
" .. and a command to unset it
com -nargs=0 DelSession :let g:SessionFileName = ""
"com -nargs=1 KillSession :call KillSession(<args>)

"================================================
" VIM userinterface
"================================================
set wildmenu            " Turn on wild menu
set wildmode=list:full

set nobomb              " Turn off BOM (Byte Order Mark)

set hlsearch            " Hilight search things
set incsearch           " Move to target when search
set wrapscan            " Return to top of file when search hit buttom

set cmdheight=2         " The commandbar is 2 high

set ruler               " Show the cursor position all the time
set ai	                " autoindent: always set autoindenting on
set smartindent
set showmode	        " show mode. show filename size when open file
set bs=2			    " allow backspacing over everything in insert mode
set showmatch			" show matching parenthese.
set viminfo='20,\"50	" read/write a .viminfo file, don't store less than 50 lines of registers 20 commands
set showcmd			    " display incomplete commands
set laststatus=2		" display a status-bar.

set tabstop=4
set shiftwidth=4
set expandtab
"set softtabstop=2

"================================================
" Fileformats
"================================================
set ffs=unix,dos,mac    " Favorite filetypes
"Encoding
set encoding=utf-8		" ability => utf-8 (latin/big5/ucs-bom/utf-8/sjis/big5/...)
set fileencoding=utf-8	" prefer => utf-8
set fileencodings=utf-8,big5,gbk,gb2312,cp936,iso-2022-jp,sjis,euc-jp "charset detect list. ucs-bom must be earlier than ucs*

"================================================
" Files and Bakcup
"================================================
set backup			" backup: keep a backup file
set backupdir=~/.vim/backup/bk		" op=,.,/var/tmp/vi.recover,/tmp " bdir: backup directory
set directory=~/.vim/backup/swap" op=,.,/var/tmp/vi.recover,/tmp " dir to save swp files

"================================================
" Useful Keyboard Binding
"================================================
let mapleader="," " mapleader ,s
"单个文件编译
"map <F5> :call Do_OneFileMake()<CR>
" // The switch of the Source Explorer                                         "
"nmap <F5> :SrcExplToggle<CR>
" Open and close all the three plugins on the same time
nmap <C-F7> :TrinityToggleAll<CR>
" Open and close the srcexpl.vim separately
nmap <C-F9> :TrinityToggleSourceExplorer<CR>
" Open and close the taglist.vim separately
nmap <C-F10> :TrinityToggleTagList<CR>
" Open and close the NERD_tree.vim separately
nmap <C-F11> :TrinityToggleNERDTree<CR>

"进行make的设置
map <F6> :BufExplorer<CR>
let g:bufExplorerDefaultHelp=1       " Show default help
let g:bufExplorerDisableDefaultKeyMapping=0    " Do not disable mapping
let g:bufExplorerDetailedHelp=0      " Show detailed help.
let g:bufExplorerFindActive=1        " Go to active window. 
let g:bufExplorerSortBy='fullpath'   " Sort by full file path name.
let g:bufExplorerSplitBelow=1        " Split new window below current.
"let g:bufExplorerHorzSize=10          " New split window is n rows high.
"NERDTree
map <F7> :NERDTreeToggle<CR>
"For Programming
map <F8>	:set hls!<BAR>set hls?<CR>	    " switch hls/nohls
map <F9>	:set nu!<BAR>set nu?<CR>	    " switch nu/nonu
map <F10>	:set list!<BAR>set list?<CR>	" switch list/nolist

"Fast editing vimrc and reload it
map <leader>v :sp $HOME/.vimrc_db<CR><C-W>_
map <silent> <leader>V :!source $HOME/.vimrc_db<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

"Fast editing Snippet
"map ,s :sp ~/.vim/snippets
"================================================
" Quick Fix
"================================================
map cn :cn<CR>
map cp :cp<CR>

"================================================
" Using tab to edit files
"================================================
"hi TabLine     cterm=none ctermfg=lightgrey ctermbg=lightblue guifg=gray guibg=black
"hi TabLineSel  cterm=none ctermfg=lightgrey ctermbg=LightMagenta guifg=white guibg=black
"hi TabLineFill cterm=none ctermfg=lightblue ctermbg=lightblue guifg=black guibg=black
map <C-L> :tabnext<CR>
map <C-H> :tabprev<CR>
map tn :tabnew<CR>
map td :tabclose<CR>
"jsbeautify: <leader> ff

au BufWinLeave *.js mkview
au BufWinEnter *.js silent loadview
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

au BufRead,BufNewFile *.st set filetype=html syntax=html

au BufWinLeave *.php mkview
au BufWinEnter *.php silent loadview

au BufWinLeave *.cc mkview
au BufWinEnter *.cc silent loadview
autocmd FileType python map ,e :w<CR>:!perl %<CR>
autocmd FileType python map ,e :w<CR>:!python %<CR>

"Smarty
autocmd FileType smarty set filetype=html
au BufRead,BufNewFile /etc/nginx/* set ft=nginx 

let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'The-NERD-tree'
Bundle 'The-NERD-Commenter'
" original repos on github
" vim-scripts repos
Bundle 'L9'
" non github repos
"Bundle 'scrooloose/syntastic'
Bundle 'JavaScript-Indent'
Bundle 'L9'
Bundle 'SrcExpl'
Bundle 'Syntastic'
Bundle 'Tabular'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'mattn/emmet-vim'
Bundle 'node.js'
Bundle 'taglist-plus'
Bundle 'vim-stylus'
"Fugitive
"FuzzyFinder
filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foO
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

"================Vundle, Start it by :BundleInstall

"au FileType php,c,java,javascript,html,htm,smarty call SetPhpOption()
"function! SetPhpOption()
"set expandtab ” 使用空格代替tab
"set shiftwidth=4 ” 设定 <> 命令移动时的宽度为 4
"set tabstop=4 ” 用4个空格代替1个tab
"set sts=4 ” 设置softtabstop 为 4，输入tab后就跳了4格.
"set cindent ” C语言方式缩进
"set smartindent ” 智能缩进
"set autoindent ” 自动缩进
"set smarttab ” 只在行首用tab，其他地方的tab都用空格代替
"set showmatch ” 在输入括号时光标会短暂地跳到与之相匹配的括号处
"” set fdm=indent ” 代码折叠
"set lbr
"set tw=500
"set wrap ” 自动换行
"endfunction
nnoremap <A-F1> 1gt
nnoremap <A-F2> 2gt
nnoremap <A-F3> 3gt
nnoremap <A-F4> 4gt
nnoremap <A-F5> 5gt
nnoremap <A-F6> 6gt
nnoremap <A-F7> 7gt
nnoremap <A-F8> 8gt
nnoremap <A-F9> 9gt
nnoremap <A-F0> 10gt

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction
