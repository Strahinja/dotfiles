set runtimepath^=~/vimfiles runtimepath+=~/vimfiles/after
let &packpath = &runtimepath

" vim: set ft=vim :
let s:cpo_save=&cpoptions
set cpoptions&vim
noremap! <S-Insert> *
vnoremap  "*d
vnoremap gx <Plug>NetrwBrowseXVis
nnoremap gx <Plug>NetrwBrowseX
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()

nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())

command! -bar OpenTodoList cexpr system('ag --stats -G "vue\<bar>js"
            \ "TODO\<bar>FIXME" .') <bar> normal <F7>

function! IDEGrep()
    let text = input('Search text> ')
    let @/ = text
    let IDEGrepFilesPattern = 'vue|js|sass|html|php'
    let cmd = 'ag --stats -G "' . IDEGrepFilesPattern . '" ' . text . ' .'
    cexpr system(cmd) | copen
endfunction

vnoremap <C-Del> "*d
vnoremap <S-Del> "*d
vnoremap <C-Insert> "*y
vnoremap <S-Insert> "-d"*P
nnoremap <S-Insert> "*P
noremap <F4> :NERDTreeToggle<CR>
"noremap <F4> :CtrlPBuffer<CR>
noremap <F5> :tabe
noremap <F6> :vsp
nnoremap <silent> <F7> :copen<CR>
nnoremap <silent> <S-F7> :cclose<CR>
nnoremap <F8> :OpenTodoList<CR>
nnoremap <silent> <C-Up> :cp<CR>
nnoremap <silent> <C-Down> :cn<CR>
nnoremap <F12> :MarkdownPreview<CR>
nnoremap <C-Tab> :tabn<CR>
nnoremap <C-S-Tab> :tabp<CR>
"nmap <Tab> :bnext<CR>
"nmap <S-Tab> :bprevious<CR>
nnoremap <Tab> :CtrlSpaceGoDown<CR>
nnoremap <S-Tab> :CtrlSpaceGoUp<CR>
nmap <C-CR> i<CR><Esc>
nmap <C-P> <C-Space>O<CR>
"nnoremap <C-/> :FZF<CR>
nnoremap <C-/> :call IDEGrep()<CR>
nmap <C-S-T> :Tagbar<CR>
"nmap <C-Q> :bdelete<CR>
nmap <C-Q> <C-Space>c<CR>
"nmap <C-X> :tabclose<CR>
nmap <C-X> <C-Space>lc
nmap <C-;> i<C-k>:9<C-k>"6<Esc>i
imap <C-;> <C-k>:9<C-k>"6<Esc>i
nmap <leader>p :ALEFix<CR>
nnoremap <leader>s :CtrlSpaceSaveWorkspace<CR>
nnoremap <leader><Space> :nohlsearch<CR>
cabbrev h vertical botright help

let &cpoptions=s:cpo_save
unlet s:cpo_save
set background=dark
set guifont=PxPlus_IBM_VGA8\ NF:h12:cRUSSIAN:qCLEARTYPE
set guifontwide=PxPlus_IBM_VGA8\ NF:h12:cRUSSIAN:qCLEARTYPE
set helplang=en

filetype off                  " required

" set the runtime path to include Vundle and initialize
set runtimepath+=~/vimfiles/bundle/Vundle.vim
call vundle#begin('~/vimfiles/bundle/')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Doesn't work
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'tommcdo/vim-fubitive'
Plugin 'jreybert/vimagit'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Yggdroot/indentLine'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'majutsushi/tagbar'

"Plugin 'lithammer/vim-eighties'
"Plugin 'sainnhe/vim-color-lost-shrine'
"Plugin 'jaredgorski/SpaceCamp'
Plugin 'elmindreda/vimcolors'
Plugin 'tpope/vim-characterize'
"Plugin 'leafOfTree/vim-vue-plugin'
Plugin 'posva/vim-vue'
Plugin 'leafgarland/typescript-vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets' " Snippet definitions for UltiSnips
Plugin 'dense-analysis/ale'
Plugin 'neoclide/coc.nvim', {'pinned': 1}
Plugin 'ap/vim-css-color'

"Plugin 'junegunn/fzf'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'
Plugin 'ryanoasis/vim-devicons'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'liuchengxu/vista.vim'
"Plugin 'vifm/vifm.vim'
Plugin 'digitaltoad/vim-pug'
Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

Plugin 'vim-ctrlspace/vim-ctrlspace'
Plugin 'tpope/vim-surround'

" All of your Plugins must be added before the following line
call vundle#end()            " required
set autoindent
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

colors phosphor
"set t_md=
syntax on
set hidden
set fileformat=unix
set fileformats=unix,dos
set laststatus=2
set showcmd " show leader
set timeoutlen=3000 " leader timeout
set guioptions=    " like console vim
set columns=162 " 2 split buffers
set lines=999
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set number
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set textwidth=80
set inccommand=nosplit
set switchbuf+=usetab
""set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1
"set sessionoptions=winsize,winpos,terminal,tabpages,sesdir,resize,buffers,blank

let g:python_host_prog = "c:/Python27/python.exe"
let g:python3_host_prog = "C:/Users/Strahinja/AppData/Local/Programs/Python/Python38-32/python.exe"
"let g:python3_host_prog = "c:/Python34/python.exe"

let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
"let g:UltiSnipsJumpForwardTrigger = "<c-j>"
"let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:CtrlSpaceUseTabline = 1
let g:CtrlSpaceDefaultMappingKey = "<C-space> "
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
let g:CtrlSpaceUseMouseAndArrowsInTerm = 1

let g:airline_powerline_fonts = 1
let g:airline_theme='luna'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#ctrlspace#enabled = 1
let g:airline#extensions#tabline#ctrlspace_show_tab_nr = 0
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffers_label = "\ufb18"
let g:airline#extensions#tabline#tabs_label = "\uf9e8"
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#vista#enabled = 1
let g:airline_exclude_preview = 1
call airline#parts#define('mode', {
            \ 'function': 'airline#parts#mode',
            \ 'accent': 'none',
            \ })
