" Leader
let mapleader = " "

set nocompatible  " Use Vim settings, rather then Vi settings
set backupcopy=yes
set backspace=2
set autoread
set autoindent
set clipboard=unnamed
set directory-=.
set encoding=utf-8
set ignorecase
set list
set listchars=tab:▸\ ,trail:▫
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set smartcase
set wildignore=log/**,node_submodules/**,target/**,tmp/**,*.rbc
set wildmenu
set hlsearch
set notimeout
set ttimeout
set ttimeoutlen=50
set noshowmode


set mouse=a
set term=xterm-256color

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Declare bundles are handled via Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

let g:vundle_default_git_proto = 'http'
let g:netrw_home=$HOME

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Define bundles via Github repos
Bundle 'kchmck/vim-coffee-script'
Bundle 'nanki/treetop.vim'
Bundle 'timcharper/textile.vim'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-bundler'
Bundle 'tsaleh/vim-matchit'
Bundle 'vim-scripts/ctags.vim'
Bundle 'vim-scripts/greplace.vim'
Bundle 'vim-scripts/tComment'
Bundle 'vim-scripts/taglist.vim'
Bundle 'xenoterracide/html.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/syntastic'
Bundle 'rstacruz/sparkup'
Bundle 'crooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'juvenn/mustache.vim'
Bundle 'nono/vim-handlebars'
Bundle 'austintaylor/vim-indentobject'
Bundle 'pangloss/vim-javascript'
Bundle 'rmanalan/jshint.vim'
Bundle 'vim-scripts/kwbdi.vim'
Bundle 'tpope/vim-pastie'
Bundle 'uarun/vim-protobuf'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-repeat'
Bundle 'mileszs/ack.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'msanders/snipmate.vim'
Bundle 'majutsushi/tagbar'
Bundle 'leafgarland/typescript-vim'
Bundle 'tpope/vim-unimpaired'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'slim-template/vim-slim'
Bundle 'bling/vim-airline'
" Bundle 'christoomey/vim-tmux-navigator'



filetype plugin indent on

augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Softtabs, 2 spaces
set tabstop=8
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif

" Color scheme
set background=dark
colorscheme solarized
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Cucumber navigation commands
autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes
" :Cuc my text (no quotes) -> runs cucumber scenarios containing "my text"
command! -nargs=+ Cuc :!ack --no-heading --no-break <q-args> | cut -d':' -f1,2 | xargs bundle exec cucumber --no-color

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Markdown files end in .md
au BufRead,BufNewFile *.md set filetype=markdown

" Enable spellchecking for Markdown
au BufRead,BufNewFile *.md setlocal spell

" Automatically wrap at 80 characters for Markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

" rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>

function! RunCurrentSpecFile()
  if InSpecFile()
    let l:command = "s " . @% . " -f documentation"
    call SetLastSpecCommand(l:command)
    call RunSpecs(l:command)
  endif
endfunction

function! RunNearestSpec()
  if InSpecFile()
    let l:command = "s " . @% . " -l " . line(".") . " -f documentation"
    call SetLastSpecCommand(l:command)
    call RunSpecs(l:command)
  endif
endfunction

function! RunLastSpec()
  if exists("t:last_spec_command")
    call RunSpecs(t:last_spec_command)
  endif
endfunction

function! InSpecFile()
  return match(expand("%"), "_spec.rb$") != -1
endfunction

function! SetLastSpecCommand(command)
  let t:last_spec_command = a:command
endfunction

function! RunSpecs(command)
  execute ":w\|!clear && echo " . a:command . " && echo && " . a:command
endfunction

nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>t :CtrlP<CR>
nmap <leader>T :CtrlPClearCache<CR>:CtrlP<CR><CR>
nmap <leader>] :TagbarToggle<CR>
nmap <leader><space> :call whitespace#strip_trailing()<CR>
nmap <leader>g :GitGutterToggle<CR>
nmap <leader>c <Plug>Kwbd

let g:ctrlp_match_window = 'order:ttb,max:20'
let g:NERDSpaceDelims=1
"highlight clear SignColumn
let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_realtime = 4000
let g:gitgutter_sign_column_always = 1
let g:airline_symbols = {}
let g:airline_powerline_fonts = 1
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

set t_ku=OA
set t_kd=OB
set t_kr=OC
set t_kl=OD

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column'

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
