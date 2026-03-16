function __mega_ls_current_token
    set -l token (commandline -ct)
    if test -z "$token"
        echo /
    else
        echo $token
    end
end

function __mega_ls_nodes
    set -l base (__mega_ls_current_token)

    mega-ls -a $base 2>/dev/null \
        | string replace -r ' \(folder\)$' '/' \
        | string replace -r ' \([^)]*\)$' '' \
        | while read -l node
            if test "$base" = "/"
                printf "%s\tremote\n" "/$node"
            else
                printf "%s\tremote\n" "$base$node"
            end
        end
end

complete -c mega-ls -f -a "(__mega_ls_nodes)"

complete -c mega-ls -s R -s r -d 'List folders recursively'
complete -c mega-ls -l tree -d 'Tree view'
complete -c mega-ls -l show-handles -d 'Show node handles'
complete -c mega-ls -s l -d 'Summary view'
complete -c mega-ls -s h -d 'Human readable sizes'
complete -c mega-ls -s a -d 'Extra information'
complete -c mega-ls -l versions -d 'Show historical versions'
complete -c mega-ls -l show-creation-time -d 'Show creation time'
complete -c mega-ls -l time-format -d 'Custom time format'
complete -c mega-ls -l use-pcre -d 'Use PCRE expressions'
