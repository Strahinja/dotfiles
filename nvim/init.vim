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

" 
" -,-'-,-'-,-'-,- Commands -,-'-,-'-,-'-,-
"
command! -bar OpenTodoList cexpr system('ag --stats -G "vue\<bar>js\<bar>php"
            \ "TODO\<bar>FIXME" .') <bar> normal <F7>
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview',
    \ 'bat --style=numbers --color=always --pager=never --theme=zenburn {}']}, <bang>0)
"fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
command! Bd bp\|bd \#


function! IDEGrep()
    :let text = input('Search text> ')
    :let IDEGrepFilesPattern = 'vue|js|sass|html|php'
    :if l:text != ''
        :let @/ = l:text
        :let cmd = 'ag -Q --stats -G "' . l:IDEGrepFilesPattern . '" ' . l:text . ' .'
        :cexpr system(l:cmd) | :copen
    :else
        :echo "\rCanceled search."
    :endif
endfunction

function! OpenTerm()
    :let l:termbufnr = bufnr('term')
    :if l:termbufnr == -1
        :botright 10:split | :resize 10 | :term 
        :setlocal nonumber norelativenumber
        :execute "normal!i"
    :else
        :execute "botright sbuffer" l:termbufnr
        :setlocal nonumber norelativenumber
        :resize 10 | :execute "normal!i"
    :endif
endfunction

function! OpenTermCommand(command)
    :if a:command != ''
        :let l:openterm_command = a:command
    :else
        :let l:openterm_command = input('Command> ')
    :endif
    :if l:openterm_command != ''
        :let l:termbufnr = bufnr('term')
        :if l:termbufnr == -1
            :botright 10:split | :resize 10 | :term
            :setlocal nonumber norelativenumber
            :call feedkeys("i" . l:openterm_command . "\<CR>\<C-\>\<C-N>G\<C-W>w")
        :else
            :execute "botright sbuffer" l:termbufnr
            :setlocal nonumber norelativenumber
            :resize 10 | :call feedkeys("i" . l:openterm_command . "\<CR>\<C-\>\<C-N>G\<C-W>w")
        :endif
    :else
        :echo "\rCanceled term."
    :endif
endfunction

function! SetLastStatus()
    set laststatus=2
endfunction

" 
" -,-'-,-'-,-'-,- Shortcuts -,-'-,-'-,-'-,-
"
vnoremap <C-Del> "*d
vnoremap <S-Del> "*d
vnoremap <C-Insert> "*y
vnoremap <S-Insert> "-d"*P
nnoremap <S-Insert> "*P

noremap <F3> :NERDTreeFind<CR>
noremap <F4> :NERDTreeToggle<CR>
"noremap <F4> :CtrlPBuffer<CR>
noremap <F5> :tabe
noremap <F6> :vsp
nnoremap <silent> <F7> :copen<CR>
nnoremap <silent> <S-F7> :cclose<CR>
nnoremap <F8> :OpenTodoList<CR>
nnoremap <F9> :so %<CR>
nnoremap <silent> <F10> :call OpenTerm()<CR>
nnoremap <silent> <C-F10> :call OpenTermCommand('')<CR>
nnoremap <F12> :MarkdownPreview<CR>
" Kebab case
vmap <silent> <C-=> :s/\([0-9a-z]\)\([A-Z]\)/\1-\l\2/g<CR>:s/\([A-Z]\)/\l\1/g<CR>
" CamelCase
vmap <silent> <C--> :s/\([0-9a-z]\)-\([a-z]\)/\1\u\2/g<CR>
nnoremap <C-Tab> :tabn<CR>
nnoremap <C-S-Tab> :tabp<CR>
nnoremap <silent> <C-Up> :cp<CR>
nnoremap <silent> <C-Down> :cn<CR>
nmap <C-S-Space> i<Space>
nmap <C-S-Left> :left<CR>
nmap <C-S-Right> :right<CR>
nmap <C-S-Up> :center<CR>
vmap <C-S-Left> :left<CR>gv
vmap <C-S-Right> :right<CR>gv
vmap <C-S-Up> :center<CR>gv
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
nmap <C-CR> i<CR><Esc>
nmap <C-Space> :Buffers<CR>
nmap <C-P> :Files<CR>
nnoremap <C-/> :call IDEGrep()<CR>
nmap <C-S-T> :Tagbar<CR>
nmap <C-Q> :lclose<bar>bp<bar>bd #<CR>
"nmap <C-X> :tabclose<CR>
nmap <M--> i<C-k>-N
imap <M--> <C-k>-N
nmap <C-;> i<C-k>:9<C-k>"6<Esc>i
imap <C-;> <C-k>:9<C-k>"6<Esc>i

