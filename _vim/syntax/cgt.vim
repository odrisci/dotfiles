" Language: cgt
" This is the syntax file for IBM Streams Code Generation Template
" language, which is simply standard C++ interspersed with snippets of
" Perl code. The Perl code is contained between tags as follows:
" begin: '<%'
" end:   '%>'
" There is also a version of the begin tag: '<%=', which is effectively
" equivalent to '<% print'.
"

" Build upon cpp syntax
runtime! syntax/cpp.vim

" pretend there's no syntax loaded
unlet b:current_syntax
" Bring in Perl syntax for Perl Snippets
syntax include @Perl syntax/perl.vim


" Interesting scenarios can occur when we open a brace in a perlSnippet
" The syntax mechanism does not close the perlSnippet when the brace is
" open, so instead we create a cppSnippet which is created within a
" perlSnippet whenever the perl section end marker does not close the
" perlSnippet. Example:
"
" int main( void ){                 <-- CPP (TOP)
"   <%                              <-- Start of perlSnippet
"   if($someCond){                  <-- Enter into perlBrace
"   %>                              <-- Enter into cppSnippet
"   // Setup conditional vars etc   <-- cppSnippet stuff
"   <%                              <-- end of cppSnippet
"   }                               <-- end of perlBrace
"   %>                              <-- end of perlSnippet
"   ...
" }
syntax region cppSnippet matchgroup=SpecialChar keepend
    \ start=/%>/rs=e,ms=s,hs=s end=/<%[=]\?/re=s contained contains=TOP
syntax region perlSnippet matchgroup=SpecialChar keepend
    \ start=/<%[=]\?/rs=e,ms=s,hs=s end=/%>/re=s contains=@Perl,cppSnippet

" Make sure that we can open perl snippets within other groups
" such as parens, comments, pre-processor directives, etc
syntax cluster cMultiGroup add=perlSnippet

let b:current_syntax='cgt'
