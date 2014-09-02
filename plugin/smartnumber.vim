"=============================================================================
" File: smartnumber.vim
" Author: mopp
" Created: 2014-09-02
"=============================================================================

scriptencoding utf-8

if exists('g:loaded_smartnumber')
    finish
endif
let g:loaded_smartnumber = 1

let s:save_cpo = &cpo
set cpo&vim



command! -nargs=0 SNumbersToggle          call smartnumber#toggle()
command! -nargs=0 SNumbersEnable          call smartnumber#enable()
command! -nargs=0 SNumbersDisable         call smartnumber#disable()
command! -nargs=0 SNumbersTurnOffRelative call smartnumber#turnoff_relative()
command! -nargs=0 SNumbersTurnOnRelative  call smartnumber#turnon_relative()
command! -nargs=0 SNumbersToggleRelative  call smartnumber#toggle_relative()



let g:snumber_enable_startup = get(g:, 'snumber_enable_startup', 0)
if g:snumber_enable_startup != 0
    call smartnumber#enable()
endif


let &cpo = s:save_cpo
unlet s:save_cpo
