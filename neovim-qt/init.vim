" Vim with all enhancements
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936
if has("gui_running")
    set guifont=agave\ NF:h12
endif
set termguicolors
colorscheme NeoSolarized
syntax enable
set background=dark
"生成中间文件
set backup
set swapfile
set undofile
" 生成中间文件，保存到其它目录不污染本目录
set undodir=$HOME/vimfiles/undodir
set directory^=$HOME/vimfiles/swapdir
set backupdir^=$HOME/vimfiles/backdir
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 设置文件的历史记录
set history=1000
set clipboard+=unnamed

set vb t_vb= " 不让vim发出讨厌的滴滴声
" 光标移动到buffer的顶部和底部时保持3行距离,窗口滚动最小距离
set scrolloff=3
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
set expandtab
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
" auto skip to the middle of characters below.
inoremap () ()<Left>
inoremap （） （）<Left>
inoremap [] []<Left>
inoremap 【】 【】<Left>
inoremap {} {}<Left>
inoremap ｛｝ ｛｝<Left>
inoremap <> <><Left>
inoremap 《》 《》<Left>
inoremap "" ""<Left>
inoremap “” “”<Left>
inoremap '' ''<Left>
inoremap ’’ ’’<Left>
" leader 键
let g:mapleader=","
" 编辑模式 leader+w 保存当前文件
imap ,w <esc>:w<CR>
" 使用 jj 进入 normal 模式
imap jj <Esc>l
inoremap <C-l> <C-o>A
" 正常模式下 leader+e 退出当前buffer
noremap <leader>e :q<cr>
" leader+b 切换 buffer
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

" 复制不剪切
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d

" set paste
noremap <Leader>c :set paste<CR>:set mouse-=a<CR>:tabnew<CR><C-o>:NERDTreeClose<CR>:set nonu<CR>i
noremap <Leader>nc :set nopaste<CR>:set mouse+=a<CR>:set nu<CR>:wq<CR>:tabp<CR>
" remove space on the rear
autocmd BufWritePre * :%s/\s\+$//e
" replace tab with 4 spaces
"autocmd BufWritePre * :%retab

"nerdtree
"start nerdtree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
"when nerdtree is the last window, then close the vim.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif
" Start NERDTree when Vim starts with a directory argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

"when creating a new tab, copy a mirror of nerdtree.
let g:nerdfocus = 1

function FocusNerdTree()
    if g:nerdfocus == 0
        silent NERDTreeMirror
        silent NERDTreeFocus
        let g:nerdfocus = 1
    else
        let g:nerdfocus = 0
        silent NERDTreeClose
    endif
endfunction


nmap <C-c> :call FocusNerdTree()<CR>

"leaderf
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
" ctags/gtags
set tags=./.tags;,.tags
"" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
"
"" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
    let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
endif
" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

"" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--pythton-kinds=+zl']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0

"检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" gtags-cscope
set cscopeprg='gtags-cscope'
let GtagsCscope_Auto_Map = 1
noremap <silent> <leader>h :GtagsCscope<cr>

" vim-format
" codeformat
noremap <F3> :Autoformat<CR>
" c
"let g:formatdef_astyle_c = '"astyle --mode=c --style=mozilla --attach-namespaces -pcH".(&expandtab ? "s".shiftwidth() : "t")'
"let g:formatters_c = ['astyle_c']

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

" vim-terminal-help
" let g:terminal_shell='D:/Program Files/MSYS2/msys2_shell.cmd -defterm -here -no-start -mingw64'

" gvim
"markdown
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

nmap <C-p> <Plug>MarkdownPreview
nmap <C-s> <Plug>MarkdownPreviewStop

" vim-latex
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on
let g:tex_flavor='latex'
set iskeyword+=:
let g:Tex_CompileRule_pdf='xelatex -interaction=nonstopmode $*'
"let g:Tex_CompileRule_pdf='pdflatex -synctex=1 --interaction=nonstopmode $*'
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_ViewRule_pdf = 'okular'
"noremap <Leader>ll :set nopaste<CR>:set mouse+=a<CR>:set nu<CR>:wq<CR>:tabp<CR>
imap <Leader>lc <ESC>:w<CR><Leader>ll<ESC>i
nmap <Leader>lc :w<CR><Leader>ll

function ClearLatexCaches()
    let currFileName = expand('%:r')
    let cmd = printf("!del %s.log %s.aux", currFileName, currFileName)
    silent exec cmd
endfunction

nmap <Leader>lr :call ClearLatexCaches()<CR>

" QuickPreview
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
noremap <m-u> :PreviewScroll -1<cr>
noremap <m-d> :PreviewScroll +1<cr>
inoremap <m-u> <c-\><c-o>:PreviewScroll -1<cr>
inoremap <m-d> <c-\><c-o>:PreviewScroll +1<cr>

"vim-plug
call plug#begin('~/.vim/plugged')
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'vim-latex/vim-latex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'skywind3000/vim-terminal-help'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':CocInstall coc-json coc-tsserver coc-pyright coc-clangd coc-snippets coc-vetur'}
Plug 'overcache/NeoSolarized', {'do': 'XCOPY %USERPROFILE%\.vim\plugged\NeoSolarized\colors\* %USERPROFILE%\AppData\Local\nvim\colors'}
Plug 'preservim/nerdtree'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'skywind3000/vim-preview'
Plug 'honza/vim-snippets'
Plug 'pechorin/any-jump.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'prettier/vim-prettier'
call plug#end()
