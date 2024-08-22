git branch --list '*release*' --sort=-committerdate -av \
  | tail +5 \
  | awk '{print $1}' \
  | sed 's/remotes\/origin\///' \
  | xargs -L1 -I {} git push origin --delete {} --no-verify