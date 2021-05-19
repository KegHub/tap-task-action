set -e
source $ACTION_WORKSPACE/keg-cli/keg

export TAPS_DIR=$ACTION_WORKSPACE/keg-hub/taps
export TAP_BRANCH=${INPUT_TAP_REF##*/}
export TAP_NAME=$(basename $INPUT_REPOSITORY)
export TAP_PATH=$TAPS_DIR/$TAP_NAME
export TAP_ALIAS=$INPUT_TAP_ALIAS

clone_tap () {
  echo "==== Cloning Tap with branch $TAP_BRANCH"
  git -C $TAPS_DIR clone --single-branch --branch $TAP_BRANCH https://github.com/$INPUT_REPOSITORY
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