nnoremap <silent> <leader>c :set cursorline!<CR>
nmap <leader>d <Plug>(coc-definition)
nnoremap <leader>p :ALEFix<CR>
nmap <leader>r <Plug>(coc-references)
nnoremap <leader>yb :call OpenTermCommand('yarn build')<CR>
nnoremap <leader>yd :call OpenTermCommand('yarn dev')<CR>
nnoremap <leader>ys :call OpenTermCommand('yarn start')<CR>
nnoremap <leader>yt :call OpenTermCommand('yarn test')<CR>
nnoremap <leader>yg :call OpenTermCommand('yarn generate')<CR>
nnoremap <leader>Z :Goyo<CR>
nnoremap <leader><Space> :nohlsearch<CR>
nnoremap <silent><expr> <leader><Tab> "i" . coc#refresh()
inoremap <silent><expr> <leader><Tab> coc#refresh()
cabbrev h only <bar> vertical botright help

" Coc.nvim mappings
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let &cpoptions=s:cpo_save
unlet s:cpo_save
set background=dark
set guifont=PxPlus_IBM_VGA8\ NF:h12:cRUSSIAN:qNOANTIALIAS
set guifontwide=PxPlus_IBM_VGA8\ NF:h12:cRUSSIAN:qNOANTIALIAS
set helplang=en

filetype off                  " required

" 
" -,-'-,-'-,-'-,- Plugins -,-'-,-'-,-'-,-
"
" set the runtime path to include Vundle and initialize
set runtimepath+=~/vimfiles/bundle/Vundle.vim
set runtimepath+=~/scoop/shims
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
Plugin 'enricobacis/vim-airline-clock'

"Plugin 'lithammer/vim-eighties'
"Plugin 'sainnhe/vim-color-lost-shrine'
"Plugin 'jaredgorski/SpaceCamp'
Plugin 'elmindreda/vimcolors'
"Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'dracula/vim'
Plugin 'gosukiwi/vim-atom-dark'
"Plugin 'joshdick/onedark.vim'
Plugin 'flazz/vim-colorschemes'
"Plugin 'sheerun/vim-wombat-scheme'
"Plugin 'maksimr/Lucius2'
"Plugin 'hukl/Smyck-Color-Scheme'
"Plugin 'fenetikm/falcon'
"Plugin 'jnurmine/Zenburn'
"Plugin 'dim13/smyck.vim'
"Plugin 'rhysd/vim-color-shiny-white'
Plugin 'haishanh/night-owl.vim'
Plugin 'juanedi/predawn.vim'
Plugin 'fent/vim-frozen'
Plugin 'ivan-cukic/vim-colors-penultimate'
Plugin 'demorose/up.vim'
Plugin 'orthecreedence/void.vim'
Plugin 'kreeger/benlight'

Plugin 'chrisbra/unicode.vim'
"Plugin 'leafOfTree/vim-vue-plugin'
Plugin 'posva/vim-vue'
Plugin 'leafgarland/typescript-vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets' " Snippet definitions for UltiSnips
Plugin 'dense-analysis/ale'
Plugin 'neoclide/coc.nvim', {'pinned': 1}
Plugin 'ap/vim-css-color'
Plugin 'junegunn/goyo.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'ryanoasis/vim-devicons'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'liuchengxu/vista.vim'
"Plugin 'vifm/vifm.vim'
Plugin 'digitaltoad/vim-pug'
Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

"Plugin 'vim-ctrlspace/vim-ctrlspace'
"Plugin 'jlanzarotta/bufexplorer'
"Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-surround'
Plugin 'DavidEGx/ctrlp-smarttabs'

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

" 
" -,-'-,-'-,-'-,- Colors -,-'-,-'-,-'-,-
"
"colorscheme phosphor
"colorscheme atom-dark
"colorscheme shiny-white
"colorscheme distinguished
colorscheme benlight
let airlineTheme='distinguished'
"let airlineTheme='tomorrow'

" 
" -,-'-,-'-,-'-,- Vanilla -,-'-,-'-,-'-,-
"
"set t_md=
syntax on
set hidden
set fileformat=unix
set fileformats=unix,dos
call SetLastStatus()
set showcmd " show leader
set timeoutlen=3000 " leader timeout
set guioptions=    " like console vim
set columns=162 " 2 split buffers
set lines=999
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set number
set relativenumber
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set textwidth=80
set colorcolumn=80
set cursorline
set inccommand=nosplit
set switchbuf+=usetab
set fillchars=eob:
""set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1

