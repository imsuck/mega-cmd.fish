function __mega_cp_argc
    count (commandline -opc)
end

function __mega_cp_remote_nodes
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

function __mega_cp_dest_targets
    # For destination, also allow user@domain: format
    echo "user@domain:"
    __mega_cp_remote_nodes
end

# first arg: source (remote nodes only)
# second arg: destination (remote nodes + user@domain:)
complete -c mega-cp -f \
    -n "test (__mega_cp_argc) -le 1" \
    -a "(__mega_cp_remote_nodes)"
complete -c mega-cp -f \
    -n "test (__mega_cp_argc) -gt 1" \
    -a "(__mega_cp_dest_targets)"

complete -c mega-cp -l use-pcre -d 'Use PCRE expressions'
