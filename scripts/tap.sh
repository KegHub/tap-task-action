set -e
source $ACTION_WORKSPACE/keg-cli/keg


# head-ref will only be set during a PR event
export REF_BRANCH=${INPUT_TAP_REF##*/}
export HEAD_REF_BRANCH=${INPUT_TAP_HEAD_REF##*/}

# check the PR ref first, then fallback to the ref_branch
export TAP_BRANCH=${HEAD_REF_BRANCH:-$REF_BRANCH}

export TAPS_DIR=$ACTION_WORKSPACE/keg-hub/taps
export TAP_NAME=$(basename $INPUT_REPOSITORY)
export TAP_PATH=$TAPS_DIR/$TAP_NAME
export TAP_ALIAS=$INPUT_TAP_ALIAS

clone_tap () {
  echo "==== Cloning Tap with branch $TAP_BRANCH"
  git -C $TAPS_DIR clone --single-branch --branch $TAP_BRANCH https://$KEG_CLI_USER:$INPUT_TOKEN@github.com/$INPUT_REPOSITORY
}

install_tap () {
  echo "==== Installing tap dependencies"
  cd $TAP_PATH
  yarn install
}

link_tap () {
  cd $TAP_PATH
  echo "==== Linking tap to: $TAP_ALIAS"
  keg tap link $TAP_ALIAS
}

clone_tap
link_tap
install_tap