" 
" -,-'-,-'-,-'-,- UltiSnips -,-'-,-'-,-'-,-
"
let g:python_host_prog = "c:/Python27/python.exe"
let g:python3_host_prog = "C:/Users/Strahinja/AppData/Local/Programs/Python/Python38-32/python.exe"
"let g:python3_host_prog = "c:/Python34/python.exe"

let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsExpandTrigger = "<leader><tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" 
" -,-'-,-'-,-'-,- CtrlSpace -,-'-,-'-,-'-,-
"
"let g:CtrlSpaceUseTabline = 1
"let g:CtrlSpaceDefaultMappingKey = "<C-space> "
"if executable("ag")
    "let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
"endif
"let g:CtrlSpaceUseMouseAndArrowsInTerm = 1

" 
" -,-'-,-'-,-'-,- Airline -,-'-,-'-,-'-,-
"
let g:airline_powerline_fonts = 1
"let g:airline_theme='luna'
"let g:airline_theme='dracula'
"let g:airline_theme='lucius'
let g:airline_theme=airlineTheme
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 2
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#error_symbol = "\uf0e7"
let g:airline#extensions#coc#warning_symbol = "\uf071"
let g:airline#extensions#gutentags#enabled = 1
let g:airline#extensions#nerdtree_status = 1
let g:airline#extensions#quickfix#location_text = "\uf124"
let g:airline#extensions#quickfix#quickfix_text = "\uf567"
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#ctrlspace#enabled = 1
"let g:airline#extensions#tabline#ctrlspace_show_tab_nr = 0
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffers_label = "\ufb18"
let g:airline#extensions#tabline#tabs_label = "\uf9e8"
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#vista#enabled = 1
let g:airline_exclude_preview = 1
let g:airline_left_sep = "\uE0B8"
let g:airline_right_sep = "\uE0BA"
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.dirty = "\u26a1"
let g:airline_symbols.readonly = "\uf023"
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

" 
" -,-'-,-'-,-'-,- ALE -,-'-,-'-,-'-,-
"
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
            \ 'typescript': ['eslint'],
            \ 'vue': ['eslint', 'stylelint', 'puglint'],
            \ 'vim': ['vint'],
            \ 'pug': ['puglint']
            \ }
let g:ale_fixers = {
            \ 'css': ['stylelint'],
            \ 'sass': ['stylelint'],
            \ 'json': ['fixjson'],
            \ 'typescript': ['eslint'],
            \ 'vue': ['eslint', 'stylelint'],
            \ 'javascript': ['eslint']
            \ }
let g:ale_fix_on_save = 1   " Careful, interaction with prettier below

"
" -,-'-,-'-,-'-,- fzf -,-'-,-'-,-'-,-
" 
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_colors = 
            \ { 'fg': ['fg', 'Comment'],
            \ 'bg': ['bg', 'Normal'],
            \ 'hl': ['fg', 'Normal'],
            \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Statement'],
            \ 'hl+': ['fg', 'Statement'],
            \ 'border': ['fg', 'Normal'],
            \ 'pointer': ['fg', 'Statement'] }

" 
" -,-'-,-'-,-'-,- Coc -,-'-,-'-,-'-,-
"
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

let g:ctrlp_extensions = ['smarttabs']

"let g:ctrlp_use_caching = 1
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
endif
"if executable('rg')
    "let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    "let g:ctrlp_use_caching = 0
"endif

"if executable('ag')
    "let g:CtrlSpaceGlobCommand = 'ag -l --hidden --nocolor -g ""'
"endif

" 
" -,-'-,-'-,-'-,- NERDTree -,-'-,-'-,-'-,-
"
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

let g:NERDTreeDirArrowExpandable="\u25ba"
let g:NERDTreeDirArrowCollapsible="\u25bc"
let g:NERDTreeWinSize = 25

" 
" -,-'-,-'-,-'-,- vim-vue -,-'-,-'-,-'-,-
"
let g:vue_pre_processors = ['pug', 'sass']
"let g:vim_vue_plugin_debug = 1
"let g:vim_vue_plugin_use_foldexpr = 0
let g:ft = ''
function! NERDCommenter_before()
    if &ft == 'vue'
        let g:ft = 'vue'
        let stack = synstack(line('.'), col('.'))
        if len(stack) > 0
            let syn = synIDattr((stack)[0], 'name')
            if len(syn) > 0
                exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
            endif
        endif
    endif
endfunction
function! NERDCommenter_after()
    if g:ft == 'vue'
        setf vue
        let g:ft = ''
    endif
