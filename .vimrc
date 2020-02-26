" vimrc - larsand@gmail.com

" install vim-plug plugin manager if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround' 
Plug 'tpope/vim-dispatch' 
Plug 'tpope/vim-repeat' 
Plug 'danro/rename.vim'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 ./install.py --clangd-completer --racer-completer' }
Plug 'kana/vim-textobj-user'
Plug 'Julian/vim-textobj-variable-segment' 
Plug 'sgur/vim-textobj-parameter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'machakann/vim-swap'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'plytophogy/vim-virtualenv'
Plug 'pangloss/vim-javascript'
Plug 'rhysd/vim-clang-format'
"Plug 'timonv/vim-cargo'
"Plug 'vim-python/python-syntax'
"Plug 'hdima/python-syntax'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'dhruvasagar/vim-zoom'           " Toogle zoom of current window using C-w m
Plug 'landersson/vim-term-cargo'
Plug 'landersson/vim-blueberry'
Plug 'mkitt/tabline.vim'
Plug 'w0rp/ale'
Plug 'rust-lang/rust.vim'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'
Plug 'aklt/plantuml-syntax'
Plug 'peterhoeg/vim-qml'

call plug#end()

filetype plugin indent on

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set fileformat=unix

" automatically reread externally changed files (not modified in vim)
set autoread
set hidden

" better tab completion when opening files
set wildmode=longest,list,full
set wildmenu

" longer command history
set history=1000
set termencoding=utf-8

" disable vi compatibility (emulation of old bugs)
set nocompatible

" use indentation of previous line
set autoindent

" use intelligent indentation for C
set smartindent

