function __mega_mv_remote_nodes
    set -l base (commandline -ct)

    if test -z "$base"
        set base /
    end

    mega-ls -a $base 2>/dev/null \
        | string match -r '.* \(folder\)$' \
        | string replace -r ' \(folder\)$' '/' \
        | while read -l node
            if test "$base" = "/"
                set full "/$node"
            else
                set full "$base$node"
            end
            printf "%s\tremote\n" $full
        end
end

complete -c mega-mv -f -a "(__mega_mv_remote_nodes)"

complete -c mega-mv -l use-pcre -d 'Use PCRE expressions'
