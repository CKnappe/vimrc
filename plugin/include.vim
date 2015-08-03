command! -nargs=0 AddInclude call s:AddInclude()
command! -nargs=0 Ai call s:AddInclude()

" Works like sort(), optionally taking in a comparator (just like the
" original), except that duplicate entries will be removed.
function! SortUnique( list, ... )
  let dictionary = {}
  for i in a:list
      if i != ''
        execute "let dictionary[ '" . i . "' ] = ''"
    endif
  endfor
  let result = []
  if ( exists( 'a:1' ) )
    let result = sort( keys( dictionary ), a:1 )
  else
    let result = sort( keys( dictionary ) )
  endif
  return result
endfunction

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
    let paths = split(&path, ",")
    let paths = SortUnique(paths)
    for path_name in paths
        let path_split = split(path_name,":")
        if len(path_split) > 1
            let path_name = path_split[1]
        endif
        let path_name = substitute(path_name, "\\\\", "/", "g")
        let path_name = substitute(path_name, "\/[^\/]*\/\\.\\.", "", "g")
        let path_name = substitute(path_name, "\/", "\\", "g")
        let shorten_attempt = substitute(a:filename, "\\V".escape(path_name, "\\"), "", "g")
        if len(path_name) > 1 && (len(shorten_attempt) < len(filename) || filename[0] == '.')
            let filename = substitute(substitute(shorten_attempt, "^\\\\", "", "g"), "\\\\", "/", "g")
        endif
    endfor
    return filename
endfunction

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

function! IsValid(answer)
    if  a:answer==1 || a:answer==2 || a:answer==3 || a:answer==4 || a:answer==5 || a:answer==6 || a:answer==7 || a:answer==8 || a:answer=="9" || a:answer=="q"
        return 1
    endif
    return 0
endfunction


function! s:AddInclude()
    let wordUnderCursor = expand("<cword>")
    let wholeWordUnderCursor = expand("<cWORD>")
    let tags = taglist('^'.wordUnderCursor.'$')
    " Only include header files
    let tags = filter(tags, 'v:val["filename"] =~ ".hpp" || v:val["filename"] =~ ".h"')
    " Exclude namespaces
    let tags = filter(tags, 'v:val["kind"] != "n"')
    let wordParts = split(wholeWordUnderCursor, wordUnderCursor)
    if(len(wordParts) > 0)
        let wordParts2 = split(wordParts[0],":")
        let tags = filter(tags, '!has_key(v:val, "namespace") || v:val["namespace"] =~ "'.wordParts2[0].'"')
        let tags_class_exact_match = filter( tags, 'v:val["kind"] == "c" && has_key(v:val, "namespace") && v:val["namespace"] == "'.wordParts2[0].'"')
        if(len(tags_class_exact_match) >= 1)
            let tags = tags_class_exact_match
        endif
    endif
    let tags_no_members = filter(tags, 'v:val["kind"] != "m"')
    if(len(tags_no_members) >= 1)
        let tags = tags_no_members
    endif
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
