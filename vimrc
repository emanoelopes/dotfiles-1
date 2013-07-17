" Arquivo de configuração do vim
" Criado: Qua 02/Ago/2006 hs 09:19
" Last Change: 2013 Jul 17 18:00:03
" Autor: Sergio Luiz Araujo Silva
" Codificação: utf-8
" Site: http://vivaotux.blogspot.com
" Mail: voyeg3r  gmail
" Twitter: http://www.twitter.com/voyeg3r
" Download: http://bitbucket.org/sergio/vimfiles/src/tip/vimrc
" Licence: Licença: Este arquivo é de domínio público
" Garantia: O autor não se responsabiliza por eventuais danos
"           causados pelo uso deste arquivo.

"                  ( O O )
"   +===========oOO==(_)==OOo==============+
"   |                                      |
"   |     °v°   Sergio Luiz Araujo Silva   |
"   |    /(_)\  Linux User #423493         |
"   |     ^ ^   voyeg3r   gmail.com       |
"   +======================================+
"
" Referencias: http://stevelosh.com/blog/2010/09/coming-home-to-vim
" http://bitbucket.org/sjl/dotfiles/src/tip/vim/.vimrc
" vimcasts: http://vimcasts.org/episodes/tabs-and-spaces/
" http://vimcasts.org/episodes/show-invisibles/
" para usar o plugin sparkup use o atlho Ctrl-e (lembre-se que é para html)
" div.content>h1.post-title+p{Sample Content}
" http://peepcode.com/products/smash-into-vim-ii
" http://snipt.net/public/tag/vim

filetype off
call pathogen#infect()
silent! call pathogen#runtime_append_all_bundles()
" para gerar a documentação de todos os plugins
call pathogen#helptags()

"let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts=0
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

" Unite
" http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

" configurações so plugin ultisnips
" Ctrl-j next snip -- Ctrl-k previous
let g:UltiSnipsEditSplit='vertical'

" permite ao plugin supertab inferir o melhor modo de complementação
let g:SuperTabDefaultCompletionType = "context"

" default place to install vimball plugin
"let g:vimball_home=expand('$HOME')."/.vim/bundle/plugin"

filetype plugin indent on
syntax on
set omnifunc=syntaxcomplete#Complete
set completeopt+=longest
set cot-=preview "disable doc preview in omnicomplete

" para que o shell exiba as variáveis corretamente
" http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=552108
let g:is_posix = 1

" http://www.hazaah.com/programming/textmate-and-vim/
" :find file
set path+=**

" omini completion for python
" autocmd FileType python set omnifunc=pythoncomplete#Complete
" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP
" autocmd FileType c set omnifunc=ccomplete#Complete

autocmd fileType vim set keywordprg=:help

set fileformats=unix,mac,dos
" remember some stuff after quiting vim:
" marks, registers, searches, buffer list
set viminfo='20,<50,s10,h,%
set history=1000
setlocal complete=.,w,k,b,u,t,i
set clipboard=unnamed
set clipboard=unnamedplus
set complete-=k complete+=kspell
set spelllang=pt,en
set nospell
"highlight clear SpellBad
"highlight SpellBad term=reverse cterm=underline
set spellsuggest=8
map <special> <s-F7> <esc>:set spell!<cr>
"set grepprg=grin
"set grepprg=grep\ -r\ --exclude=*.svn
set grepformat=%f:%l:%m
"set grepprg=grep\ -rinsE
" como usar o grep dentro do vim
" :vim /\cbash/gj ~/.vim/**/*.wiki
" :cn ......... abre o próximo
" :cp ......... abre o prévio
map <S-F2> :copen<CR>

" fold text object
" http://vim.wikia.com/wiki/Creating_new_text_objects
vnoremap af :<C-U>silent! normal! [zV]z<CR>
omap af :normal Vaf<CR>

map <special><F3> :NERDTreeToggle<cr>

" To set the toolbars off (icons on top of the screen)
set mouse=a

set background=dark
let g:solarized_termcolors = 256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized

if ! has("gui_running")
    set t_Co=256
    colo tango-morning
endif

" turn off the toolbar and menubar
if has('gui_running')
	set anti gfn=Ubuntu\ Mono\ 13,Monaco\ 10,Bpmono\ 11,\ Envy\ Code\ R\ 10
end

" correção do plugin surround para a letra 's'
xmap <Leader>s <Plug>Vsurround

