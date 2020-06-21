"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'                  " Theme so vim doesn't look bad
Plug 'preservim/nerdtree'               " Browse files within vim
Plug 'lervag/vimtex'                    " LaTeX support
Plug 'Chiel92/vim-autoformat'           " Autoformatter
Plug 'mbbill/undotree'                  " A nice undo-tree viewer
Plug 'plasticboy/vim-markdown'          " Markdown support
Plug 'tpope/vim-fugitive'               " Git integration
Plug 'tpope/vim-surround'               " Surround text with arbitrary characters
Plug 'kamykn/popup-menu.nvim'           " Needed for spelunker
Plug 'kamykn/spelunker.vim'             " Better spell checker
Plug 'cespare/vim-toml'                 " toml syntax highlighting
Plug 'rust-lang/rust.vim'               " add some support for rust
Plug 'Plug majutsushi/tagbar'           " used for navigating tags
Plug 'vim-airline/vim-airline'          " better command line
Plug 'vim-airline/vim-airline-themes'   " pretty airline
Plug 'majutsushi/tagbar'                " for tag naviagtion
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"configure colorscheme
set t_Co=256
let gruvbox_italic=1
colorscheme gruvbox
set background=dark

" turn syntax highlighting on
syntax on

" no annoying bells
set noerrorbells

"configure tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" indent for me please
set smartindent

" line numbers are essential
set nu rnu

" makes it easy to see what line i'm on
set cursorline

" autoread when an external command is run
set autoread

" i want to be able to see everything
set wrap

" be smart when searching
set ignorecase
set smartcase
set incsearch
set hlsearch

"remove backups and store an undo file
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.undo
set undofile

" auto ave if buffer ahd been updated
autocmd CursorHold * update

" recievedhighlight the 88th column because that's how wide this window normally is
"set colorcolumn=87
"highlight ColorColumn ctermbg=0 guibg=lightgrey

"let me see lines around the cursor
set so=10
set scrolloff=10

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" highlight matching brackets
set showmatch

" automatically line break
set lbr
set tw=200

" set fold to use indents
set foldmethod=indent

" set folds to always be open when a file is opened
set foldlevel=50

" enable tags in rust files
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Remaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=" "

" open vim config
nnoremap <leader>vc :edit ~/.config/nvim/init.vim<cr>
" source vim config (reload settings)
nnoremap <leader>vs :so ~/.config/nvim/init.vim<cr>

"open .zshrc
nnoremap <leader>vz:edit ~/.zshrc<cr>

" Keep cursor in the middle of the screen
"nnoremap j jzz
"nnoremap k kzz
nnoremap E ea

map <F2> :NERDTreeToggle<CR>

" quickly save and exit
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>z :wq<cr>

" move between buffers
nnoremap <leader>n :bn<cr>
nnoremap <leader>N :bp<cr>

" Remove highlighting from previous search
nmap <leader><space> :noh<cr>
"
" add mappings to quickly capitalise and un-capitalise single letters
nmap <leader>U vU
nmap <leader>u vu

" Remap ctrl-f to exit insert mode
imap <c-f> <esc>

" Move a line of text using CTRL+ALT+[j/k]
nmap <c-m-j> mz:m+<cr>`z
nmap <c-m-k> mz:m-2<cr>`z
vmap <c-m-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <c-m-k> :m'<-2<cr>`>my`<mzgv`yo`z

" configure spelling shortcuts
"replace with first suggestion
nmap <leader>sf Zl<cr>
" type replacement
nmap <leader>sc Zc
nmap <leader>SC ZC
" give drop down menu
nmap <leader>ss Zl
nmap <leader>SS ZL
" add word to dictionary
nmap <leader>sg Zg
" remove word from dictionary
nmap <leader>sr :!delete_word <cword><cr>
" navigation
nmap [s ZP
nmap ]s ZN

"get word count for latex file
nmap <F3> :w !detex \| wc -w<CR>

" run current file
nmap <leader>te :term<cr>a

" insert semi colon
nnoremap <leader>; mzA;<esc>`z:delmarks z<cr>
nnoremap <leader>, mzA,<esc>`z:delmarks z<cr>

" some useful navigation stuff
nnoremap <leader>ll A<esc>
nnoremap <leader>hh I<esc>
nnoremap <leader>l <c-w>l
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k

" create splits
nnoremap <leader>sv :vsplit<cr><c-w>l
nnoremap <leader>sh :split<cr><c-w>j
"nnoremap <leader>wo <c-w>o

nnoremap <leader>e :edit<space>

nnoremap <leader>tt :TagbarToggle<cr>

nnoremap <leader>ff :call Flip()<cr>
function! Flip()
    let char = matchstr(getline('.'), '\%' . col('.') . 'c.')
    if char == "<"
        call feedkeys("\s>\<ESC>")
    elseif char == ">"
        call feedkeys("\s<\<ESC>")
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if hidden is not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=1

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes


vnoremap <tab> <Plug>(coc-snippets-select)
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>fc  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Snippet "next" keybind
let g:coc_snippet_next = '<tab>'

"Make <nab> and <s-tab> work like in vscode
inoremap <silent><expr> <tab>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<c-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<cr>" :
            \ <SID>check_back_space() ? "\<tab>" :
            \ coc#refresh()
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

""" Vim-markdown
let g:vim_markdown_math = 1
let g:vim_markdown_strikethrough = 1

" Autoformat on write
autocmd FileType tex let b:autoformat_autoindent=0
au BufWrite *.c,*.h,*.hpp,*.cpp,*.tex :Autoformat



""" Vimtex
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
            \'Double space found.'."\n"
let g:Tex_IgnoreLevel = 8
let g:vimtex_quickfix_open_on_warning = 0
"let g:vimtex_quickfix_autoclose_after_keystrokes=1

" Configure spelunker
" enable spelunker
let g:enable_spelunker_vim = 1

" Check spelling for words longer than set characters. (default: 4)
let g:spelunker_target_min_char_len = 1

" Max amount of word suggestions. (default: 15)
let g:spelunker_max_suggest_words = 10

" Max amount of highlighted words in buffer. (default: 100)
let g:spelunker_max_hi_words_each_buf = 1000

" Spellcheck type: (default: 1)
" 1: File is checked for spelling mistakes when opening and saving. This
" may take a bit of time on large files.
" 2: Spellcheck displayed words in buffer. Fast and dynamic. The waiting time
" depends on the setting of CursorHold `set updatetime=1000`.
let g:spelunker_check_type = 2
" Disable default autogroup. (default: 0)
let g:spelunker_disable_auto_group = 1

" Create own custom autogroup to enable spelunker.vim for specific filetypes.
set nospell
augroup spelunker
    autocmd!
    autocmd FileType *.tex, *.md call spelunker#check()
"  autocmd CursorHold *.tex, *.md call spelunker#check_displayed_words()
augroup END

" configure gtfo vim
let g:gtfo#terminals = { 'unix': 'terminator -cd' }

" airline theme
let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline_powerline_fonts = 1
let g:airline_extensions =['tagbar']
