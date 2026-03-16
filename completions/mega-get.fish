function __mega_get_argc
    count (commandline -opc)
end

function __mega_get_remote_nodes
    set -l base (commandline -ct)

    if test -z "$base"
        set base /
    end

    mega-ls -a $base 2>/dev/null \
        | string replace -r ' \(folder\)$' '/' \
        | string replace -r ' \([^)]*\)$' '' \
        | while read -l node
            if test "$base" = "/"
                set full "/$node"
            else
                set full "$base$node"
            end
            printf "%s\tremote\n" $full
        end
end

# first arg: remote path
# second arg: local path
complete -c mega-get -f \
    -n "test (__mega_get_argc) -le 1" \
    -a "(__mega_get_remote_nodes)"
complete -c mega-get -f \
    -n "test (__mega_get_argc) -gt 1" \
    -a "(__fish_complete_directories)"

complete -c mega-get -s q -d 'Queue download in background'
complete -c mega-get -s m -d 'Merge with existing folder'
complete -c mega-get -l ignore-quota-warn -d 'Ignore quota warning'
complete -c mega-get -l password -d 'Password for protected link'
complete -c mega-get -l use-pcre -d 'Use PCRE expressions'