endfunction

" 
" -,-'-,-'-,-'-,- vim-table-mode -,-'-,-'-,-'-,-
"
let g:table_mode_corner = '|'

" 
" -,-'-,-'-,-'-,- Gutentags -,-'-,-'-,-'-,-
"
let g:gutentags_add_default_project_roots = 0
let g:gutentags_define_advanced_commands = 1
"let g:gutentags_trace = 1
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = 'c:\progra~2\vim\.cache\vim\ctags'  "expand('~/.cache/vim/ctags')
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
    \ 'build', 'dist', '*sites/*/files/*', '.nuxt',
    \ 'static/prezentacije', 'static\prezentacije', 'prezentacije',
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

" 
" -,-'-,-'-,-'-,- Gitgutter -,-'-,-'-,-'-,-
"
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

" 
" -,-'-,-'-,-'-,- Indentline -,-'-,-'-,-'-,-
"
let g:indentLine_color_gui = '#333333'
let g:indentLine_char = '⁞'
"let g:indentLine_char = '|'

"
" -,-'-,-'-,-'-,- Tagbar -,-'-,-'-,-'-,-
" 
let g:tagbar_type_css = {
\ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
\ }
"let g:tagbar_type_typescript = {                                                  
  "\ 'ctagsbin' : 'tstags',                                                        
  "\ 'ctagsargs' : '-f-',                                                           
  "\ 'kinds': [                                                                     
    "\ 'e:enums:0:1',                                                               
    "\ 'f:function:0:1',                                                            
    "\ 't:typealias:0:1',                                                           
    "\ 'M:Module:0:1',                                                              
    "\ 'I:import:0:1',                                                              
    "\ 'i:interface:0:1',                                                           
    "\ 'C:class:0:1',                                                               
    "\ 'm:method:0:1',                                                              
    "\ 'p:property:0:1',                                                            
    "\ 'v:variable:0:1',                                                            
    "\ 'c:const:0:1',                                                              
  "\ ],                                                                            
  "\ 'sort' : 0                                                                    
"\ }
let g:tagbar_type_typescript = {
    \ 'ctagstype': 'typescript',
    \ 'kinds': [
      \ 'c:class',
      \ 'n:namespace',
      \ 'f:function',
      \ 'G:generator',
      \ 'v:variable',
      \ 'm:method',
      \ 'p:property',
      \ 'C:const',
      \ 'i:interface',
      \ 'g:enum',
      \ 't:type',
      \ 'a:alias',
    \ ],
    \'sro': '.',
      \ 'kind2scope' : {
      \ 'c' : 'class',
      \ 'n' : 'namespace',
      \ 'i' : 'interface',
      \ 'f' : 'function',
      \ 'G' : 'generator',
      \ 'm' : 'method',
      \ 'p' : 'property',
      \ 'C' : 'const',
      \},
  \ }
"let g:tagbar_type_vue = {
    "\ 'ctags

" 
" -,-'-,-'-,-'-,- augroups -,-'-,-'-,-'-,-
"
"augroup automatic_nerd_tree_startup
    "autocmd!
""    "autocmd StdInReadPre * let s:std_in=1
""    "autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | call feedkeys("\<C-W>w") | endif
    "autocmd VimEnter * NERDTree | wincmd p
"augroup END

augroup startup_split
    autocmd VimEnter * :vsplit | execute "normal \<C-W>="
    autocmd VimResized * execute "normal \<C-W>="
augroup END

augroup number
    autocmd!
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
    autocmd BufEnter,FocusGained,InsertLeave * if bufname() =~# "^NERD_tree_" 
                \ || bufname() =~# "^__Tagbar__" || bufname() =~# "^term:" | set norelativenumber | else 
                    \ | set relativenumber | endif
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

augroup fzf_no_statusline
    autocmd! FileType fzf set laststatus=2 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

function! s:goyo_enter()
    let g:zenmode_number = &number
    let g:zenmode_relativenumber = &relativenumber
    let g:zenmode_scrolloff = &scrolloff
    set nonumber
    set norelativenumber
    let g:airline_disable_statusline = 1
    set laststatus=0
    set scrolloff=999
endfunction

function! s:goyo_leave()
    if g:zenmode_number == 1
        set number
    else
        set nonumber
    endif

    if g:zenmode_relativenumber == 1
        set relativenumber
    else
        set norelativenumber
    endif
    call SetLastStatus()
    let g:airline_disable_statusline = 0
    execute "set scrolloff=" . g:zenmode_scrolloff
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

