
" Set leader keys
let mapleader = ' '
let maplocalleader = ' '

nnoremap <leader>pq :source ~/.vimrc<CR>

" Set cursor view
let &t_SI="\e[6 q" " Line cursor in insert mode
let &t_EI="\e[2 q" " Block cursor in normal mode

" Defaults from tpope/vim-sensible
" Setting options
colorscheme desert
set number
set relativenumber
autocmd FileType netrw setlocal relativenumber
set mouse=a
set clipboard=unnamed
set breakindent
set undofile
set ignorecase
set smartcase
set signcolumn=yes
set updatetime=250
set timeoutlen=300
set splitright
set splitbelow
set list
set cursorline
set confirm
set nobackup
set shortmess-=S
set hlsearch
set undodir=~/.vim/undo

" Basic Keymaps
tnoremap <Esc><Esc> <C-\><C-n>

" Split navigation and resizing
" NOTE: do NOT modify any settings for option being setup as Meta key
nnoremap <C-S-h> <C-w>H
nnoremap <C-S-l> <C-w>L
nnoremap <C-S-j> <C-w>J
nnoremap <C-S-k> <C-w>K
nnoremap <M-,> :resize -5<CR> " <Option-l>
nnoremap <M-.> :resize +5<CR> " <option-r>
nnoremap <C-t> :vertical resize +5<CR>
nnoremap <C-x> :vertical resize -5<CR>

