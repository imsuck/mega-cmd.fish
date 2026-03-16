function __mega_mv_argc
    count (commandline -opc)
end

function __mega_mv_remote_nodes
    set -l base (commandline -ct)

    if test -z "$base"
        set base /
    end

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

# both args: remote nodes only
complete -c mega-mv -f -a "(__mega_mv_remote_nodes)"

complete -c mega-mv -l use-pcre -d 'Use PCRE expressions'
