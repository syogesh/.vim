" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tacahiroy/ctrlp-funky'

call vundle#end()
filetype on

set ls=2            " allways show status line
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
set laststatus=2
set visualbell t_vb=    " turn off error beep/flash
set novisualbell    " turn off visual bell
set nobackup        " do not keep a backup file
set relativenumber  " set absolute line numbers
set number          " show line numbers
set numberwidth=4   " line numbering takes up 5 spaces
set ignorecase      " ignore case when searching
set scs
set nowrap            " stop lines from wrapping
set noignorecase    " don't ignore case
set notitle         " don't show "Thanks for flying vim"
set ttyfast         " smoother changes
set ttyscroll=1        " turn on scorlling
set bs=2            " Backspace can delete previous characters
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
set shortmess=atI   " Abbreviate messages
set nostartofline   " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files
set undolevels=200
set cpoptions=$cF
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.DS_Store,*.db
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]  

set autoindent    " turn off by default, enable for specific filetypes
set smartindent   " turn off by default, enable for specific filetypes
set cindent       " turn off by default, enable for specific filetypes

" NERD_tree config
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\.bak$', '\~$']
let NERDTreeShowBookmarks=1

" VCS Command Configs
let mapleader = ","

" Syntax for multiple tag files are
" set tags=/my/dir1/tags, /my/dir2/tags
set tags=tags;$HOME/.vim/tags/ "recursively searches directory for 'tags' file

" TagList Plugin Configuration
let Tlist_Ctags_Cmd='/usr/bin/ctags' " point taglist to ctags
let Tlist_GainFocus_On_ToggleOpen = 1      " Focus on the taglist when its toggled
let Tlist_Close_On_Select = 1              " Close when something's selected
let Tlist_Use_Right_Window = 1             " Project uses the left window
let Tlist_File_Fold_Auto_Close = 1         " Close folds for inactive files

" SCMDiff Plugin Configuration
let SCMDiffCommand = 'git'

"set autowrite       " auto saves changes when quitting and swiching buffer
set expandtab       " tabs are converted to spaces
set sm              " show matching braces, somewhat annoying...

" remove ALL auto-commands so there are no dupes
autocmd!

set t_Co=256

syntax on                 " syntax highlighing
if has("gui_running")
    " See ~/.gvimrc
    set lines=57          " height = 50 lines
    set columns=180       " width = 100 columns
    set background=dark   " adapt colors for background
    set guioptions-=T
    set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅ " mark trailing white space
    colorscheme gruvbox
else
    colorscheme gruvbox
    set background=dark  " adapt colors for background
endif

set cursorline 
hi CursorLine   cterm=NONE ctermbg=8 ctermfg=NONE

" Clearn search highlighting when escape is pressed
nnoremap <esc> :noh<return><esc>

if has("autocmd")
    " Restore cursor position
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " Filetypes (au = autocmd)
    au FileType helpfile set nonumber      " no line numbers when viewing help
    au FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
    au FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back
    
    " When using mutt, text width=72
    au FileType mail,tex set textwidth=72
    au FileType cpp,c,java,sh,pl,php,py,asp  set autoindent
    au FileType cpp,c,java,sh,pl,php,py,asp  set smartindent
    au FileType cpp,c,java,sh,pl,php,py,asp  set cindent
    au FileType py set foldmethod=indent
    au FileType py set textwidth=79  " PEP-8 friendly
    au FileType py inoremap # X#
    au FileType py set expandtab
    au FileType py set omnifunc=pythoncomplete#Complete
    autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
    autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    "au BufRead mutt*[0-9] set tw=72
    
    " Automatically chmod +x Shell scripts
    au BufWritePost   *.sh             !chmod +x %

    " File formats
    au BufNewFile,BufRead  *.pls    set syntax=dosini
    au BufNewFile,BufRead  modprobe.conf    set syntax=modconf
endif

" Keyboard mappings
map <F1> :previous<CR>  " map F1 to open previous buffer
map <F2> :next<CR>      " map F2 to open next buffer
map ,n :NERDTree<CR>
map <F7> :TlistToggle<CR> " map F7 to toggle the Tag Listing
map <silent> <C-N> :silent noh<CR> " turn off highlighted search
map ,v :vsplit ~/.vimrc<cr> " edit my .vimrc file in a split
map ,u :source ~/.vimrc<cr> " update the system settings from my vimrc file
map ,p :Lodgeit<CR>         " pastes selection / file to paste.pocoo.org
map ,ft :%s/	/    /g<CR> " replace all tabs with 4 spaces
map ,d :call <SID>SCMDiff()<CR>
map ,w :w <cr>
map ,q :q <cr>
map ,wq :wq <cr>
map - dd
map di' di'i
map di( di(i
map di[ di[i
map di{ di{i
map di" di"i
map a A
map ,t :CtrlP<CR>

inoremap jj <esc>

vmap <Tab> >gv
vmap <S-Tab> <gv
" Viewport Controls
" ie moving between split panes
map <silent>,h <C-w>h 
map <silent>,j <C-w>j
map <silent>,k <C-w>k
map <silent>,l <C-w>l

map <silent><C-left> <C-T>  " step out of a python function
map <silent><C-right> <C-]> " follow a python function 

" Neocomplete autocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_smart_case = 1

" Disable annoying sound
set noerrorbells
set novisualbell
autocmd! GUIEnter * set vb t_vb=

" Skip Closing Parentheses + quotes
" inoremap <expr> <Tab> SkipClosingParentheses()
" function! SkipClosingParentheses()
"  let line = getline('.')
"  let current_char = line[col('.')-1]
 
  "Ignore EOL
"  if col('.') == col('$')
"    return "\t"
"  end
 
"  return stridx(']})"', current_char)==-1 ? "\t" : "\<Right>"
"endfunction

" NERDCommenter
filetype plugin on

" Highlight current line
set cursorline 

" Navigate split windows with Control tab 
" nnoremap <C-tab> <C-w><C-w>
nnoremap <C-w> <C-w><C-w>

" Fix 2c on startup problem
set t_RV= ttymouse=xterm2
nnoremap R <Esc> " Disable replace mode 

" Use command-# to switch tabs
let s:windowmapnr = 0
let s:wins='1234567890!@#$%^&*()'
while (s:windowmapnr < strlen(s:wins))
    exe 'noremap <silent> <D-' . s:wins[s:windowmapnr] . '> ' . (s:windowmapnr + 1) . 'gt'
    exe 'inoremap <silent> <D-' . s:wins[s:windowmapnr] . '> <C-O>' . (s:windowmapnr + 1) . 'gt'
    exe 'cnoremap <silent> <D-' . s:wins[s:windowmapnr] . '> <C-C>' . (s:windowmapnr + 1) . 'gt'
    exe 'vnoremap <silent> <D-' . s:wins[s:windowmapnr] . '> <C-C>' . (s:windowmapnr + 1) . 'gt'
    let s:windowmapnr += 1
endwhile
unlet s:windowmapnr s:wins

" Don't worry about ycm_extra_conf
let g:ycm_confirm_extra_conf = 0

" CtrlP-funky
let g:ctrlp_extensions = ['funky']
noremap <Leader>r :CtrlPFunky<CR>
let g:ctrlp_funky_syntax_highlight = 1

" Make loading faster?
set clipboard=exclude:.*
