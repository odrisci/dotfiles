" Build upon Markdown syntax
runtime! syntax/cpp.vim

" pretend there's no syntax loaded
unlet b:current_syntax
" Bring in YAML syntax for front matter
syntax include @Perl syntax/perl.vim
syntax region perlSnippet start=/<%/ end=/%>/ keepend contains=@Perl

let b:current_syntax='cgt'
