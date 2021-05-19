set -e

CLI_PATH=$ACTION_WORKSPACE/keg-cli

clone_cli () {
  echo "==== Cloning Keg-CLI branch $INPUT_CLI_GIT_BRANCH"
  git -C $ACTION_WORKSPACE clone --single-branch --branch $INPUT_CLI_GIT_BRANCH https://github.com/simpleviewinc/keg-cli.git
}

install_cli () {
  echo "==== Installing Keg-CLI dependencies..." 
  cd $CLI_PATH
  yarn install
}

setup_cli () {
  echo "==== Configuring CLI..." 
  cd $CLI_PATH

  KEG_CLI_BRANCH=$INPUT_CLI_GIT_BRANCH \
    KEG_CLI_PATH=$CLI_PATH \
    KEG_HUB_BRANCH=$INPUT_KEG_HUB_GIT_BRANCH \
    KEG_ROOT_DIR=$ACTION_WORKSPACE/keg-hub \
    GIT_TOKEN=$INPUT_TOKEN \
    bash scripts/ci/setupKegEnvironment.sh
}

clone_cli
install_cli
setup_cli