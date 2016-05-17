autocmd!

set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'fatih/vim-go'
Plugin 'vim-perl/vim-perl'
Plugin 'mattfoster/vim-Perl-Critic'
Plugin 'Shougo/deoplete.nvim'
Plugin 'majutsushi/tagbar'
Plugin 'c9s/perlomni.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()

filetype plugin indent on

" Tagbar
nmap <F8> :TagbarToggle<CR>

set background=dark
try
    colorscheme solarized
catch
endtry
let g:solarized_termtrans=1

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full
set completeopt=longest,menuone
set wildmenu

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd
set cmdheight=2

set lazyredraw
set magic
set showmatch

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Allow cursor keys in insert mode
set esckeys

" Allow backspace in insert mode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" Optimize for fast terminal connections
set ttyfast
"
" Add the g flag to search/replace by default
set gdefault

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Change mapleader
let mapleader=","

" :W sudo saves the file
command W w !sudo tee % > /dev/null

" Make sure that coursor is always vertically centered on j/k moves
set so=999

" Add vertical lines on columns
set colorcolumn=80,120

" have many lines of command-line history
set history=700

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set dir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Respect modeline in files
set modeline
set modelines=4

" Enable line numbers
set number

" Enable syntax highlighting
syntax on

" Highlight current line
set cursorline

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,nbsp:_
set fillchars=stl:=,stlnc:-
set list

" Highlight searches
set hlsearch

" make searches case-insensitive, unless they contain upper-case letters:
" show the `best match so far' as search strings are typed:
set ignorecase
set smartcase
set incsearch

" Always show status line
set laststatus=2
set statusline=%<\ %F\ %m\ %r%h\ %w\ %y\ <%{&fileencoding},%{&fileformat}>\ \ %=%-14P\ Line:\ %l/%L:%c\

" Enable mouse in all modes
if has('mouse')
    set mouse=a
    set mousemodel=popup
endif

" Disable error bells
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Show the cursor position
set ruler

" Don’t show the intro message when starting Vim
set shortmess=atIr

" Show the filename in the window titlebar
set title

" Start scrolling three lines before the horizontal window border
set scrolloff=5

" normally don't automatically format `text' as it is typed
set formatoptions-=t
set lbr
set textwidth=500

set autoread

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8 tabstop=8
au BufRead,BufNewFile *nginx* set ft=nginx expandtab shiftwidth=4 tabstop=4

" Perl
let perl_extended_vars=1
let perl_include_pod=1
set equalprg=perltidy
set expandtab
:imap dumper <ESC>^iwarn Data::Dumper->Dump([\<ESC>llyw$a], ['<ESC>pa']);<ESC>
:imap ltrace <ESC>^i$logger->trace(Data::Dumper->Dump([\<ESC>llyw$a], ['<ESC>pa']));<ESC>
:imap ldebug  <ESC>^i$logger->debug(Data::Dumper->Dump([\<ESC>llyw$a], ['<ESC>pa']));<ESC>
:imap ldump  <ESC>^i$logger->debug(Data::Dumper->Dump([\<ESC>llyw$a], ['<ESC>pa']));<ESC>
:imap linfo  <ESC>^i$logger->info(Data::Dumper->Dump([\<ESC>llyw$a], ['<ESC>pa']));<ESC>
:imap lfatal  <ESC>^i$logger->fatal(Data::Dumper->Dump([\<ESC>llyw$a], ['<ESC>pa']));<ESC>
:imap lwarn  <ESC>^i$logger->warn(Data::Dumper->Dump([\<ESC>llyw$a], ['<ESC>pa']));<ESC>
:imap lerror  <ESC>^i$logger->error(Data::Dumper->Dump([\<ESC>llyw$a], ['<ESC>pa']));<ESC>

" Be smart when using tabs ;)
set smarttab

" Make tabs as wide as four spaces
set tabstop=4
set shiftwidth=4

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

set ai "Auto indent
set si "Smart indent

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Automatic commands
if has("autocmd")
	set viewoptions=cursor,folds
	" Enable file type detection
	filetype on
	filetype plugin on
	filetype indent on
	autocmd FileType xml,html,css,cs set noexpandtab tabstop=2 shiftwidth=2 formatoptions+=tl smartindent
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
	au BufWinLeave * mkview
	au BufWinEnter * silent loadview
	au FileType html,cheetah set ft=xml
	au FileType html,cheetah set syntax=html
endif

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

" A buffer becomes hidden when it is abandoned
set hid

" Allow smarter completion by infering the case
set infercase

" How many tenths of a second to blink when matching brackets
set mat=2

" Make sure that extra margin on left is removed
set foldcolumn=0

" Enable Ctrl-A/Ctrl-X to work on octal and hex numbers
set nrformats=octal,hex

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Use Unix as the standard file type
set ffs=unix,dos,mac

" highlight trailing space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history
" /20  - remember 20 items in search history
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"50,:20,/20,%,n~/.viminfo.go

" Define what to save with :mksession
" blank - empty windows
" buffers - all buffers not only ones in a window
" curdir - the current directory
" folds - including manually created ones
" help - the help window
" options - all options and mapping
" winsize - window sizes
" tabpages - all tab pages
set sessionoptions=blank,buffers,curdir,folds,help,options,winsize,tabpages

map j gj
map k gk

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

"------------------------------------------------------------------------------
" Spell checking
"------------------------------------------------------------------------------

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"------------------------------------------------------------------------------
" Misc
"------------------------------------------------------------------------------

" easy way to edit reload .vimrc
"nmap <leader>V :source $MYVIMRC<cr>
"nmap <leader>v :vsp $MYVIMRC<cr>

"------------------------------------------------------------------------------
" Helper functions
"------------------------------------------------------------------------------
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ack \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

