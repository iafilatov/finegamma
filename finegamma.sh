#!/bin/bash


# Fine-tune gamma settings using xgamma


STEP=0.01


function get {
    local pos=`tr 'rgb' '357' <<< $1`
    echo `xgamma 2>&1 | awk "{print \\$$pos}" | tr -d ,`
}


function inc {
    mod $1 +
}


function dec {
    mod $1 -
}


function mod {
    local cur=`get $1`
    tput el1 # Clear to beginning of line
    xgamma -${1}gamma `bc <<< "$cur $2 $STEP"` 2>&1 | tail -1
    tput cuu1 # up one line
}


echo "e- red +d | r- green +f | t- blue +g | q to quit"

while :; do
    read -sn 1 key
    case $key in
        q) echo && exit # need to move cursor 1 line down
            ;;
        e) inc r
            ;;
        d) dec r
            ;;
        r) inc g
            ;;
        f) dec g
            ;;
        t) inc b
            ;;
        g) dec b
            ;;
    esac
done
