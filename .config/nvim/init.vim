let mapleader=" "

" =============================================================================
" # PLUGINS
" =============================================================================
call plug#begin()
" Load plugins
" VIM enhancements
Plug 'ciaranm/securemodelines'
Plug 'editorconfig/editorconfig-vim'
Plug 'kamykn/spelunker.vim'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'preservim/tagbar'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'kamykn/popup-menu.nvim'
Plug 'junegunn/vim-emoji'
Plug 'preservim/nerdtree'


" themes
Plug 'arcticicestudio/nord-vim'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.cache/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntactic language support
Plug 'OmniSharp/omnisharp-vim'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'elzr/vim-json'
Plug 'rust-lang/rust.vim'
Plug 'godlygeek/tabular'
Plug 'lervag/vimtex'

" Cpp specific support
Plug 'rhysd/vim-clang-format'
Plug 'vim-syntastic/syntastic'
call plug#end()

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

set guifont=Fira\ Code:10pt

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOUR SCHEME                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let scheme = 'gruvbox'
" Configure colorscheme
set background=dark

if scheme == 'tomorrow-night'
    colorscheme Tomorrow-Night
elseif scheme == 'gruvbox'
    set t_Co=256
    let gruvbox_italic=1
    let g:gruvbox_contrast_dark="hard"
    colorscheme gruvbox
elseif scheme == 'nord'
    let g:nord_bold = 1
    let g:nord_italic = 1
    colorscheme nord
elseif scheme == 'dracula'
    let g:dracula_bold = 1
    let g:dracula_italic = 1
    let g:dracula_colorterm = 1
    colorscheme dracula
else
    colorscheme base16-default-dark
    let base16colorspace=256
    set termguicolors
    function! s:base16_customize() abort
        call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")
    endfunction
    
    augroup on_change_colorschema
      autocmd!
      autocmd ColorScheme * call s:base16_customize()
    augroup END
endif

" automatically change to gruv box when latex or markdown file is entered
"au BufRead *.tex,*.md call SetGruvbox()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEXT FORMATTING                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
" Line numbers
" current line has actual line number
" other lines are relative
set nu rnu
" Highlight matching brackets
set showmatch

" Easier to see what line I'm on
set cursorline

" Don't wrap long lines by default
set nowrap

" If we are wrapping then wrap sensibly
set lbr

" Wrap at 115 characters
set tw=115

" Just in case I want wrapping
nnoremap <leader>l :set wrap!<CR>

" Open a terminal split
nnoremap <leader>te :split<CR>:term<CR>:resize 10<CR>GA


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SETTINGS                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Omnisharp
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_findusages = 'fzf'
let g:OmniSharp_highlighting = 1


" Configure emojis 
set completefunc=emoji#complete
nnoremap <silent> <Leader><Bslash> :s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>:noh<CR>

let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "colorcolumn"
                \ ]

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" Latex
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SPELLING SETTINGS                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable vim's spell checker
set nospell 
set spelllang=en_gb

" Auto capitalise i to I 
autocmd BufRead *.tex,*md ab i I

" Enable spelunker.vim
let g:enable_spelunker_vim = 1

" Check all words
let g:spelunker_target_min_char_len = 1

" 10 is usually enough
let g:spelunker_max_suggest_words = 10

" default of 100 is not enough if I open a big file
let g:spelunker_max_hi_words_each_buf = 250

" Spellcheck type: (default: 1)
let g:spelunker_check_type = 1

" 1: Highlight all types (SpellBad, SpellCap, SpellRare, SpellLocal).
let g:spelunker_highlight_type = 1

" Disable URI checking
let g:spelunker_disable_uri_checking = 1

" Disable acronym checking because I use them a lot
let g:spelunker_disable_acronym_checking = 1

" Disable checking words in backtick/backquote so it doesn't check code blocks
let g:spelunker_disable_backquoted_checking = 1

" Disable default autogroup I will use my own
let g:spelunker_disable_auto_group = 1

" Custom autogroup
augroup spelunker
  autocmd!
  " Setting for g:spelunker_check_type = 1:
  autocmd BufWinEnter,BufWritePost *.vim,*.json,*.md,*.tex call spelunker#check()

  " Setting for g:spelunker_check_type = 2:
  autocmd CursorHold *.vim,*.json,*.md,*.tex call spelunker#check_displayed_words()
augroup END

" Override highlight group name of incorrectly spelled words. (default:
" 'SpelunkerSpellBad')
let g:spelunker_spell_bad_group = 'SpelunkerSpellBad'

" Override highlight group name of complex or compound words. (default:
" 'SpelunkerComplexOrCompoundWord')
let g:spelunker_complex_or_compound_word_group = 'SpelunkerComplexOrCompoundWord'

" Override highlight setting.
highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#9e9e9e
highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYBIND SETTINGS                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Type replacement
nmap <leader>sc Zc
nmap <leader>SC ZC

" Give drop down menu
nmap <leader>ss Zl
nmap <leader>SS ZL