" c/c++ indentation options
set cino=N-s,g0,j1,(0,t0

" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set sw=4
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces

" disable line wrapping
set textwidth=0
set nofoldenable

" enable backspacing over indentation,eol and start of insert
set backspace=indent,eol,start

set diffopt=filler,vertical

" max height of preview window
set previewheight=16

if exists('python_space_error_highlight')
    unlet python_space_error_highlight
endif

"--- Appearance -------------------------------------------------------------  

" TODO: check if this is necessary
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


if has("gui_running")
    if has("osx")
        set guifont=Menlo-Regular:h14
    endif
    if hostname() == "whisky"
        set guifont=Monospace\ 12
    endif
	" no toolbar, no menu
	set guioptions-=T
	set guioptions-=m
	" no righthand scroll bar
	set guioptions-=r
	" no left hand scroll bar
	set guioptions-=L
    set bg=light
else
    set bg=dark
endif

" turn syntax highlighting on
silent! colorscheme blueberry
syntax on

" highlight matching angle brackets
set matchpairs+=<:> 

" turn line numbers on
set number

" highlight matching braces
set showmatch

" intelligent comments
"set comments=sl:/*,mb:\ *,elx:\ */

" incremental searching
set incsearch

" emacs style searching case policy
set ignorecase
set smartcase

if v:version > 703 
  set formatoptions+=j " Delete comment character when joining commented lines
endif

set pastetoggle=<f5>

" disable ins-completion-menu messages
set shortmess+=c


set laststatus=2
set statusline=%<\ %n:%F\ %m%r%y%=%-35.(L:\ %l\/\%L,\ C:\ %c%V\ (%P)%)

" This function will remove trailing whitespace while
" attempting to preserve the current cursor position
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre *.{py,cc,h} :call <SID>StripTrailingWhitespaces()

" Open help in vertical rather than horizontal split  
autocmd FileType help wincmd L

"--- Plugin options ------------------------------------------------------------ 

" ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" vim-slime
let g:slime_target = "timux"
let g:slime_paste_file = tempname()

" ALE options
let g:ale_sign_column_always = 1
let g:ale_linters = {}
let g:ale_linters.cpp = ['clangcheck', 'clangtidy', 'cppcheck']
"let g:ale_linters.rust = ['cargo', 'rustc']
"let g:ale_linters.rust = ['rls', 'rustc']
let g:ale_linters.rust = ['rls']
let g:ale_linters.python = ['flake8']
let g:ale_fixers = {'python': ['autopep8'] }
let g:ale_lint_on_insert_leave = 0
"let g:ale_cpp_clangtidy_checks = [ "clang-*", "readability-*", "-readability-braces*", "-readability-else-after*"]
let g:ale_cpp_clangtidy_checks = [ "-clang-analyzer*", "readability-*", "-readability-braces*", "-readability-else-after*", "-readability-magic-*"]
let g:ale_python_flake8_options = '--max-line-length=98'
"let g:ale_rust_rustc_options="--emit metadata"
let g:ale_rust_rustc_options=""
"let g:ale_rust_rustfmt_options


" YCM options
let g:ycm_always_populate_loc_list = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_cache_omnifunc=0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_rust_src_path = "/Users/laan/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
"let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" clang-format options
"let g:clang_format#auto_formatexpr = 1
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#detect_style_file = 1
let g:clang_format#enable_fallback_style = 0  " Do nothing if .clang-format file not found

autocmd FileType c,cpp ClangFormatAutoEnable

" CtrlP options
let g:ctrlp_map = '' 
let g:ctrlp_match_current_file = 1

let g:pydoc_cmd = 'python3 -m pydoc'
let g:python_highlight_all = 1
let g:rustfmt_autosave = 1

"--- Keyboard mapping ------------------------------------------------------------  

let mapleader=","

"remap jk to escape in insert mode
inoremap jk <Esc>
nnoremap <leader>w :w!<cr>
nnoremap <leader>z :e #<cr>

" edit file in the same directory 
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>v :vsp<space>
nnoremap <leader>gg :YcmCompleter GoTo<cr>
nnoremap <leader>gd :YcmCompleter GetDoc<cr>
nnoremap <leader>s :%s/
nnoremap <leader>a :Ack<cr>
nnoremap <leader>X :x<cr>
nnoremap <leader>xq :cclose<cr>  " close quickfix
nnoremap <leader>q :bp\|bd #<cr>
nnoremap <leader>b :buffers<cr>:b<space>
nnoremap <leader>d "_d
nnoremap <leader>D "_D
nnoremap <leader>m :CtrlPMRUFiles<cr>
nnoremap <leader>f :CtrlP<cr>
nnoremap <leader>t :botright split<cr>:term ++curwin<cr>
nnoremap <leader>` :vsplit $MYVIMRC<cr>
nnoremap <leader>% :w<cr>:so %<cr>
nnoremap <leader><space> i<space><Esc>la<space><Esc>h
vnoremap <leader>p "_dP
" Pressing ,ss will toggle and untoggle spell checking
noremap <leader>ss :setlocal spell!<cr>
" Toggle paste mode on and off
"noremap <leader>pp :setlocal paste!<cr>
noremap Y y$

" tab navigation
nnoremap th  :tabfirst<cr>
nnoremap tk  :tabnext<cr>
nnoremap tj  :tabprev<cr>
nnoremap tl  :tablast<cr>
nnoremap tt  :tabedit<space>
nnoremap tn  :tabnew<cr>
nnoremap tm  :tabm<space>
nnoremap td  :tabclose<cr>

nnoremap [a :ALEPrevious<cr>
nnoremap ]a :ALENext<cr>

" Open new line and enter insert mode without indentation
nnoremap <S-Enter> A<cr><Esc>I
" Open new line without entering insert mode
nnoremap <c-Enter> o<Esc>

function! RepeatChar(char, count)
    return repeat(a:char, a:count)
endfunction

" insert/append single character, then exit insert mode
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Compile buffer as rust and run
noremap <leader>rr :w<cr>:RustRun<cr>
noremap <leader>rt :botright split<cr>:term ++curwin<cr>

"noremap <leader>rr :w<CR>:!clear;python %<CR>
" show symbol id for word under cursor
noremap <leader>xs :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \. synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

function! ReturnHighlightTerm(group, term)
   " Store output of group to variable
   let output = execute('hi ' . a:group)

   " Find the term we're looking for
   return matchstr(output, a:term.'=\zs\S*')
endfunction
