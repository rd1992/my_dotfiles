set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" other plugins
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'edkolev/promptline.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'edkolev/tmuxline.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'ap/vim-css-color'
Plugin 'airblade/vim-gitgutter'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'git@github.com:zopim/vim-jxml'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'w0ng/vim-hybrid'

call vundle#end()

filetype plugin indent on

" Encoding
set encoding=utf-8

" Turn on highlighting for search
set hlsearch

" Turn on incremental search
set incsearch

" Highlight line where the cursor is
set cursorline

" Use relative numbering
set number
set updatetime=250

" Yank to OS X clipboard
set clipboard=unnamed

" Turn on syntax highlighting
syntax on

" Make backspace work like normal
set backspace=indent,eol,start

" Highlight 80th character column 
set colorcolumn=80

" Turn off mouse mode
set mouse-=a

set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set autochdir
set laststatus=2
set noexpandtab
" Make j and k move up and down better for wrapped lines
:noremap k gk
:noremap j gj
:noremap gk k
:noremap gj j

" Maintain selection after indenting
vnoremap > >gv
vnoremap < <gv

" Map F3 and F4 to quick switch between vim buffers
noremap <F3> :bprev<CR>
noremap <F4> :bnext<CR>

" Show invisible chars and trailing spaces
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
" set list

" Folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" Colours
set t_Co=256
set t_ut=
set bg=dark
let g:rehash256 = 1

" Syntastic
let g:syntastic_javascript_checkers = ['jshint']

" Ctrl-P
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_use_caching = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|swo|swp)$'
  \ }

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_theme = 'murmur'

" promptline
let g:promptline_preset = 'full'

" Goyo
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.8

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Goyo
function! s:goyo_enter()
  silent !tmux set status off
  set noshowmode
  set noshowcmd
	set nonu
  set scrolloff=999
  Goyo 150
  Limelight
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Vim-markdown
let g:vim_markdown_folding_disabled=1

" NERDTree
let g:NERDTreeDirArrows=0
let g:NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
map - :NERDTreeToggle<CR>

" Indent Guides
colorscheme hybrid
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=darkgrey ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=236
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 5

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete
au FileType gitcommit set tw=72

" FileType Conversions
au BufNewFile,BufRead *.md setfiletype markdown

" Python
au BufNewFile,BufRead *.py
\set tabstop=8
\set softtabstop=8
\set shiftwidth=8
\set textwidth=79
\set noexpandtab
\set autoindent
\set fileformat=unix

" SuperRetab
:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
:command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" Leader key mappings

" Useful mappings for surrounding words
:nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
:nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" Useful mappings for managing tabs
noremap <leader>tn :tabnew<CR>
noremap <leader>to :tabonly<CR>
noremap <leader>tc :tabclose<CR>
noremap <leader>tm :tabmove

" Goyo
nnoremap <leader>me :Goyo<CR>
nnoremap <leader>mc :Goyo<CR>

" Clear search higlighting
nnoremap <leader><space> :nohlsearch<CR>
"
" Redraw syntax higlighting
nnoremap <leader>sh :sy sync fromstart<CR>

" Remove trailing whitespace
nnoremap <leader>S :%s/\s\+$//<CR>:let @/=''<CR>

" Convenience shortcuts for Vundle
nnoremap <leader>pc :PluginClean<CR>
nnoremap <leader>pi :PluginInstall<CR>
nnoremap <leader>pl :PluginList<CR>
nnoremap <leader>pu :PluginUpdate<CR>

" Convenience shortcuts for Fugitive
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>ga :Gcommit --amend<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>dp :diffput<CR>
nnoremap <leader>dg :diffget<CR>

" Convenience shortcuts for Tab2Space & Space2Tab
nnoremap <leader>t2s :Tab2Space<CR>
vnoremap <leader>t2s :Tab2Space<CR>
nnoremap <leader>s2t :Space2Tab<CR>
vnoremap <leader>s2t :Space2Tab<CR>

" Convenience shortcuts for vimrc & tmux.conf
nnoremap <leader>ev :vsp ~/.vimrc<CR>
nnoremap <leader>sv :source ~/.vimrc<CR>
nnoremap <leader>et :vsp ~/.tmux.conf<CR>
