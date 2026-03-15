#!/bin/sh

set -eu

CUSTOM_BRANCH="${CUSTOM_BRANCH:-custom}"
UPSTREAM_REMOTE="${UPSTREAM_REMOTE:-upstream}"
UPSTREAM_BRANCH="${UPSTREAM_BRANCH:-master}"
DUKESS_REMOTE="${DUKESS_REMOTE:-dukess}"
DUKESS_BRANCH="${DUKESS_BRANCH:-BLE-sensors}"

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Worktree is not clean. Commit or stash changes first." >&2
  exit 1
fi

current_branch="$(git rev-parse --abbrev-ref HEAD)"

git fetch --all --prune
git checkout "$CUSTOM_BRANCH"
git rebase "$UPSTREAM_REMOTE/$UPSTREAM_BRANCH"

echo
echo "custom is now rebased onto $UPSTREAM_REMOTE/$UPSTREAM_BRANCH."
echo "Candidate dukess commits not yet on $CUSTOM_BRANCH:"
git log --oneline "$CUSTOM_BRANCH..$DUKESS_REMOTE/$DUKESS_BRANCH" || true

echo
echo "Cherry-pick the commits you want, for example:"
echo "  git cherry-pick <commit>"

if [ "$current_branch" != "$CUSTOM_BRANCH" ]; then
  echo
  echo "Previous branch was $current_branch."
fi
