#!/bin/bash

set -e
set -x

git branch --list '*release*' --sort=-committerdate -av | tee step1.log
tail +5 step1.log | tee step2.log
awk '{print $1}' step2.log | tee step3.log
sed 's/remotes\/origin\///' step3.log | tee step4.log
# xargs -L1 -I {} echo "git push origin --delete {} --no-verify" < step4.log | tee step5.log

# Uncomment the following line to actually delete branches
# xargs -L1 -I {} git push origin --delete {} --no-verify < step4.log