" Custom mappings
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
nnoremap <leader>pc :<C-p>
nnoremap <leader>pr :<C-p><CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>zx :q<CR>
inoremap <C-CR> <Esc>o
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzz
nnoremap =ap ma=ap'a
nnoremap <leader>zig :LspRestart<CR>
xnoremap <leader>p "_dP
nnoremap <leader>d "_d
vnoremap <leader>d "_d
noremap <C-[> <Esc>
inoremap <C-[> <Esc>
vnoremap <C-[> <Esc>
xnoremap <C-[> <Esc>
" nnoremap <C-j> :cprev<CR>zz
" nnoremap <C-k> :cnext<CR>zz
" nnoremap <leader>k :lnext<CR>zz
" nnoremap <leader>j :lprev<CR>zz
nnoremap <leader>r :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>bd :bd<CR>

" Toggle Netrw with \ and |
function! ToggleEx(mode)
      if &filetype ==# 'netrw'
            bdelete
      else
            if a:mode ==# 'lex'
                  Lex
                  vertical resize 50
            elseif a:mode ==# 'ex'
                  Ex
            endif

            " Move cursor to current file
            if !empty(expand('#:t'))
                  call search('\<'.escape(expand('#:t'),'.\').'\>')
            endif
      endif
endfunction
nnoremap \ :call ToggleEx('lex')<CR>      "<option-y>

" Neovim default shortcuts
nnoremap [b :bprev<CR>zz
nnoremap ]b :bnext<CR>zz
nnoremap [q :cprevious<CR>zz
nnoremap ]q :cnext<CR>zz
nnoremap [l :lprevious<CR>zz
nnoremap ]l :lnext<CR>zz
nnoremap [t :tprevious<CR>zz
nnoremap ]t :tnext<CR>zz

" Enable syntax highlighting
syntax on
" Plugin manager vim-plug - https://github.com/junegunn/vim-plug
" Installation instructions in README of repo
" Plugins are downloaded in ~/.vim/plugged
" Run PlugInstall

" NOTE: Manual Instructions when vim-plug is NOT available:
" 	Create dir - ~/.vim/pack/<vendor>/start
" 	Download repo as zip, unzip, move folder under "start" dir
" 	To access help docs, add helptags ~/.vim/pack/<vendor>/start/<plugin>/doc
" 	Binary installation in this folder - ~/bin/ OR ~/.local/bin
" 		Add bin folder location to PATH
call plug#begin()

" List your plugins here
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'

" NOTE: for manual download - Use release branch (recommended)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" coc extensions:
let g:coc_global_extensions = ['coc-pyright','coc-snippets','coc-sh','coc-yaml','coc-json']

Plug 'hashivim/vim-terraform'

" NOTE: Download 'fzf' and 'rg'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" For fzf.vim manual installation, if you run :RG, apple might complain saying Apple is being sure rg binary being free of malware
" 	That's because if you run "ls -l@ ~/bin/rg" (assuming manual download
" 	of rg binary), if you see "com.apple.quarantine"
" 	Then run "xattr -d com.apple.quarantine ~/bin/rg". That should remove
" 	that attribute
" 	Run ls command again to verify
Plug 'junegunn/fzf.vim'
" set rtp+=~/.fzf	" For manual installation. See https://github.com/junegunn/fzf/blob/master/README-VIM.md
Plug '/opt/homebrew/opt/fzf'

Plug 'honza/vim-snippets'	" To go with coc-snippets
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'mbbill/undotree'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'

call plug#end()
" Auto-install coc-extensions
autocmd User PlugInstallPost,PlugUpdatePost :CocUpdate

" Enable filetype detection, plugins and indentation
" Needed for tpope/commentary
" filetype plugin indent on   " Covered in tpope/vim-sensible
" helptags ~/.vim/pack/tpope/start/vim-commentary-master/doc
" helptags ~/.vim/pack/tpope/start/vim-jdaddy-master/doc
" helptags ~/.vim/pack/tpope/start/vim-vinegar-master/doc
" helptags ~/.vim/pack/tpope/start/vim-surround-master/doc
" helptags ~/.vim/pack/tpope/start/vim-unimpaired-master/doc
" helptags ~/.vim/pack/tpope/start/vim-fugitive-master/doc
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

" Enable omnifunc for autocompletion
" autocmd FileType python setlocal omnifunc=python3complete#Complete
autocmd FileType vim setlocal omnifunc=syntaxcomplete#Complete

" python syntax
let g:python_highlight_all=1

" dense-analysis/ale config
"helptags ~/.vim/pack/git-plugins/start/ale-master/doc/
"let g:ale_linters={'python': ['ruff','pylsp', 'mypy']}
"let g:ale_python_mypy_options="--ignore-missing-imports --disable-error-code=import-untyped" " ignore warnings for libraries that don't have type info
"let g:ale_fixers={'python': ['ruff', 'isort', 'autopep8']}
"let g:ale_python_autopep8_options='--aggressive'
"let g:ale_completion_enabled=1
"nmap grd :ALEGoToDefinition<CR>
"nmap grr :ALEFindReferences<CR>
"nmap grf :ALEFix<CR>
"nmap grh :ALEHover<CR>

" neoclide/coc
" helptags ~/.vim/pack/neoclide/start/coc.nvim-release/doc
" highlight CocInlayHint ctermbg=none ctermfg=darkyellow
" highlight CocFloatActive ctermbg=none ctermfg=magenta
" highlight CocFloatDividingLine ctermbg=none ctermfg=red
" highlight CocFloatSbar ctermbg=none ctermfg=white

" from https://github.com/neoclide/coc.nvim/tree/release?tab=readme-ov-file
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent><nowait> [d <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]d <Plug>(coc-diagnostic-next)
" GoTo code navigation
nmap <silent><nowait> grd <Plug>(coc-definition)
nmap <silent><nowait> grt <Plug>(coc-type-definition)
nmap <silent><nowait> gri <Plug>(coc-implementation)
nmap <silent><nowait> grr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json,python setl formatexpr=CocAction('formatSelected')
augroup end
" TODO: Test and see if these are needed OR whether to update mappings
" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap gra <Plug>(coc-codeaction-selected)
nmap gra <Plug>(coc-codeaction-selected)
" Remap keys for applying code actions at the cursor position
nmap <leader>cac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>cas  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>cqf  <Plug>(coc-fix-current)
" Remap keys for applying refactor code actions
nmap <silent> <leader>cre <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>cr  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>cr  <Plug>(coc-codeaction-refactor-selected)
" Run the Code Lens action on the current line
nmap <leader>cc  <Plug>(coc-codelens-action)
" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <leader>cla  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <leader>cle  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <leader>clc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <leader>clo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <leader>cls  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <leader>clj  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <leader>clk  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <leader>clp  :<C-u>CocListResume<CR>

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-d> and <C-u> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
  nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
  inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
  vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')
" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" coc-snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap m<C-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>cx  <Plug>(coc-convert-snippet)


" fzf.vim
" helptags ~/.vim/pack/junegunn/start/fzf.vim-master/doc
" Telescope equivalents
nnoremap <leader>sh :Helptags<CR>
nnoremap <leader>sk :Maps<CR>
nnoremap <leader>sf :Files<CR>
" <leader>ss
nnoremap <leader>sw :RG <C-r><C-w><CR>
nnoremap <leader>sg :RG<CR>
" <leader>sd
" <leader>sr
nnoremap <leader>s. :History<CR>
nnoremap <leader><leader> :Buffers<CR>
nnoremap <leader>sc :Commands<CR>
nnoremap <leader>s/ :Lines<CR>
nnoremap <C-p> :GFiles<CR>

" undotree
" helptags ~/.vim/pack/mbbill/start/undotree-master/doc
nnoremap <F5> :UndotreeToggle<CR>

" vim-easymotion
" helptags ~/.vim/pack/easymotion/start/vim-easymotion-master/doc
map  <leader>mf <Plug>(easymotion-bd-f)
nmap <leader>mf <Plug>(easymotion-overwin-f)
map  <leader>mw <Plug>(easymotion-bd-w)
nmap <leader>mw <Plug>(easymotion-overwin-w)

" Other plugins
" helptags ~/.vim/pack/vim-airline/start/vim-airline-master/doc
" helptags ~/.vim/pack/airblade/start/vim-gitgutter-main/doc
" helptags ~/.vim/pack/jiangmiao/start/auto-pairs-master/doc

