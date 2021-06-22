syntax enable
"set background=dark
"禁止生成中间文件
set nobackup
set noswapfile
" 使回格键（backspace）正常处理indent, eol, start等  
set backspace=2
" 允许backspace和光标键跨越行边界  
set whichwrap+=<,>,h,l
" 设置文件的历史记录
set history=1000
" 与windows共享剪切板
set clipboard=unnamedplus
set vb t_vb= " 不让vim发出讨厌的滴滴声
" 光标移动到buffer的顶部和底部时保持3行距离,窗口滚动最小距离
set scrolloff=3
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936 "设置vim自动识别编码
set number "行号
set nocompatible " 使用vim自己的编辑模式
syntax on " 语法高亮
set showmode
set showcmd
set mouse=a
set t_Co=256
filetype indent on
set autoindent
set tabstop=4
set shiftwidth=4
set noexpandtab
set softtabstop=4
set wrap
set linebreak
set wrapmargin=2
set scrolloff=5
set laststatus=2
set ruler
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoread
set listchars=tab:»·,trail:·
set list
set wildmenu
set wildmode=longest:list,full
" use ctrl+h/j/k/l switch window
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" leader 键
let g:mapleader=","
" 插入模式下使用 leader+w 快速保存文件
imap ,w <esc>:w<CR>
" 使用 jj 快速回到 normal 模式
imap jj <Esc>l
inoremap <C-l> <C-o>A
" 使用 leader+e 快速退出窗口(但是不会关闭 buffer)
noremap <leader>e :q<cr>
" 使用 leader+b 快速关闭当前 buffer
noremap <leader>b :bd<cr>
noremap <silent><tab>m :tabnew<cr>
noremap <silent><tab>e :tabclose<cr>
noremap <silent><tab>n :tabn<cr>
noremap <silent><tab>p :tabp<cr>
noremap <silent><leader>t :tabnew<cr>
noremap <silent><leader>g :tabclose<cr>
noremap <silent><leader>1 :tabn 1<cr>
noremap <silent><leader>2 :tabn 2<cr>
noremap <silent><leader>3 :tabn 3<cr>
noremap <silent><leader>4 :tabn 4<cr>
noremap <silent><leader>5 :tabn 5<cr>
noremap <silent><leader>6 :tabn 6<cr>
noremap <silent><leader>7 :tabn 7<cr>
noremap <silent><leader>8 :tabn 8<cr>
noremap <silent><leader>9 :tabn 9<cr>
noremap <silent><leader>0 :tabn 10<cr>
noremap <silent><tab>[ :tabfirst<cr>
noremap <silent><tab>] :tablast<cr>

" set paste
noremap <Leader>c :set paste<CR>
noremap <Leader>nc :set nopaste<CR>

"nerdtree
"start nerdtree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
"when nerdtree is the last window, then close the vim.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif
" Start NERDTree when Vim starts with a directory argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

"when creating a new tab, copy a mirror of nerdtree.
autocmd BufWinEnter * silent NERDTreeMirror
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
nnoremap <C-b> :NERDTreeClose<CR>
"leaderf
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
" coc-vim
" confirm what you select
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" vimux
" Run the current file with rspec
" Run the current file with rspec
map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

" Clear the terminal screen of the runner pane.
map <Leader>v<C-l> :VimuxClearTerminalScreen<CR>

" ctags
set tags=./.tags;,.tags
"" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
"
"" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

"" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
"let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
"vim-plug
call plug#begin('~/.vim/plugged')
Plug 'ryanoasis/vim-devicons'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'honza/vim-snippets'
Plug 'pechorin/any-jump.vim'
Plug 'preservim/vimux'
call plug#end()

