
"tell the term has 256 colors
set t_Co=256

"split bar styling
set fillchars+=vert:\ 

"colorscheme pencil
colorscheme one
let g:pencil_gutter_color = 1      " 0=mono (def), 1=color

"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

au FileType python setlocal formatprg=autopep8\ -

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Required
Plugin 'gmarik/Vundle.vim'

Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/syntastic'
Plugin 'mattn/emmet-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
" Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/vim-easy-align'
Plugin 'godlygeek/tabular'
" http://vimawesome.com/plugin/jedi-vim
Plugin 'davidhalter/jedi-vim'
" Plugin 'nvie/vim-flake8'
Plugin 'tell-k/vim-autopep8'
Plugin 'fisadev/vim-isort'
" Plugin 'joonty/vdebug'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'mileszs/ack.vim'
Plugin 'fatih/vim-go'
Plugin 'mbbill/undotree'
Plugin 'asins/vimcdoc'
Plugin 'rust-lang/rust.vim'
Plugin 'reedes/vim-colors-pencil'
" Plugin 'honza/vim-snippets'
" Plugin 'SirVer/ultisnips'
Plugin 'thinca/vim-quickrun'
Plugin 'janko-m/vim-test'
" https://github.com/kannokanno/previm/blob/master/README-en.mkd
Plugin 'kannokanno/previm'
Plugin 'tobys/vmustache' " pdv依赖
Plugin 'tobys/pdv'
"Plugin 'posva/vim-vue'
Plugin 'Shougo/vimproc.vim'
Plugin 'shougo/vimshell.vim'
" https://wakatime.com/vim


"All of your Plugins must be added before the following line
call vundle#end()

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set number      "show line numbers

"display tabs and trailing spaces
set list
set listchars=tab:>-,trail:⋅,nbsp:⋅

set ic

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set wrap        "dont wrap lines
set linebreak   "wrap lines at convenient points

set encoding=utf-8
set fileencoding=utf-8

set nobackup

"undo settings
if v:version >= 703

    if !isdirectory($HOME."/.vim/undo-dir")
        call mkdir($HOME."/.vim/undo-dir", "", 0700)
    endif

    set undodir=~/.vim/undo-dir
    set undofile

    set colorcolumn=+1 "mark the ideal max text width

endif

if !isdirectory($HOME."/.vim/swapfiles")
    call mkdir($HOME."/.vim/swapfiles", "", 0700)
endif
set directory=~/.vim/swapfiles//

"default indent settings
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype vue setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set foldlevel=9
"set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

set wildignore+=*.pyc

"some stuff to get the mouse going in term
set mouse=v
set ttymouse=xterm2

"hide buffers when not displayed
set hidden

iabbrev teh the

set ignorecase
set smartcase
set smartindent

"statusline setup
set statusline =%#identifier#
set statusline+=[%f]    "tail of the filename
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#warningmsg#
set statusline+=%m
set statusline+=%*

set statusline+=%{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)
    let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
    return filter(line_lens, 'v:val > threshold')
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

"syntastic settings
let syntastic_stl_format = '[Syntax: %E{line:%fe }%W{#W:%w}%B{ }%E{#E:%e}]'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_checkers = ["python"]
let g:syntastic_php_checkers = ["php", "phpmd"]
let g:syntastic_php_phpmd_post_args = "~/.vim/phpmd_rulesets/unused_code.xml"
"let g:syntastic_php_phpcs_args = "--encoding=utf-8 --standard=PSR2"

"nerdtree settings
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeIgnore = ['\.pyc']
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeMinimalUI = 0
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeHighlightCursorline = 1

"nerdtree-tabs settings
map <Leader>n <plug>NERDTreeTabsToggle<CR>
map <Leader>f <plug>NERDTreeTabsOpen<CR><C-w><C-w><plug>NERDTreeTabsFind<CR>
let g:nerdtree_tabs_open_on_console_startup = 0
let g:nerdtree_tabs_autofind = 0
let g:nerdtree_tabs_focus_on_files = 0

"dont load csapprox if we no gui support - silences an annoying warning
if !has("gui")
    let g:CSApprox_loaded = 1
endif

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Vdebug options
let g:vdebug_options= {
\    "port"               : 9070,
\    "server"             : "",
\    "timeout"            : 20,
\    "on_close"           : "detach",
\    "break_on_open"      : 0,
\    "ide_key"            : "ly",
\    "path_maps"          : {},
\    "debug_window_level" : 0,
\    "debug_file_level"   : 0,
\    "debug_file"         : "/tmp/xdebug.log",
\    "watch_window_style" : "expanded",
\    "marker_default"     : "⬦",
\    "marker_closed_tree" : "▸",
\    "marker_open_tree"   : "▾"
\}

"ctrlp plugin
let g:ctrlp_map = "<Leader>m"
let g:ctrlp_cmd = "CtrlPCurWD"

"tagbar plugin
nmap <C-f>s :TagbarToggle<CR>

"PHP documenter script
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
autocmd FileType php nnoremap <buffer> <C-p> :call pdv#DocumentWithSnip()<CR>

"airline settings
let g:airline_theme="pencil"

"undotree
map <Leader>z <plug>UndotreeToggle<CR>

"rust lang
let g:rustfmt_autosave = 1

"go lang
let g:go_fmt_autosave = 1

"vim-gitgutter
"let g:gitgutter_sign_column_always = 1
nmap ]g <Plug>GitGutterNextHunk
nmap [g <Plug>GitGutterPrevHunk

"make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

"better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"Previm (:help g:previm_open_cmd for more details)
let g:previm_open_cmd = 'open -a Safari'
let g:previm_show_header = 0

"Vim plugin to sort python imports using isort
let g:vim_isort_map = ''

" Vimshell
let g:vimshell_prompt = 'bash% '
let g:vimshell_data_directory = $HOME . "/.vim/vimshell"

