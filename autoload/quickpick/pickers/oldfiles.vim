let s:command = ""

function! quickpick#pickers#oldfiles#open(...) abort
  call quickpick#open({
  \ "items": v:oldfiles,
  \ "on_accept": function("s:on_accept"),
  \})

  inoremap <buffer><silent> <Plug>(quickpick-oldfiles-open-with-tab) <ESC>:<C-u>call <SID>open_with_command("tab split")<CR>
  nnoremap <buffer><silent> <Plug>(quickpick-oldfiles-open-with-tab) :<C-u>call <SID>open_with_command("tab split")<CR>

  inoremap <buffer><silent> <Plug>(quickpick-oldfiles-open-with-split) <ESC>:<C-u>call <SID>open_with_command("split")<CR>
  nnoremap <buffer><silent> <Plug>(quickpick-oldfiles-open-with-split) :<C-u>call <SID>open_with_command("split")<CR>

  inoremap <buffer><silent> <Plug>(quickpick-oldfiles-open-with-vsplit) <ESC>:<C-u>call <SID>open_with_command("vsplit")<CR>
  nnoremap <buffer><silent> <Plug>(quickpick-oldfiles-open-with-vsplit) :<C-u>call <SID>open_with_command("vsplit")<CR>

  if !hasmapto("<Plug>(quickpick-oldfiles-open-with-tab)")
    imap <silent> <buffer> <C-t> <Plug>(quickpick-oldfiles-open-with-tab)
    nmap <silent> <buffer> <C-t> <Plug>(quickpick-oldfiles-open-with-tab)
  endif

  if !hasmapto("<Plug>(quickpick-oldfiles-open-with-split)")
    imap <silent> <buffer> <C-s> <Plug>(quickpick-oldfiles-open-with-split)
    nmap <silent> <buffer> <C-s> <Plug>(quickpick-oldfiles-open-with-split)
  endif

  if !hasmapto("<Plug>(quickpick-oldfiles-open-with-vsplit)")
    imap <silent> <buffer> <C-v> <Plug>(quickpick-oldfiles-open-with-vsplit)
    nmap <silent> <buffer> <C-v> <Plug>(quickpick-oldfiles-open-with-vsplit)
  endif
endfunction

function! s:on_accept(data, name) abort
  call quickpick#close()

  let l:cmd = "edit " . a:data["items"][0]
  if s:command != ""
    let l:cmd = s:command . " | " . l:cmd
    let s:command = ""
  endif

  execute l:cmd
endfunction

function! s:open_with_command(command) abort
  let s:command = a:command
  call feedkeys("\<CR>")
endfunction
