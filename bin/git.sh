#!/bin/bash
DEBUG="false"
git() {
    current="$(command git branch | grep '\*' | cut -c3-)"
    local_arr=(`command git branch | grep '^[^\*]' | cut -c3- | tr '\n' ' '`)
    remote_arr=(`command git branch -r | grep -v "$current$" | sed -E 's/[a-zA-Z ]+\///'`)
    if [[ $DEBUG == "true" ]] 
    then
        echo "current:"
        echo "$current"
        echo ""
        echo "local branches:"
        echo "$local"
        echo ""
        echo "remote branches:"
        echo "$remote"
        echo ""
        echo "Arrays"
        echo "${local_arr[@]}"
        echo ""
        echo "${remote_arr[@]}"
        echo ""
    fi

    if [[ $2 = -* ]]
    then
        echo "exiting early"
        command git $@
        return
    fi
    local=`echo "${local_arr[@]}" | grep -q -w "$2"`
    remote=`echo "${remote_arr[@]}" | grep -q -w "$2"`
    if [[ "$1" == "checkout" ]]
    then
        echo "advanced checkout"
        if [[ "$current" == "$2" ]]
        then
            echo "already on branch $current"
        elif $local
        then
            echo "Branch exists locally"
            command git checkout $2
        elif $remote 
        then
            echo "Branch exists as remote"
            command git checkout -t "origin/$2"
            echo "Pulling..."
            command git pull
        else
            echo "Creating new banch"
            command git checkout -b $2
            echo "Pushing upstream..."
            command git push --set-upstream origin $2
        fi
    elif [[ "$1" == "merge" ]]
    then
        if [[ $@ == 3 ]]
        then
            echo "Merging into $3"
            if [[ "$current" == "$3" ]]
            then
                command git merge "$2"
            else
                # will call the above checkout
                # so local vs remote branches will be handled
                git checkout "$2"
                echo "Fetching..."
                command git fetch #ensure up to date
                command git merge "$3"
            fi
        elif [[ $@ == 2 ]]
        then
            echo "Merging into main"
            if [[ "$current" == "main" ]]
            then
                command git merge "$2"
            else
                # will call the above checkout
                # so local vs remote branches will be handled
                git checkout "$2"
                echo "Fetching..."
                command git fetch #ensure up to date
                command git merge "$3"
            fi
        else
            echo "Normal git"
            command git $@
        fi
    else
        echo "Normal git"
        command git $@
    fi
}
