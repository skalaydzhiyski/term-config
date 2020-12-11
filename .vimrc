filetype plugin on
filetype indent on
syntax on

" better way to exit of Ins using Control-C
noremap <C-c> <Esc>
inoremap <C-c> <Esc>

noremap r :redo<cr>

" remap the :W and :Q to do the same as :w and :q respectively for writing/quitting to/from files
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>

set linebreak
set nu
nmap <C-N><C-N> :set invnumber<CR>
set backspace=start,indent,eol
set autoindent
set nosmartindent
nnoremap <c-l> <c-l>:noh<cr>
set incsearch
set ignorecase
set smartcase
set wrapscan
set cmdheight=1
set laststatus=2
set showmode
set showcmd
set showmatch
set matchtime=2

set encoding=utf-8
set modeline
set background=dark

hi clear
hi String       guifg=#b3779a gui=none
set hlsearch
syntax on
nmap qq :qa!<CR>
syn case match

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
call plug#end()

"let g:NERDTreeDirArrows=0
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" Python run mappings
noremap <F12> :!python main.py<Return>
inoremap <F12> <Esc>:!python main.py<Return>

" emmet vim config
let g:user_emmet_leader_key=','

" On pressing tab, insert 2 spaces
set expandtab           " enter spaces when tab is pressed
set tabstop=2           " use 2 spaces to represent tab
set softtabstop=2
set shiftwidth=2        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line

" make backspaces more powerfull
set backspace=indent,eol,start
aug python
    " ftype/python.vim overwrites this
    au FileType python setlocal ts=2 sts=2 sw=2 expandtab
aug end

set t_Co=256

" set the style for the code
colo peachpuff
hi Comment ctermfg=blue
hi Search cterm=None ctermfg=black

" autocompletion
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction

inoremap <Tab> <C-R>=InsertTabWrapper("backward")<cr>
inoremap <S-Tab> <C-R>=InsertTabWrapper("forward")<cr>
