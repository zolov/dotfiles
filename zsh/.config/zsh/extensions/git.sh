#!/bin/bash

# Copied from Gary Bernhardt (destroyallsoftware.com) dot files repository.
#
# Log output:
#
# * 51c333e    (12 days)    <Gary Bernhardt>   add vim-eunuch
#
# Branch output:
#
# * release/v1.1    (13 days)    <Leyan Lo>   add pretty_git_branch
#
# The time massaging regexes start with ^[^<]* because that ensures that they
# only operate before the first "<". That "<" will be the beginning of the
# author name, ensuring that we don't destroy anything in the commit message
# that looks like time.
#
# The log format uses } characters between each field, and `column` is later
# used to split on them. A } in the commit subject or any other field will
# break this.

LOG_HASH="%C(always,yellow)%h%C(always,reset)"
LOG_RELATIVE_TIME="%C(always,green)(%ar)%C(always,reset)"
LOG_AUTHOR="%C(always,blue)<%an>%C(always,reset)"
LOG_REFS="%C(always,red)%d%C(always,reset)"
LOG_SUBJECT="%s"

LOG_FORMAT="$LOG_HASH}$LOG_AUTHOR}$LOG_RELATIVE_TIME}$LOG_SUBJECT $LOG_REFS"

BRANCH_PREFIX="%(HEAD)"
BRANCH_REF="%(color:red)%(color:bold)%(refname:short)%(color:reset)"
BRANCH_HASH="%(color:yellow)%(objectname:short)%(color:reset)"
BRANCH_DATE="%(color:green)(%(committerdate:relative))%(color:reset)"
BRANCH_AUTHOR="%(color:blue)%(color:bold)<%(authorname)>%(color:reset)"
BRANCH_CONTENTS="%(contents:subject)"

BRANCH_FORMAT="}$BRANCH_PREFIX}$BRANCH_REF}$BRANCH_HASH}$BRANCH_DATE}$BRANCH_AUTHOR}$BRANCH_CONTENTS"

check_git_statuses() {
    UNCHANGED="[=]"
    CHANGED="[+]"
    DIR="􀈖"
    BRANCH="􀅂"

    update=0

    while getopts "u" opt; do
        case $opt in
            u) update=1 ;;
			*) update=0 ;;
        esac
    done

    find . -type d -name ".git" | while read gitdir; do
        repo_dir="$(dirname "$gitdir")"
        echo ""
        echo "${DIR}  ${repo_dir}"
        cd "$repo_dir" || continue

        if [ "$update" -eq 1 ]; then
            git fetch --all --quiet > /dev/null 2>&1
        fi

        git_status=$(git status --porcelain)
        branch=$(git rev-parse --abbrev-ref HEAD)

        if [ -z "$git_status" ]; then
            echo "${BRANCH}  ${branch}"
            echo "${UNCHANGED} No changes"
        else
            echo "${BRANCH}  ${branch}"
            echo "${CHANGED} Changes:"
            echo "${git_status}"
        fi

        cd - > /dev/null || exit
    done
}

show_git_head() {
    pretty_git_log -1
    git show -p --pretty="tformat:"
}

pretty_git_log() {
    git log --since="6 months ago" --graph --pretty="tformat:${LOG_FORMAT}" $* | pretty_git_format | git_page_maybe
}

pretty_git_log_all() {
    git log --all --since="6 months ago" --graph --pretty="tformat:${LOG_FORMAT}" $* | pretty_git_format | git_page_maybe
}


pretty_git_branch() {
    git branch -v --color=always --format=${BRANCH_FORMAT} $* | pretty_git_format
}

pretty_git_branch_sorted() {
    git branch -v --color=always --format=${BRANCH_FORMAT} --sort=-committerdate $* | pretty_git_format
}

pretty_git_format() {
    # Replace (2 years ago) with (2 years)
    sed -Ee 's/(^[^)]*) ago\)/\1)/' |
    # Replace (2 years, 5 months) with (2 years)
    sed -Ee 's/(^[^)]*), [[:digit:]]+ .*months?\)/\1)/' |
    # Shorten time
    sed -Ee 's/ seconds?\)/s\)/' |
    sed -Ee 's/ minutes?\)/m\)/' |
    sed -Ee 's/ hours?\)/h\)/' |
    sed -Ee 's/ days?\)/d\)/' |
    sed -Ee 's/ weeks?\)/w\)/' |
    sed -Ee 's/ months?\)/M\)/' |
    # Shorten names
    sed -Ee 's/<Andrew Burgess>/<me>/' |
    sed -Ee 's/<([^ >]+) [^>]*>/<\1>/' |
    # Line columns up based on } delimiter
    column -s '}' -t
}

git_page_maybe() {
    # Page only if we're asked to.
    if [ -n "${GIT_NO_PAGER}" ]; then
        cat
    else
        # Page only if needed.
        less --quit-if-one-screen --no-init --RAW-CONTROL-CHARS --chop-long-lines
    fi
}
