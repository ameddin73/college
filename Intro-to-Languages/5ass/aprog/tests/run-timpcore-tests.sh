#!/usr/bin/env bash

for x in A B C D; do
    p=$((cd ./tests; ls test-${x}:*.imp) | head -n 1 | sed -E "s|test-${x}:[0-9]+-(.*)[.]imp|\1|")
    echo $p

    pass='yes'
    for t in $((cd ./tests; ls test-${x}:*.imp | sort -n) | sed -E 's/(.*)[.]imp/\1/'); do
        cat "./tests/$t.imp" | ./timpcore -q 1> "$t.outerr" 2>&1
        if grep -q "type error" "$t.outerr"; then
            mv "$t.outerr" "$t.tyerr"
        else
            mv "$t.outerr" "$t.tychk"
        fi
        if [ -f ./tests/$t.soln.tychk ]; then
            if [ -f $t.tychk ]; then
                if cmp --silent ./tests/$t.soln.tychk $t.tychk; then
                    echo "$t PASS (soln.tychk == tychk)"
                else
                    echo "$t FAIL (soln.tychk <> tychk)"
                    pass='no'
                fi
            else
                echo "$t FAIL (soln.tychk; tyerr)"
                pass='no'
            fi
        else
            if [ -f $t.tyerr ]; then
                echo "$t PASS (soln.tyerr; tyerr)"
            else
                echo "$t FAIL (soln.tyerr; tychk)"
                pass='no'
            fi
        fi
        rm -f "$t.tychk" "$t.tyerr"
    done
    if [ $pass = 'yes' ]; then
        echo "$p PASS"
    else
        echo "$p FAIL"
    fi
    
done
