" Leader
let mapleader="\<Space>"

set backspace=indent,eol
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler                 " show cursor position on the cmdline
set showcmd
set incsearch
set laststatus=2
set autowrite

" Disable the annoying welcome message
set shortmess+=I

" switch syntax highlighting on, when the terminal has colors
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last know cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell
augroup END

set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
"set list listchars=tab:»·,trail:·,nbsp:·

if executable('ag')
  " use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " use ag in CtrlP for listing files
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Line numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col -1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Make it clear to the user where the motion keys are--sudo style
nnoremap <Left> :echoe "Are you on drugs?"<CR>
nnoremap <Down> :echoe "Where did you learn to type?"<CR>
nnoremap <Up> :echoe "Wrong! You cheating scum!"<CR>
nnoremap <Right> :echoe "Your mind just hasn't been the same since the electro-shock, has it?"<CR>

" Color scheme
set background=dark
let g:solarized_termtrans = 1
colorscheme solarized
highlight NonText guibg=#060606
highlight Folded guibg=#0A0A0A guifg=#9090D0

" Run commands that require an interactive shell
noremap <Leader>r :RunInInteractiveShell<space>

" Re-balance windows on vim resize
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" TODO
"nnoremap <leader>irb :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'irb'}<cr>
" VTR - Vim tmux integration
let g:VtrUseVtrMaps = 1
let g:VtrGitCdUpOnOpen = 0
let g:VtrPercentage = 30

nnoremap <leader>va :VtrAttachToPane<cr>
nmap <leader>fs :VtrFlushCommand<cr>:VtrSendCommandToRunner<cr>
nmap <C-d> :VtrSendLinesToRunner<cr>
vmap <C-d> :VtrSendLinesToRunner<cr>

nnoremap <leader>rj :VtrSendCommandToRunner be rake konacha<cr>
nnoremap <leader>rs :VtrSendCommandToRunner rake<cr>

nmap <leader>osr :VtrOpenRunner {'orientation': 'h', 'percentage': 50}<cr>

nnoremap <leader>sd :VtrSendCtrlD<cr>
nnoremap <leader>q :VtrSendCommandToRunner q<cr>
nnoremap <leader>sf :w<cr>:call SendFileViaVtr()<cr>
nnoremap <leader>sl :VtrSendCommandToRunner <cr>

function! SendFileViaVtr()
  let runners = {
        \ 'haskell': 'ghci',
        \ 'ruby': 'ruby',
        \ 'javascript': 'node',
        \ 'python': 'python',
        \ 'sh': 'sh'
        \ }
  if has_key(runners, &filetype)
    let runner = runners[&filetype]
    let local_file_path = expand('%')
    execute join(['VtrSendCommandToRunner', runner, local_file_path])
  else
    echoerr 'Unable to determine runner'
  endif
endfunction

" Python
"let g:VtrStripLeadingWhitespace = 0
"let g:VtrClearEmptyLines = 0
"let g:VtrAppendNewline = 1

" vim:ft=vim

" 'elzr/vim-json' todo move this to rcplugins
let g:vim_json_syntax_conceal = 0

" Requires 'npm install json -g'
function s:PrettyJSON()
  %!json
  set filetype=json
endfunction
command! PrettyJSON :call <sid>PrettyJSON()
