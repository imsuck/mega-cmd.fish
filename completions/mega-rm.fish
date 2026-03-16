function __mega_rm_remote_nodes
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
            printf "$full\n"
        end
end

complete -c mega-rm -f -a "(__mega_rm_remote_nodes)"

complete -c mega-rm -s r -d 'Delete folders recursively'
complete -c mega-rm -s f -d 'Force (no confirmation)'
complete -c mega-rm -l use-pcre -d 'Use PCRE expressions'