" Add word to dictionary
nmap <leader>sg Zg

" Remove word from dictionary
nmap <leader>sr :!delete_word <cword><cr>

" Next spelling error
nmap <leader>sp ZP
" Previous spelling error
nmap <leader>sn ZN

" NERDTree binds
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>y :NERDTreeFind<CR>

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" Quick-save
nmap <leader>w :w<CR>

" Don't confirm .lvimrc
let g:localvimrc_ask = 0

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" Completion
" Better display for messages
set cmdheight=1
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITOR SETTINGS                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
set autoindent
set timeoutlen=300 " http://stackoverflow.co/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=2
set noshowmode
set hidden
set nowrap
set nojoinspaces
let g:sneak#s_next = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter
" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Settings needed for .lvimrc
set exrc
set secure

" Sane splits
set splitright
set splitbelow

" Remove backups and store an undo file
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.cache/vim/undo
set undofile

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Use sensible tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Suspend with Ctrl+f
vnoremap <C-f> :sus<cr>
nnoremap <C-f> :sus<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" don't cut when using x
nnoremap x "_x
vnoremap x "_x

nnoremap <leader>v :CocCommand rust-analyzer.openCargoToml<cr>

map <leader>f :py3f /usr/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:py3f /usr/share/clang/clang-format.py<cr>

" Neat X clipboard integration
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

" <leader>s for Rg search
noremap <leader>s :Rg
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'options': '--tiebreak=index'}, <bang>0)


" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" Move a line of text using CTRL+ALT+[j/k]
nmap <c-m-j> mz:m+<cr>`z
nmap <c-m-k> mz:m-2<cr>`z
vmap <c-m-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <c-m-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Toggle tagbar navigation
nnoremap <leader>tt :TagbarToggle<cr><c-w>l

" open new file using fzf
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fl :Lines<cr>
nnoremap <leader>fg :GFiles<cr>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" <leader>q shows stats
nnoremap <leader>q g<c-g>

" Keymap for replacing up to next _ or -
noremap <leader>m ct_

" Word counting
:noremap <F3> :w !detex \| wc -w<CR>

" I can type :help on my own, thanks.
map <F1> <Esc>
imap <F1> <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC SETTINGS                                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippet "next" keybind
let g:coc_snippet_next = '<tab>'
set sessionoptions+=globals

" 'Smart' nevigation
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"inoremap <silent><expr> <tab>
"            \ pumvisible() ? coc#_select_confirm() :
"            \ coc#expandableOrJumpable() ? "\<c-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<cr>" :
"            \ <SID>check_back_space() ? "\<tab>" :
"            \ coc#refresh()
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" Search workspace symbols.
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" Implement methods for trait
nnoremap <silent> <space>i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Show actions available at this location
nnoremap <silent> <space>a  :CocAction<cr>

""" Vimtex ------------------------------------------------------------
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {
            \ 'backend' : 'nvim',
            \ 'background' : 1,
            \ 'build_dir' : '/tmp/latex',
            \ 'callback' : 1,
            \ 'continuous' : 1,
            \ 'executable' : 'latexmk',
            \ 'options' : [
            \   '-lualatex',
            \   '-shell-escape',
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \ ],
            \}
let g:vimtex_sytax_minted = [
            \ {
            \ 'lang' : 'c',
            \ },
            \ {
            \ 'lang' : 'cpp',
            \ 'environments' : ['cppcode', 'cppcode_test'],
            \ },
            \ {
            \ 'lang' : 'python',
            \ 'ignore' : ['pythonEscape', 'pythonBEscape'],
            \ }
            \ ]
let g:Tex_IgnoredWarnings =
            \'Underfull'."\n".
            \'Overfull'."\n".
            \'specifier changed to'."\n".
            \'You have requested'."\n".
            \'Missing number, treated as zero.'."\n".
            \'There were undefined references'."\n".
            \'Citation %.%# undefined'."\n".
            \'Double space found.'."\n".
            \'Command terminated with space.'."\n"
let g:Tex_IgnoreLevel = 8
let g:vimtex_quickfix_open_on_warning = 0
"let g:vimtex_quickfix_autoclose_after_keystrokes=1

" =============================================================================
" # Autocommands
" =============================================================================

function! Formatonsave()
  let l:formatdiff = 1
  py3f /usr/share/clang/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.orig set readonly
autocmd BufRead *.pacnew set readonly
autocmd BufRead Cargo.lock set readonly

" Leave paste mode when leaving insert made 
autocmd InsertLeave * set nopaste

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Follow Rust code style rules
au Filetype rust set colorcolumn=100

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.xlsx.axlsx set filetype=ruby
autocmd BufRead MakeFile set filetype=make

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

au FileType python let b:coc_root_patterns = ['.git', '.env']
au FileType rust let b:coc_root_patterns = ['.git', '.toml']
" =============================================================================
" # Footer
" =============================================================================

" nvim
if has('nvim')
	runtime! plugin/python_setup.vim
endif

