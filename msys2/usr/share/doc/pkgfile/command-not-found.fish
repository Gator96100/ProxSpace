function command_not_found_handler --on-event fish_command_not_found
    set cmd $argv

    if set pkgs (pkgfile -bv -- "$cmd" 2>/dev/null)
        printf '%s may be found in the following packages:\n' "$cmd"
        for pkg in $pkgs
            printf '  %s\n' "$pkg"
        end
    end
end
