set background=dark
"set shell=/bin/fish

noremap <C-_> gcc
syntax on                   " Syntax highlighting
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8
set autoindent 
set expandtab 
set softtabstop=0
set tabstop=2
set ts=2
set shiftwidth=2
augroup nix
    autocmd!
    autocmd FileType nix setlocal softtabstop=0 noexpandtab nosmarttab shiftwidth=2 tabstop=2
augroup END


set number
set linespace=0
set ignorecase
set hlsearch
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set pastetoggle=<F12>
set splitright 
set splitbelow
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

set viewoptions=folds,options,cursor,unix,slash
if has('statusline')
    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif


"plugins
nnoremap <Leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle=1
let python_highlight_all = 1
let g:rainbow_active = 1

