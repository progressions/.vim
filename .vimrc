runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let mapleader=","

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

syntax on
filetype off
filetype plugin indent on

au BufNewFile,BufRead *.prawn set filetype=ruby
au BufNewFile,BufRead *.axlsx set filetype=ruby

" My preferred default tab settings (makes tabs stand out)
set ts=2 sts=2 sw=2 expandtab

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd Filetype text setlocal tw=80 formatoptions+=a spell

  autocmd BufNewFile,BufRead *.tsv set filetype=tsv
  autocmd FileType tsv setlocal noexpandtab

  " Automatically source my vimrc when I save it
  autocmd BufWritePost .vimrc source $MYVIMRC
endif


" For showing hidden characters
set list listchars=tab:▸\ ,trail:•

" Trim trailing whitespace on command
command! TW :call <SID>StripTrailingWhitespaces()

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Next buffer and close old one.
command! BD :bp<bar>:bd#

set hidden

set lazyredraw

set showmode

" set wildmenu

set autoread

" Edit this file
nmap <silent> <leader>v :vsp $MYVIMRC<cr>

" Easier window nav
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l


" Map ctrl-n and ctrl-p to :cn and :cp respectively.
nmap <silent> <C-n> :cn<cr>
nmap <silent> <C-p> :cp<cr>

" Map tab and shift-tab to switch buffers.
nmap <silent> <tab> :bn<cr>
nmap <silent> <S-tab> :bp<cr>

" FuzzyFinder Shortcuts
nmap <Leader>t :FufTaggedFile<CR>

" Refresh CTags
nmap <Leader>c :!ctags --langmap=Ruby:+.haml.slim.erb --extra=+fq -R --langdef=scss --langmap=scss:.scss.sass.css .<CR><CR>

set background=dark
" colorscheme solarized
set number
set nowrap
set linebreak
set winwidth=85
set encoding=utf-8
set completeopt=menu,preview,longest

set laststatus=2
set statusline=%f%(\ %M%)%(\ %R%)%(\ %W%)%(\ %y%)%=%-14.(%l,%c%V%)\ %P

au BufRead,BufNewFile *.rabl setfiletype ruby

" set ai
" set cpoptions+=$

set tags=./tags;

set pastetoggle=<F2>

set noswapfile
set nobackup

let g:CommandTMaxFiles=30000

" Don't beep and don't flash. Bleh!
set noeb vb t_vb=

" au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

au BufNewFile,BufRead *.tml set filetype=html

" call togglebg#map("<F5>")

highlight VertSplit    ctermfg=White   ctermbg=DarkGrey cterm=bold

function! WriteMarkdown()
  set wrap linebreak nolist
  map j gj
  map k gk
endfunction

" turn-on distraction free writing mode for markdown files
" au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} call WriteMarkdown()
" autocmd BufNewFile,BufReadPost *.md set filetype=markdown

