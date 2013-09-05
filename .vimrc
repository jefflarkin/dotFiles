" .vimrc
" Jeff Larkin, modified version of
" Smylers's .vimrc
" http://www.stripey.com/vim/
" 
" 2000 Jun  1: for `Vim' 5.6
" first clear any existing autocommands:
autocmd!
colors torte
let fortran_free_source=1
unlet! fortran_fixed_source
let fortran_fold=1
let fortran_fold_conditionals=1
let fortran_fold_multilinecomments=1
let fortran_more_precise=1
let fortran_do_enddo=1
map <Up> gk
map <Down> gj
set lbr

"* User Interface

" have syntax highlighting in terminals which can display colours:
if has('syntax') && (&t_Co > 2)
  syntax on
endif

" have fifty lines of command-line (etc) history:
set history=50
" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't remember
" marks in files, don't rehighlight old search patterns, and only save up to
" 100 lines of registers; including @10 in there should restrict input buffer
" but it causes an error for me:
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

" use "[RO]" for "[readonly]" to save space in the message line:
set shortmess+=r

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

" when using list, keep tabs at their full width and display `arrows':
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)
" (Character 187 is a right double-chevron, and 183 a mid-dot.)

" have the mouse enabled all the time:
"set mouse=a

" don't have files trying to override this .vimrc:
set nomodeline


" * Text Formatting -- General

" don't make it look like there are line breaks where there aren't:
" set nowrap

set shiftwidth=2
set shiftround
set expandtab
set autoindent

" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions-=ta
set textwidth=79

" get rid of the default style of C comments, and define a style with two stars
" at the start of `middle' rows which (looks nicer and) avoids asterisks used
" for bullet lists being treated like C comments; then define a bullet list
" style for single stars (like already is for hyphens):
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:**,ex:*/
set comments+=fb:*

" treat lines starting with a quote mark as comments (for `Vim' files, such as
" this very one!), and colons as well so that reformatting usenet messages from
" `Tin' users works OK:
set comments+=b:\"
set comments+=n::


" * Text Formatting -- Specific File Formats

" enable filetype detection:
filetype on
filetype plugin on