" http://stackoverflow.com/questions/4312664/is-there-a-vim-command-to-select-pasted-text
" http://vimcasts.org/episodes/bubbling-text/
" o mapeamento abaixo permite reselecionar texto recem colado ou selecionado
nmap gV `[v`]

nmap <special><F9> <esc>:w<cr>
imap <special><F9> <C-O><C-S>

map ,f <esc>:FufFile<cr>

" Fechamento automático de parênteses
"imap { {}<left>
"imap ( ()<left>
"imap [ []<left>
" os mapeamentos abaixo funcionam com o ultisnips
vmap ( <tab>(<tab>
vmap { <tab>{<tab>
vmap [ <tab>[<tab>

cab W  w
cab Wq wq
cab Q  q

" Highlight redundant whitespace and tabs.
highlight RedundantWhitespace ctermbg=red guibg=red
"match RedundantWhitespace /\s\+$\| \+\ze\t/

" Create a red/red scheme
highlight Problem ctermbg=red guibg=red
" Highlight leading tabs - tab misturado com espaço
match Problem /^\s\*\t\+\s\*/

" this function gets last 20 cmds to new buffer
fun! s:RedirHistoryCommands()
    set paste
    redir @r
    history : -20,
    redir End
    new
    put r
    set nopaste
endfun
command! -nargs=0 GetHistory call s:RedirHistoryCommands()
" q:22kyG ctrl-w-q p

" Eesta função guarda o local do cursor em 'save_cursor' e como
" executa uma substituição armazena antes o ultimo
" registro de buscas em 'old_query'
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
nmap <silent> <leader>c :keepjumps call CleanExtraSpaces()<cr>
autocmd BufWritePre * :keepjumps call CleanExtraSpaces()

" Utility function that save last search and cursor position
" http://technotales.wordpress.com/2010/03/31/preserve-a-vim-function-that-keeps-your-state/
" video from vimcasts.org: http://vimcasts.org/episodes/tidying-whitespace
function! Preserve(command)
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business
  execute a:command
  " Restore previous search history and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

fun! Keeponlymp3()
" this function keeps only mp3 urls in current text
	:%s/.*\(http.*.mp3\).*/\1/g
	:g!/\.mp3/d
endfun

" Para inserir o simbolo  use ^v ^M  ou ^v Enter
" dos2unix ^M
fun! Dos2unixFunction()
    let _s=@/
    let l = line(".")
    let c = col(".")
	" Strip trailing ^Ms, quietly.
	%s/\%x0d$//e
    let @/=_s
    call cursor(l, c)
endfun
com! Dos2Unix keepjumps call Dos2unixFunction()

" remove linhas duplicadas
"nno <leader>d %s/^\(.*\)\(\n\1\)\+$/\1/
"nno <leader>d :g/^\(.*\)\ze\n\%(.*\n\)*\1$/d<cr>
"remover linhas em branco consecutivas
fun! DelBlank()
    let _s=@/
    let l = line(".")
    let c = col(".")
    :g/^\n\{2,}/d
    let @/=_s
    call cursor(l, c)
endfun
map <special> <leader>d :keepjumps call DelBlank()<cr>

" marca como erro duas palavras identicas duplicadas
syntax match DoubleWordErr "\c\<\(\a\+\)\_s\+\1\>"
hi def link DoubleWordErr Error

syntax keyword WordError teh

" Esta função testa as 5 primeiras linhas do arquivo
" se nelas não houver "Last Change" ele passa batido
" ou seja não insere o cabeçalho
" usr_41.txt
fun! InsertChangeLog()
    let l:flag=0
    for i in range(1,5)
        if getline(i) !~ '.*Last Change.*'
            let l:flag = l:flag + 1
        endif
    endfor
    if l:flag >= 5
        normal(1G)
        call append(0, "Arquivo: <+Description+>")
        call append(1, "Criado: " . strftime("%a %d/%b/%Y hs %H:%M"))
        call append(2, "Last Change: " . strftime("%a %d/%b/%Y hs %H:%M"))
        call append(3, "autor: <+digite seu nome+>")
        call append(4, "site: <+digite o endereço de seu site+>")
        call append(5, "twitter: <+your twitter here+>")
        call append(6, "email: <+seu email+>")
        normal gg
    endif
endfun
" map <special> <F4> <esc>:call InsertChangeLog()<cr>
" mapeamento para inserir códigos especiais em páginas do wikispaces
imap <special> <F4> [[code format=""]]<enter><+conteudo+><enter>[[code]]<esc>kkf";i
nmap <special> <F4> i[[code format=""]]<enter><+comteudo+><enter>[[code]]<esc>kkf";i
xmap <F4> d<F4><esc>p`[v`]vjdd?^[[code<enter>f"a
" addon to firefox edit text areas with your favorite editor
" https://addons.mozilla.org/pt-BR/firefox/addon/its-all-text/

" update changefile log
" http://tech.groups.yahoo.com/group/vim/message/51005
fun! LastChange()
    if &modified
        let _s=@/
        let l = line(".")
        let c = col(".")
        if line("$") >= 5
            1,5s/\c\s*Last Change:\s*\zs.*/\="" . strftime("%Y %b %d %X")/ge
        endif
        let @/=_s
        call cursor(l, c)
    endif
endfun
autocmd BufWritePre * keepjumps call LastChange()

" for bash-support
let g:BASH_AuthorName = 'Sergio Luiz Araujo Silva'
let g:BASH_Email = 'voyeg3r at gmail'
let g:BASH_Company = ''

" place holders snippets
" File Templates
" --------------
"  <leader>j jumps to the next marker
" iabbr <buffer> for for <+i+> in <+intervalo+>:<cr><tab><+i+>
function! LoadFileTemplate()
    "silent! 0r ~/.vim/templates/%:e.tmpl
    syn match vimTemplateMarker "<+.\++>" containedin=ALL
    hi vimTemplateMarker guifg=#67a42c guibg=#112300 gui=bold
endfunction
function! JumpToNextPlaceholder()
    let old_query = getreg('/')
    echo search("<+.\\++>")
    exec "norm! c/+>/e\<CR>"
    call setreg('/', old_query)
endfunction
autocmd BufNewFile * :call LoadFileTemplate()
nnoremap <special> <leader>j :keepjumps call JumpToNextPlaceholder()<CR>a
inoremap <special> <leader>j <ESC>:keepjumps call JumpToNextPlaceholder()<CR>a
" Delete to end of line, bash-style
inoremap <C-K> <C-O>D

inoremap jj <esc>

" index do vim wiki
let g:vimwiki_list = [{'path': '~/.vim/wiki/', 'index': 'main'}]

" Buble single lines - mover linhas
" http://vimcasts.org/episodes/bubbling-text/
nmap <special> <c-up> ddkP
nmap  <special> <c-down> ddp
"buble multiple lines
xmap <c-up> xkP`[V`]
xmap <c-down> xp`[V`]
" se houver um trecho com seleção visual pode-se copiar
" usando Ctrl-c graças ao mapeamento abaixo
xmap <c-c> "+y


" http://vimcasts.org/episodes/creating-colorschemes-for-vim/
" Show syntax highlighting groups for word under cursor
nmap <special> <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" para mostrar cores de valores hexadecimais
if exists('*HexHighlight()')
  nmap <leader>h :call HexHighlight()<Return>
endif

set nocompatible
set modeline
set modelines=5
set tabstop=4
set shiftwidth=4
set shiftround
set copyindent
set softtabstop=4
set noexpandtab
set encoding=utf-8
set fileencoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest,full
set visualbell
"set cursorline "destaca linha atual
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
"set relativenumber
"set undofile
set undodir=~/.vim/undo/

set ignorecase
set smartcase
set smarttab
set smartindent
set infercase
set incsearch
set showmatch
set hlsearch
set wrap
set linebreak
set nolist             " list disables linebreak
set autoread           " recarrega arquivos alterados fora do vim
set textwidth=70
set formatoptions+=l
"set formatprg=par\ -w70j
"set colorcolumn=85
set listchars=tab:▸\ ,eol:¬
set matchpairs+=<:>

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.jpeg,*.mp3,*.mp4               " binary images
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store?                      " OSX bullshit

map <leader>l:set list! list?<cr>
nno <S-F11> :set hls! hls?<cr>
imap <S-F11> <ESC>:set hls!<CR>a
xmap <S-F11> <ESC>:set hls!<CR>gv

" map <S-F12> <esc>:dig<cr> " mostra os digrafos do tipo Word®
" togle between number nonumber and relativenumber
" source: http://stackoverflow.com/questions/4387210/vim-how-to-map-two-tasks-under-one-shortcut-key
" source: http://superuser.com/questions/339593/vim-toggle-number-with-relativenumber
nmap <silent> <F11> :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>

" for txt, autoformat and wrap text at 70 chars.
autocmd BufNewFile,BufRead,BufEnter *.txt set fo+=t tw=60
autocmd FileType make setlocal noexpandtab

map <BS> X

" mostra as linhas que contém determinado padrão
" permitindo saltar para uma delas
nmap <leader>/ [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

"Highlight matches without moving
"http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
set guioptions+=a
function! MakePattern(text)
	let pat = escape(a:text, '\')
	let pat = substitute(pat, '\_s\+$', '\\s\\*', '')
	let pat = substitute(pat, '^\_s\+', '\\s\\*', '')
	let pat = substitute(pat, '\_s\+',  '\\_s\\+', 'g')
	return '\\V' . escape(pat, '\"')
endfunction
vnoremap <silent> <F8> :<C-U>let @/="<C-R>=MakePattern(@*)<CR>"<CR>:set hls<CR>

set nopaste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
" source hacking-vim p-138
nnoremap p p=`]
nnoremap <c-p> p

nnoremap <F5> :GundoToggle<CR>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null
command! SaveAsRoot w !sudo tee %

" mapping to reload ~/.vimrc
map <silent> <M-v> :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
map <silent> <leader>v :e ~/.vimrc<cr>
map <silent> <leader>b :e ~/.bashrc<cr>

autocmd! BufWritePost .vimrc source %

nnoremap <leader>w :set wrap! wrap?<cr>

au! VimEnter *  match ErrorMsg /^\t\+/
au! VimEnter *  match ErrorMsg / $/

" calculadora científica usando python
command! -nargs=+ Calc :py print <args>
py from math import *
map ,c :Calc

augroup sh
	au BufNewFile *.sh 0r ~/.vim/skel/template.sh
	au BufWritePost *.sh,*.pl,*.py,*.cgi :silent !chmod a+x <afile>
augroup end

" fix to solarized colorscheme
if !has('gui_running')
    " Compatibility for Terminal
    let g:solarized_termtrans=1

    " Make Solarized use 16 colors for Terminal support
    let g:solarized_termcolors=16
endif

function! <SID>SwitchColorSchemes()
	 if exists("g:colors_name")
		  if g:colors_name == 'google'
				colorscheme two2tango
		  elseif g:colors_name == 'two2tango'
				colorscheme darktango
		  elseif g:colors_name == 'darktango'
				colorscheme colorful
		  elseif g:colors_name == 'colorful'
				colorscheme solarized
		  elseif g:colors_name == 'solarized'
				colorscheme github
		  elseif g:colors_name == 'github'
				colorscheme tango-morning
		  elseif g:colors_name == 'tango-morning'
				colorscheme guepardo
		  elseif g:colors_name == 'guepardo'
				colorscheme whyspoignant
		  elseif g:colors_name == 'whyspoignant'
				colorscheme herokudoc
		  elseif g:colors_name == 'herokudoc'
				colorscheme tango
		  elseif g:colors_name == 'tango'
				colorscheme softblue
		  elseif g:colors_name == 'softblue'
				colorscheme vividchalk
		  elseif g:colors_name == 'vividchalk'
				colorscheme neverness
		  elseif g:colors_name == 'neverness'
				colorscheme vydark
		  elseif g:colors_name == 'vydark'
				colorscheme underwater-mod
		  elseif g:colors_name == 'underwater-mod'
				colorscheme maroloccio
		  elseif g:colors_name == 'maroloccio'
				colorscheme wombat
		  elseif g:colors_name == 'wombat'
				colorscheme chrysoprase
		  elseif g:colors_name == 'chrysoprase'
				colorscheme quagmire
		  elseif g:colors_name == 'quagmire'
				colorscheme digerati
		  elseif g:colors_name == 'digerati'
				colorscheme vitamins
		  elseif g:colors_name == 'vitamins'
				colorscheme rdark
		  elseif g:colors_name == 'rdark'
				colorscheme native
		  elseif g:colors_name == 'native'
				colorscheme vibrantink
		  elseif g:colors_name == 'vibrantink'
				colorscheme Fluidvision
		  elseif g:colors_name == 'Fluidvision'
				colorscheme ir_black
		  elseif g:colors_name == 'ir_black'
				colorscheme google
		  endif
	 endif
endfunction
"map <silent> <F6> :call <SID>SwitchColorSchemes()<CR> <BAR> :set t_Co=256 <BAR> :echo g:colors_name<cr>
map <silent> <F6> <esc>:call <SID>SwitchColorSchemes()<CR><bar>:echo g:colors_name<cr>
map <special> <S-F6> :ec g:colors_name<cr>

" statusline
" cf the default statusline: %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
" format markers:
"   %< truncation point
"   %n buffer number
"   %f relative path to file
"   %m modified flag [+] (modified), [-] (unmodifiable) or nothing
"   %r readonly flag [RO]
"   %y filetype [ruby]
"   %= split point for left and right justification
"   %-35. width specification
"   %l current line number
"   %L number of lines in buffer
"   %c current column number
"   %V current virtual column number (-n), if different from %c
"   %P percentage through buffer
"   %) end of width specification
" mostra o código ascii do caractere sob o cursor e outras coisas mais
set statusline=%F%m%r%h%w\
     \ ft:%{&ft}\ \
     \ff:%{&ff}\ \
     \%{strftime(\"%a\ %d/%m/%Y\ \
     \%H:%M:%S\",getftime(expand(\"%:p\")))}%=\ \
     \buf:%n\ \
     \L:%04l\ C:%04v\ \
     \T:%04L\ HEX:%03.3B\ ASCII:%03.3b\ %P
set laststatus=2 " Sempre exibe a barra de status

nmap n nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" autocomandos para python
augroup python
    au FileType python set keywordprg=pydoc
    au! BufRead *.py setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    au! BufRead,Bufnewfile *.py im :<CR> :<CR><TAB>
    au! BufWritePre *.py,*.js :call <SID>CleanExtraSpaces()
    au! BufNewFile *.py 0r ~/.vim/skel/template.py
	au! BufWritePost *.py :silent !chmod a+x <afile>
    autocmd FileType python set textwidth=79
    autocmd FileType python filetype indent on
    let python_highlight_all=1
    let python_highlight_builtins=0
    let python_highlight_builtins=1
    let python_highlight_exceptions=1
    let python_highlight_numbers=1
    let python_highlight_space_errors=1
augroup end

"	CTRL-X CTRL-F		file names
"	CTRL-X CTRL-L		whole lines
"	CTRL-X CTRL-D		macro definitions (also in included files)
"	CTRL-X CTRL-I		current and included files
"	CTRL-X CTRL-K		words from a dictionary
"	CTRL-X CTRL-T		words from a thesaurus
"	CTRL-X CTRL-]		tags
"	CTRL-X CTRL-V		Vim command line
"	CTRL-X CTRL-O       códigos

au FileType * exe('setl dict+='.$VIMRUNTIME.'/syntax/'.&filetype.'.vim')

" setando o path do python
python << EOF
import os
import sys
import vim
for p in sys.path:
	# Add each directory in sys.path, if it exists.
	if os.path.isdir(p):
		# Command 'set' needs backslash before each space.
		vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF
" fim da seção do path do python

augroup html
" au! <--> Remove all html autocommands
au!
  au BufNewFile,BufRead *.html,*.shtml,*.htm set ft=html
  "au BufNewFile,BufRead,BufEnter  *.html,*.shtml,*.htm so ~/.vim/skel/skel.html
  au BufNewFile *.html 0r ~/.vim/skel/skel.html
  "au BufNewFile *.html,*.shtml,*.htm /body/+
  au BufNewFile,BufRead *.html,*.shtml,*.htm set noautoindent
  au BufNewFile,BufRead *.html,*.shtml,*.htm set nolist
  au BufNewFile,BufRead *.html,*.shtml,*.htm call LastChange()
  " needed one line with 'Created:' in firsts 5 lines
  au Bufnewfile,BufRead *.html,*.shtml,*.htm 1,5s/\s*Created:\s*\zs.*/\="" . strftime("%Y %b %d %X")/ge
augroup end

augroup css
    au Bufnewfile,BufRead *.css set ft=css
    au BufNewFile *.css 0r ~/.vim/skel/template.css
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
augroup end

augroup tex
    au Bufnewfile,BufRead *.tex set ft=tex
    au BufNewFile *.tex 0r ~/.vim/skel/template.tex
	vmap e <tab>em<tab>
	vmap ' <tab>'<tab>
    iab latex \LaTeX\
augroup end

if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
    \   if &omnifunc == "" |
    \   setlocal omnifunc=syntaxcomplete#Complete |
    \ endif
endif

" um destaque especial para MinhasNotas
highlight MinhasNotas ctermbg=Yellow ctermfg=red guibg=Yellow guifg=red
match MinhasNotas /[Nn]otas\?:\?/

" mapeamento para abrir e fechar folders em modo normal usando
" a barra de espaços -- zR abre todos os folders
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"nmap <space> :
" para colocar um atalho para abrir e fechar folders faça:
" set foldcolumn=1

" insert blank line before/after
" http://va.mu/Tjvu
nnoremap <silent> [<space> :pu! _<cr>:']+1<cr>
nnoremap <silent> ]<space> :pu _<cr>:'[-1<cr>

if exists('+autochdir')
  set autochdir
else
  autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif
"autocmd BufEnter * lcd %:p:h

autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

iab idate <c-r>=strftime("%A %d/%m/%Y")<cr>
iab ihora <c-r>=strftime("%H:%M:%S")<cr>

iab tambem também
iab fro for
iab ,m <voyeg3r  gmail.com>
iab mymail <voyeg3r  gmail.com>
iab slas Sérgio Luiz Araújo Silva
iab vc você
iab teh the
iab a. ª
iab analize análise
iab angulo ângulo
iab apos após
iab apra para
iab aqeule aquele
iab aqiulo aquilo
iab arcoíris arco-íris
iab aré até
iab asim assim
iab aspeto aspecto
iab assenção ascenção
iab assin assim
iab assougue açougue
iab aue que
iab augum algum
iab augun algum
iab ben bem
iab beringela berinjela
iab bon bom
iab cafe café
iab caichote caixote
iab capitões capitães
iab cidadães cidadãos
iab ckaro claro
iab cliche clichê
iab compreenssão compreensão
iab comprensão compreensão
iab comun comum
iab con com
iab contezto contexto
iab corrijir corrigir
iab coxixar cochichar
iab cpm com
iab cppara para
iab dai daí
iab danca dança
iab decer descer
iab definitamente definitivamente
iab deshonestidade desonestidade
iab deshonesto desonesto
iab detale detalhe
iab deven devem
iab díficil difícil
iab distingeu distingue
iab dsa das
iab dze dez
iab ecessão exceção
iab ecessões exceções
iab eentão e então
iab emb bem
iab ems sem
iab emu meu
iab en em
iab enbora embora
iab equ que
iab ero erro
iab erv ver
iab ese esse
iab esselência excelência
iab esu seu
iab excessão exceção
iab Excesões exceções
iab excurção excursão
iab Exenplo exemplo
iab exeplo exemplo
iab exijência exigência
iab exijir exigir
iab expontâneo espontâneo
iab ezemplo exemplo
iab ezercício exercício
iab faciu fácil
iab fas faz
iab fente gente
iab ferias férias
iab geito jeito
iab gibóia jibóia
iab gipe jipe
iab ha há
iab hezitação hesitação
iab hezitar hesitar
iab http:\\ http:
iab iigor igor
iab interesado interessado
iab interese interesse
iab Irria Iria
iab isot isto
iab ítens itens
iab ja já
iab jente gente
iab linguiça lingüiça
iab masi mais
iab maz mas
iab con com
iab mema mesma
iab mes mês
iab muinto muito
iab nao não
iab nehum nenhum
iab nenina menina
iab noã não
iab no. nº
iab N. Nº
iab o. º
iab obiter obter
iab observacao observação
iab ons nos
iab orijem origem
iab ospital hospital
iab poden podem
iab portugu6es português
iab potuguês português
iab precisan precisam
iab própio próprio
iab quado quando
iab quiz quis
iab recizão rescisão
iab sanque sangue
iab sao são
iab sen sem
iab sensivel sensível
iab sequéncia seqüência
iab significatimente significativam
iab sinceranete sinceramente
iab sovre sobre
iab susseder suceder
iab tanbem também
iab testo texto
iab téxtil têxtil
iab tydo tudo
iab tuiter http://www.twitter.com/voyeg3r
iab una uma
iab unico único
iab utilise utilize
iab vega veja
iab vivaotux http://vivaotux.blogspot.com
iab vja veja
iab voc6e você
iab wue que
iab xave chave

iab 1a. 1ª
iab 2a. 2ª
iab 3a. 3ª
iab 4a. 4ª
iab 5a. 5ª
iab 6a. 6ª
iab 7a. 7ª
iab 8a. 8ª
iab 9a. 9ª
iab 10a. 10ª
iab 11a. 11ª
iab 12a. 12ª
iab 13a. 13ª
iab 14a. 14ª
iab 15a. 15ª

" caso o teclado esteja desconfigurado use:
"iab 'a á
"iab 'e é
"iab 'i í
"iab 'o ó
"iab ~a ã
"iab ^a â
"iab `a à
"iab ,c ç
"iab ^e ê
"iab ^o ô
"iab ~o õ
"iab 'u ú
