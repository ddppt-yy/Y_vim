


function Rtl_find_width()
    let save_cursor = getpos(".")
    execute "normal! *"
    execute "normal! ggn"
    echo getline('.')
    call setpos('.', save_cursor)
endfunction


nmap <Leader>fw :call Rtl_find_width()<cr>