" recognize anything in my .Postponed directory as a news article, and anything
" at all with a .txt extension as being human-language text [this clobbers the
" `help' filetype, but that doesn't seem to prevent help from working
" properly]:
augroup filetype
  autocmd BufNewFile,BufRead */.Postponed/* set filetype=mail
  autocmd BufNewFile,BufRead *.txt set filetype=human
  "autocmd BufNewFile,BufRead *.txt set filetype=human formatoptions+=ta
  autocmd BufNewFile,BufRead *.mkdn set filetype=mkd
  autocmd BufNewFile,BufRead *.mkd set filetype=mkd
  autocmd BufNewFile,BufRead *.cu set filetype=cpp
  autocmd BufNewFile,BufRead *.cuf set filetype=fortran
  autocmd BufNewFile,BufRead *.CUF set filetype=fortran
augroup END

" in human-language files, automatically format everything at 72 chars:
" autocmd FileType mail,human set formatoptions+=ta textwidth=72

" for C-like programming, have automatic indentation:
autocmd FileType c,cpp,slang set cindent

" for actual C (not C++) programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
autocmd FileType c set formatoptions+=ro

" for Perl programming, have things in braces indenting themselves:
autocmd FileType perl set smartindent

" for CSS, also have things in braces indented:
autocmd FileType css set smartindent

" for HTML, generally format text, but if a long line has been created leave it
" alone when editing:
"autocmd FileType html set formatoptions+=tl

" for both CSS and HTML, use genuine tab characters for indentation, to make
" files a few bytes smaller:
autocmd FileType html,css set et sw=2 tabstop=2

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8


" * Search & Replace

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault



" * Keystrokes -- Moving Around

" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ covert case over line breaks; also have the cursor keys
" wrap in insert mode:
set whichwrap=h,l,~,[,]

" page down with <Space> (like in `Lynx', `Mutt', `Pine', `Netscape Navigator',
" `SLRN', `Less', and `More'); page up with - (like in `Lynx', `Mutt', `Pine'),
" or <BkSpc> (like in `Netscape Navigator'):
noremap <Space> <PageDown>
noremap <BS> <PageUp>
noremap - <PageUp>
" [<Space> by default is like l, <BkSpc> like h, and - like k.]

" scroll the window (but leaving the cursor in the same place) by a couple of
" lines up/down with <Ins>/<Del> (like in `Lynx'):
noremap <Ins> 2<C-Y>
noremap <Del> 2<C-E>
" [<Ins> by default is like i, and <Del> like x.]

" use <F6> to cycle through split windows (and <Shift>+<F6> to cycle backwards,
" where possible):
nnoremap <F6> <C-W>w
nnoremap <S-F6> <C-W>W

" use <Ctrl>+N/<Ctrl>+P to cycle through files:
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>
" [<Ctrl>+N by default is like j, and <Ctrl>+P like k.]

" have % bounce between angled brackets, as well as t'other kinds:
set matchpairs+=<:>

" have <F1> prompt for a help topic, rather than displaying the introduction
" page, and have it do this from any mode:
nnoremap <F1> :help<Space>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>


" * Keystrokes -- Formatting

" have Q reformat the current paragraph (or selected text if there is any):
nnoremap Q gwap
vnoremap Q gw

" have the usual indentation keystrokes still work in visual mode:
vnoremap <C-T> >
vnoremap <C-D> <LT>
vmap <Tab> <C-T>
vmap <S-Tab> <C-D>

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" * Keystrokes -- Insert Mode

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" have <Tab> (and <Shift>+<Tab> where it works) change the level of
" indentation:
inoremap <Tab> <C-T>
inoremap <S-Tab> <C-D>
" [<Ctrl>+V <Tab> still inserts an actual tab character.]

" * Keystrokes -- For HTML Files

" Some automatic HTML tag insertion operations are defined next.  They are
" allset to normal mode keystrokes beginning \h.  Insert mode function keys are
" also defined, for terminals where they work.  The functions referred to are
" defined at the end of this .vimrc.

" \hc ("HTML close") inserts the tag needed to close the current HTML construct
" [function at end of file]:
nnoremap \hc :call InsertCloseTag()<CR>
imap <F8> <Space><BS><Esc>\hca

" \hp ("HTML previous") copies the previous (non-closing) HTML tag in full,
" including attributes; repeating this straight away removes that tag and
" copies the one before it [function at end of file]:
nnoremap \hp :call RepeatTag(0)<CR>
imap <F9> <Space><BS><Esc>\hpa
" \hn ("HTML next") does the same thing, but copies the next tag; so \hp and
" \hn can be used to cycle backwards and forwards through the tags in the file
" (like <Ctrl>+P and <Ctrl>+N do for insert mode completion):
nnoremap \hn :call RepeatTag(1)<CR>
imap <F10> <Space><BS><Esc>\hna

" there are other key mappings that it's useful to have for typing HTML
" character codes, but that are definitely not wanted in other files (unlike
" the above, which won't do any harm), so only map these when entering an HTML
" file and unmap them on leaving it:
autocmd BufEnter * if &filetype == "html" | call MapHTMLKeys() | endif
function! MapHTMLKeys(...)
" sets up various insert mode key mappings suitable for typing HTML, and
" automatically removes them when switching to a non-HTML buffer

  " if no parameter, or a non-zero parameter, set up the mappings:
  if a:0 == 0 || a:1 != 0

    " require two backslashes to get one:
    inoremap \\ \

    " then use backslash followed by various symbols insert HTML characters:
    inoremap \& &amp;
    inoremap \< &lt;
    inoremap \> &gt;
    inoremap \. &middot;

    " em dash -- have \- always insert an em dash, and also have _ do it if
    " ever typed as a word on its own, but not in the middle of other words:
    inoremap \- &#8212;
    iabbrev _ &#8212;

    " hard space with <Ctrl>+Space, and \<Space> for when that doesn't work:
    inoremap \<Space> &nbsp;
    imap <C-Space> \<Space>

    " have the normal open and close single quote keys producing the character
    " codes that will produce nice curved quotes (and apostophes) on both Unix
    " and Windows:
    inoremap ` &#8216;
    inoremap ' &#8217;
    " then provide the original functionality with preceding backslashes:
    inoremap \` `
    inoremap \' '

    " curved double open and closed quotes (2 and " are the same key for me):
    inoremap \2 &#8220;
    inoremap \" &#8221;

    " when switching to a non-HTML buffer, automatically undo these mappings:
    autocmd! BufLeave * call MapHTMLKeys(0)

  " parameter of zero, so want to unmap everything:
  else
    iunmap \\
    iunmap \&
    iunmap \<
    iunmap \>
    iunmap \-
    iunabbrev _
    iunmap \<Space>
    iunmap <C-Space>
    iunmap `
    iunmap '
    iunmap \`
    iunmap \'
    iunmap \2
    iunmap \"

    " once done, get rid of the autocmd that called this:
    autocmd! BufLeave *

  endif " test for mapping/unmapping

endfunction " MapHTMLKeys()


function! InsertCloseTag()
" inserts the appropriate closing HTML tag; used for the \hc operation defined
" above;
" requires ignorecase to be set, or to type HTML tags in exactly the same case
" that I do;
" doesn't treat <P> as something that needs closing;
" clobbers register z and mark z
" 
" by Smylers  http://www.stripey.com/vim/
" 2000 May 4

  if &filetype == 'html'

    " list of tags which shouldn't be closed:
    let UnaryTags = ' Area Base Br DD DT HR Img Input LI Link Meta P Param '

    " remember current position:
    normal mz

    " loop backwards looking for tags:
    let Found = 0
    while Found == 0
      " find the previous <, then go forwards one character and grab the first
      " character plus the entire word:
      execute "normal ?\<LT>\<CR>l"
      normal "zyl
      let Tag = expand('<cword>')

      " if this is a closing tag, skip back to its matching opening tag:
      if @z == '/'
        execute "normal ?\<LT>" . Tag . "\<CR>"

      " if this is a unary tag, then position the cursor for the next
      " iteration:
      elseif match(UnaryTags, ' ' . Tag . ' ') > 0
        normal h

      " otherwise this is the tag that needs closing:
      else
        let Found = 1

      endif
    endwhile " not yet found match

    " create the closing tag and insert it:
    let @z = '</' . Tag . '>'
    normal `z
    if col('.') == 1
      normal "zP
    else
      normal "zp
    endif

  else " filetype is not HTML
    echohl ErrorMsg
    echo 'The InsertCloseTag() function is only intended to be used in HTML ' .
      \ 'files.'
    sleep
    echohl None

  endif " check on filetype

endfunction " InsertCloseTag()


function! RepeatTag(Forward)
" repeats a (non-closing) HTML tag from elsewhere in the document; call
" repeatedly until the correct tag is inserted (like with insert mode <Ctrl>+P
" and <Ctrl>+N completion), with Forward determining whether to copy forwards
" or backwards through the file; used for the \hp and \hn operations defined
" above;
" requires preservation of marks i and j;
" clobbers register z
" 
" by Smylers  http://www.stripey.com/vim/
" 
" 2000 May 4: for `Vim' 5.6

  if &filetype == 'html'

    " if the cursor is where this function left it, then continue from there:
    if line('.') == line("'i") && col('.') == col("'i")
      " delete the tag inserted last time:
      if col('.') == strlen(getline('.'))
        normal dF<x
      else
        normal dF<x
        if col('.') != 1
          normal h
        endif
      endif
      " note the cursor position, then jump to where the deleted tag was found:
      normal mi`j

    " otherwise, just store the cursor position (in mark i):
    else
      normal mi
    endif

    if a:Forward
      let SearchCmd = '/'
    else
      let SearchCmd = '?'
    endif

    " find the next non-closing tag (in the appropriate direction), note where
    " it is (in mark j) in case this function gets called again, then yank it
    " and paste a copy at the original cursor position, and store the final
    " cursor position (in mark i) for use next time round:
    execute "normal " . SearchCmd . "<[^/>].\\{-}>\<CR>mj\"zyf>`i"
    if col('.') == 1
      normal "zP
    else
      normal "zp
    endif
    normal mi

  else " filetype is not HTML
    echohl ErrorMsg
    echo 'The RepeatTag() function is only intended to be used in HTML files.'
    sleep
    echohl None

  endif

endfunction " RepeatTag()


" end of Smylers's .vimrc
  filetype off
  filetype plugin indent off
  set runtimepath+=$GOROOT/misc/vim
  filetype plugin indent on
  syntax on
