
" very simple Address completition
" invoke with C-X C-U
" The Idea for the code is from : http://dollyfish.net.nz/blog/2008-04-01/mutt-and-vim-custom-autocompletion

function! AddrQuery(qstring)
  "let output = system("addrlookup '" . a:qstring . "'")
  let output = system("abook --mutt-query '" . a:qstring . "'")
  let results = []
  for line in split(output, "\n")
    let fields = split(line, "\t")
    let results += [ [fields[1], fields[0]] ]
  endfor
  return results
endfunction

fun! AddrCompleteFn(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '[^:,]'
          let start -= 1
        endwhile
        while start < col('.') && line[start] =~ '[:, ]'
            let start += 1
        endwhile
        return start
    else
        let res = []
        let query = substitute(a:base, '"', '', 'g')
        let query = substitute(query, '\s*<.*>\s*', '', 'g')
        for m in AddrQuery(query)
            call add(res, printf('"%s" <%s>', escape(m[0], '"'), m[1]))
        endfor
        return res
    endif
endfun

setlocal completefunc=AddrCompleteFn

"if exists('mutt_mode')
    "" It seems that when you've started completion, vim chooses to ignore
    "" these mappings. That means we can simply 'invoke' the preferred
    "" completion method and then C-n and C-p will behave as they should while
    "" the menu is present
    "ino <C-n> <C-X><C-U>
    "ino <C-p> <C-X><C-U>


    "fun! LBDBCompleteFn(findstart, base)
        "if a:findstart
            "" locate the start of the word
            "let line = getline('.')
            "let start = col('.') - 1
            "while start > 0 && line[start - 1] =~ '[^:,]'
              "let start -= 1
            "endwhile
            "while start < col('.') && line[start] =~ '[:, ]'
                "let start += 1
            "endwhile
            "return start
        "else
            "let res = []
            "let query = substitute(a:base, '"', '', 'g')
            "let query = substitute(query, '\s*<.*>\s*', '', 'g')
            "for m in LbdbQuery(query)
                "call add(res, printf('"%s" <%s>', escape(m[0], '"'), m[1]))
            "endfor
            "return res
        "endif
    "endfun

    "set completefunc=LBDBCompleteFn
"endif
