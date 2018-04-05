let g:syntastic_python_python_exec = '/usr/bin/python3'

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint']

if executable('node_modules/.bin/eslint')
    let g:syntastic_javascript_eslint_exec = 'node_modules/.bin/eslint'
endif

if executable('node_modules/.bin/tslint')
    let g:syntastic_typescript_tslint_exec = 'node_modules/.bin/tslint'
endif
