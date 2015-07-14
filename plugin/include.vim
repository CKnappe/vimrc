command! -nargs=0 AddInclude call s:AddInclude()

function! Relpath(filename)
    let cwd = expand('%:p')
    let cwd_split = split(cwd, ":")
    if len(cwd_split) == 1
        let cwd = cwd_split[0]
    else
        let cwd = cwd_split[1]
    endif
    let filename_split = split(a:filename, ":")
    if len(filename_split) == 1
        let filename = filename_split[0]
    else
        let filename = filename_split[1]
    endif
    let cwd_split = split(cwd, "\\")
    let subdir_counter = 0
    for cwd_entry in cwd_split
        let old_filename = filename
        let filename = substitute(filename, "^\\\\" . cwd_entry  , "", "")
        if filename == old_filename
            let subdir_counter += 1
        endif
    endfor
    let filename = substitute(filename, "^\\\\" , "", "")
    let counter = 1
    while counter < subdir_counter
        let filename = "..\\".filename
        let counter += 1
    endwhile
    let filename = substitute(filename, "\\\\", "/", "g")
    return filename
endfunction

function! InsertInclude(filename)
    let old_pos = getpos('.')
    call cursor(line('$'), 0)
    let lastIncludeLine = search("^#include", "Wb")
    call append(lastIncludeLine, "#include \"".a:filename."\"")
    call cursor(old_pos[1] + 1, old_pos[2])
endfunction

function! IsValid(answer)
    if  a:answer==1 || a:answer==2 || a:answer==3 || a:answer==4 || a:answer==5 || a:answer==6 || a:answer==7 || a:answer==8 || a:answer=="9" || a:answer=="q"
        return 1
    endif
    return 0
endfunction


function! s:AddInclude()
    let wordUnderCursor = expand("<cword>")
    let tags = taglist('^'.wordUnderCursor)
    let tags = filter(tags, 'v:val["kind"] == "c"')
    if len(tags) == 1
        call InsertInclude(Relpath(tags[0]['filename']))
    elseif len(tags) > 0 && len(tags) < 10
        let answer="x"
        while !IsValid(answer)
            let counter = 1
            for entry in tags
                echo counter.") ".entry['filename']
                let counter += 1
            endfor
            let answer = input("Which file is the correct one? (q for quit)\n")
        endwhile
        if answer != "q"
            let name = Relpath(tags[answer-1]['filename'])
            call InsertInclude(name)
        endif
    elseif len(tags) > 0
        echo "Too many tag candidates found"
    else
        echo "No tag candidate found"
    endif
endfunction
