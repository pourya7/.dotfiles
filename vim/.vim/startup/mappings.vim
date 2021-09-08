" === Unmap the arrow keys ===
no <up> ddkP==
no <down> ddp==
no <left> <Nop>
no <right> <Nop>

" === Disable arrow keys in Insert mode ===
ino <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>

" === Disable arrow keys in Visual mode ===
vno <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>

" === Qucik Pairs ===
imap <leader>' ''<esC>i
imap <leader>" ""<esC>i
imap <leader>( ()<esC>i
imap <leader>[ []<esC>i
imap <leader>{ {}<esC>i

" === Indentation ===
vnoremap < <gv
vnoremap > >gv

" Clear highlighting on esca[pe in normal mode
nnoremap <silent><esc> :noh<cr>
nnoremap <esc>^[ <esc>^[

" === COC ===
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <F2> <Plug>(coc-rename)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

nnoremap <silent> gh :call CocAction('doHover')<cr>

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" === FZF ===
nnoremap <c-p> :Files<cr>

" === NERDTree ===
map <c-n> :NERDTreeToggle<cr>