call airline#parts#define('linenr', {
            \ 'raw': '%{g:airline_symbols.linenr}%4l',
            \ 'accent': 'none'})
call airline#parts#define('maxlinenr', {
            \ 'raw': '/%4L%{g:airline_symbols.maxlinenr}',
            \ 'accent': 'none'})

let g:ale_set_signs = 1
let g:ale_sign_error = "\uf0e7"
let g:ale_sign_warning = "\uf071"
let g:ale_linter_aliases = {
            \ 'vue': ['vue', 'javascript']
            \ }
let g:ale_linters = {
            \ 'css': ['stylelint'],
            \ 'sass': ['sasslint'],
            \ 'json': ['jsonlint'],
            \ 'javascript': ['eslint'],
            \ 'markdown': ['markdownlint'],
            \ 'typescript': ['tslint'],
            \ 'vue': ['eslint', 'stylelint', 'puglint'],
            \ 'vim': ['vint'],
            \ 'pug': ['puglint']
            \ }
let g:ale_fixers = {
            \ 'css': ['stylelint'],
            \ 'sass': ['stylelint'],
            \ 'json': ['fixjson'],
            \ 'typescript': ['tslint'],
            \ 'vue': ['eslint', 'stylelint'],
            \ 'javascript': ['eslint']
            \ }
let g:ale_fix_on_save = 1   " Careful, interaction with prettier below

let g:coc_global_extensions = [
            \ 'coc-css',
            \ 'coc-emoji',
            \ 'coc-eslint',
            \ 'coc-git',
            \ 'coc-tsserver',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-marketplace',
            \ 'coc-sql',
            \ 'coc-syntax',
            \ 'coc-ultisnips',
            \ 'coc-vetur',
            \ 'coc-tag',
            \ 'coc-lines'
            \ ]

"let g:ctrlp_use_caching = 1
if executable('rg')
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
endif

if executable('ag')
    let g:CtrlSpaceGlobCommand = 'ag -l --hidden --nocolor -g ""'
endif

if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

let g:NERDTreeDirArrowExpandable="\u25ba"
let g:NERDTreeDirArrowCollapsible="\u25bc"
let g:NERDTreeWinSize = 25

let g:vue_pre_processors = ['pug', 'sass']

let g:gutentags_add_default_project_roots = 0
let g:gutentags_define_advanced_commands = 1
"let g:gutentags_trace = 1
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = 'c:\\progra~2\\vim\\.cache\\vim\\ctags'  "expand('~/.cache/vim/ctags')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
    \ '--tag-relative=yes',
    \ '--fields=+ailmnS',
    \ ]
let g:gutentags_ctags_exclude = [
    \ '*.git', '*.svg', '*.hg',
    \ '*/tests/*',
    \ 'build', 'dist', '*sites/*/files/*',
    \ 'bin', 'node_modules', 'bower_components',
    \ 'cache', 'compiled', 'docs', 'example',
    \ 'bundle', 'vendor', '*.md', '*.lock.json',
    \ '*.lock', '*bundle*.js', '*build*.js',
    \ '.*rc*', '*.json', '*.min.*', '*.map',
    \ '*.bak', '*.zip', '*.pyc', '*.class',
    \ '*.sln', '*.Master', '*.csproj', '*.tmp',
    \ '*.csproj.user', '*.cache', '*.pdb', 'tags*',
    \ 'cscope.*', '*.css', '*.less', '*.scss',
    \ '*.exe', '*.dll', '*.mp3', '*.ogg', '*.flac',
    \ '*.swp', '*.swo', '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
    \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
    \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
    \ ]

"let g:vim_vue_plugin_debug = 1
"let g:vim_vue_plugin_use_foldexpr = 0

augroup automatic_nerd_tree_startup
    autocmd!
"    "autocmd StdInReadPre * let s:std_in=1
"    "autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | call feedkeys("\<C-W>w") | endif
    autocmd VimEnter * NERDTree | wincmd p
augroup END

augroup no_open_in_nerd_tree_window
    autocmd!
    autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
augroup END

augroup setup_folding
    autocmd!
    autocmd Syntax c,cpp,vim,xml,html,xhtml,vue,json setlocal foldmethod=syntax
    autocmd Syntax c,cpp,vim,xml,html,xhtml,vue,json normal zR
augroup END

let g:gitgutter_sign_added = "\uf914"
let g:gitgutter_sign_modified = "\ufb4e"
let g:gitgutter_sign_removed = "\ufaac"
let g:gitgutter_sign_removed_first_line = "\ufaac"
let g:gitgutter_sign_modified_removed = "\ufbc7"

"let g:gitgutter_sign_added = "\uf457"
"let g:gitgutter_sign_modified = "\uf459"
"let g:gitgutter_sign_removed = "\uf458"
"let g:gitgutter_sign_removed_first_line = "\uf458"
"let g:gitgutter_sign_modified_removed = "\uf474"

let g:indentLine_color_gui = '#003000'
let g:indentLine_char = '|'

