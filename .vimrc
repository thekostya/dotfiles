autocmd!
" Use the Solarized Dark theme
set background=dark
colorscheme solarized
let g:solarized_termtrans=1

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full
" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd
set cmdheight=2
" don't have files trying to override this .vimrc:
set nomodeline
"Do not redraw, when running macros.. lazyredraw
set lz
"Set magic on
set magic
"show matching bracets
set showmatch

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" have many lines of command-line history
set history=400
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
" Make tabs as wide as two spaces
set tabstop=4
set sw=4
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
set mouse=a
set mousemodel=popup
" Disable error bells
set noerrorbells
set novisualbell
set t_vb=
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

" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions-=t
set textwidth=120

set autoread

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8 tabstop=8
au BufRead,BufNewFile *nginx* set ft=nginx expandtab shiftwidth=4 tabstop=4

" Perl
let perl_extended_vars=1
set equalprg=perltidy
set expandtab

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

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

