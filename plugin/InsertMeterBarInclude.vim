function! InsertInclude(filename)
    let old_pos = getpos('.')
    call cursor(line('$'), 0)

    let include = "#include \"".a:filename."\""
    let alreadyInsertedPos = search("^".include."$")

    if alreadyInsertedPos == 0
        let lastIncludeLine = search("^#include", "Wb")
        call append(lastIncludeLine, include)
        call cursor(old_pos[1] + 1, old_pos[2])
    else
        echo "Already Included"
        call cursor(old_pos[1], old_pos[2])
    endif
endfunction

function! AddIncludeGlobal(class, file)
    let meterBarUsed = search(a:class)
    if(meterBarUsed != 0)
        call InsertInclude(a:file)
    endif
endfunction 

command! -nargs=* AddIncludeGlobal call AddIncludeGlobal(<f-args>)
