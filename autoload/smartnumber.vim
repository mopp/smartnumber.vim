"=============================================================================
" File: smartnumber.vim
" Author: mopp
" Created: 2014-09-02
"=============================================================================

scriptencoding utf-8

if !exists('g:loaded_smartnumber')
    finish
endif
let g:loaded_smartnumber = 1

let s:save_cpo = &cpo
set cpo&vim


" Global variables
let g:snumber_mode_map = get(g:, 'snumber_mode_map', {
            \ 'n' : 1,
            \ 'i' : 0,
            \ })
let g:snumber_check_adapt_func = get(g:, 'snumber_check_adapt_func', 's:default_check_func')


" Script local variables
let s:is_enable = 0



function! s:default_check_func(bufnr)
    return (buflisted(a:bufnr) != 0) && (getbufvar(a:bufnr, "&buftype") == '')
endfunction


function! s:is_adapt_buffer(bufnr)
    let F = function(g:snumber_check_adapt_func)
    return F(a:bufnr)
endfunction


function! s:is_adapt_current_buffer()
    return s:is_adapt_buffer(bufnr(''))
endfunction


function! s:set_absolute()
    setlocal number
    setlocal norelativenumber
endfunction


function! s:set_relative()
    setlocal relativenumber
    setlocal nonumber
endfunction


function! s:set_dynamic(is_relative)
    if s:is_adapt_current_buffer() == 0
        echomsg string("FUCK")
        setlocal nonumber
        setlocal norelativenumber
        return
    endif

    if a:is_relative
        call s:set_relative()
    else
        call s:set_absolute()
    endif
endfunction


function! smartnumber#enable()
    let s:is_enable = 1
    augroup snumber
        autocmd!
        autocmd InsertEnter * :call s:set_dynamic(g:snumber_mode_map.i)
        autocmd InsertLeave * :call s:set_dynamic(!g:snumber_mode_map.i)
        autocmd BufNewFile  * :call s:set_dynamic(g:snumber_mode_map.n)
        autocmd BufReadPost * :call s:set_dynamic(g:snumber_mode_map.n)
    augroup END
endfunc


function! smartnumber#disable()
    let s:is_enable = 0
    augroup snumber
        autocmd!
    augroup END
endfunction


function! smartnumber#toggle()
    if s:is_enable == 0
        call smartnumber#enable()
    else
        call smartnumber#disable()
    endif
endfunction



let &cpo = s:save_cpo
unlet s:save_cpo
