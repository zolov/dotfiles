#!/bin/bash
sdkman() {
    case $1 in
        --help)
            cat <<EOF
Alias for sdk with additional custom functions.

Usage: $0 <subcommand> [candidate] [version]

Additional Commands

    $0 --help               Print this help message
    $0 cacerts [cacerts]    Symlink all java cacerts to a custom location (default: ~/.cacerts)

EOF
            ;;
        cacerts)
            cacerts="${2:-$HOME/.cacerts}"
            if [[ -f "$cacerts" ]]; then
                for jdk in $(sdk list java | grep installed | sed 's/^.*\| \(.*\)$/\1/g'); do
                    jdkHome=$(sdk home java $jdk)
                    pushd "$jdkHome/lib/security"
                    mv cacerts cacerts.orginal
                    ln -s "$cacerts" "cacerts"
                    popd
                done
            else
                echo "Abort: file $cacerts not found."
            fi
            ;;
        *)
            sdk "$@"
    esac
}
