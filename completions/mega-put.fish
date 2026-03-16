function __mega_put_remote_dirs
    set -l base (commandline -ct)

    if test -z "$base"
        set base /
    end

    mega-ls -a $base 2>/dev/null \
        | string match -r '.* \(folder\)$' \
        | string replace -r ' \(folder\)$' '/' \
        | while read -l dir
            if test "$base" = "/"
                set full "/$dir"
            else
                set full "$base$dir"
            end
            printf "%s\tremote\n" $full
        end
end

function __mega_put_local_paths
    __fish_complete_path | while read -l p
        printf "%s\tlocal\n" $p
    end
end

function __mega_put_combined
    __mega_put_local_paths
    __mega_put_remote_dirs
end

# when token starts with "/", show both local and remote
# otherwise normal local path completion
complete -c mega-put -f \
    -n "string match -q '/**' (commandline -ct)" \
    -a "(__mega_put_combined)"
complete -c mega-put -f \
    -n "not string match -q '/**' (commandline -ct)" \
    -a "(__fish_complete_path)"

complete -c mega-put -s c -d 'Create remote folder if it does not exist'
complete -c mega-put -s q -d 'Queue upload in background'
complete -c mega-put -l ignore-quota-warn -d 'Ignore quota warning'
