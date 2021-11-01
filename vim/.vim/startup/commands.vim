" === Custom ===
function! s:GitBlame()
    echom system('git blame -w -L ' . line('.') . ',+1 ' . bufname('%'))
endfunction

command! -nargs=* Blame call s:GitBlame()

" === COC ===
command! -nargs=0 Prettier :CocCommand prettier.formatFile

command! -nargs=0 Format :call CocAction('format')

command! -nargs=? Fold :call CocAction('fold', <f-args>)

" === FZF ===
" command! -bang -nargs=* Ag call fzf#vim#ag('ADD COMMAND HERE', fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --line-number --column --no-heading --color=always --smart-case --hidden -Tsvg -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
