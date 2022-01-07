#!/usr/bin/env bash

lineNum="$(grep -n "PLACEHOLDER FUNC" main.sh | head -n 1 | cut -d: -f1)"
prev=$(expr $lineNum - 1)
next=$(expr $lineNum + 1)
end=$(cat main.sh | wc -l)

URL="http://url.not-set.com/install"
if [ ! -z "$1" ]; then
    URL=$1
fi

head -n $prev main.sh > install
cat scripts/*.sh >> install
tail -n $(expr $end - $next) main.sh >> install
echo -e "" >> install

sed -i "s,_URL_,${URL}," install

chmod +x install
