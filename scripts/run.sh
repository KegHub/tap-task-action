#!/bin/bash
set -e

# logs a missing env error
missing_env () {
  echo "Error: \$$1 ENV is required, but was undefined."
}

# verifies all the required environment variables are set
check_envs() {
  if [[ -z $ACTION_WORKSPACE ]]; then
    missing_env "ACTION_WORKSPACE"
    exit 1
  fi

  if [[ -z $INPUT_CLI_GIT_BRANCH ]]; then
    missing_env "INPUT_CLI_GIT_BRANCH"
    exit 1
  fi

  if [[ -z $INPUT_TAP_REF ]]; then
    missing_env "INPUT_TAP_REF"
    exit 1
  fi

  if [[ -z $INPUT_REPOSITORY ]]; then
    missing_env "INPUT_REPOSITORY"
    exit 1
  fi

  if [[ -z $INPUT_COMMAND ]]; then
    missing_env "INPUT_COMMAND"
    exit 1
  fi

  if [[ -z $INPUT_TOKEN ]]; then
    missing_env "INPUT_TOKEN"
    exit 1
  fi

  if [[ -z $INPUT_USER ]]; then
    missing_env "INPUT_USER"
    exit 1
  fi
}

check_envs

export CLI_PATH=$ACTION_WORKSPACE/keg-cli
export KEG_GLOBAL_CONFIG=$CLI_PATH/.kegConfig/cli.config.json
export KEG_CLI_USER=$INPUT_USER

echo "==== Starting Tap Task Action"

$ACTION_WORKSPACE/scripts/cli.sh
$ACTION_WORKSPACE/scripts/tap.sh

echo "==== Running command: $INPUT_COMMAND"

export TASK_OUTPUT=$(eval "source $CLI_PATH/keg && $INPUT_COMMAND")

# set the github action's output value
echo "::set-output name=TASK_OUTPUT::$TASK_OUTPUT"

