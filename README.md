# Overview: 
`tap-task-action` is a github action that sets up the [keg-cli](https://github.com/simpleviewinc/keg-cli), a tap, then runs a keg cli task. 

For more information on taps and the keg, see [keg-hub](https://github.com/simpleviewinc/keg-hub)

# Usage

```yml
- uses: simpleviewinc/tap-task-action@0.0.5
  with:
    # The keg-cli git branch to use for building and pushing the image.
    #
    # Default: 'develop'
    cli_git_branch: ''

    # The git ref of the tap to checkout.
    # When checking out the repository that triggered a workflow, this 
    # defaults to the reference or SHA for that event. 
    # 
    # NOTE: This has to be a branch ref. Tags will not work.
    #
    # Example: /ref/heads/my-feature-branch
    # Default: ${{ github.ref }}
    tap_ref: ''

    # Your tap's repository name, including owner. 
    #
    # Example: simpleviewinc/tap-events-force
    # Default: ${{ github.repository }}
    repository: ''

    # The link alias for your tap. If omitted, the task will look for an alias in your tap's config file (e.g tap.js(on))
    # 
    # Example: evf
    tap_alias: ''

    # The command to run once the keg-cli and tap are setup. This command
    # has access to the keg-cli executable (keg) and all of the 
    # environment variables of this action.
    #
    # Example: keg $TAP_ALIAS build
    command: ''

    # Personal access token (PAT) used to fetch the tap's repository and push its image. 
    # We recommend using a service account with the least permissions necessary.
    # Also when generating a new PAT, select the least scopes necessary.
    #
    # Default: ${{ github.token }}
    token: ''

    # The username to use for logging into the docker registry 
    # with the docker-cli
    #
    # Default: 'keg-admin'
    user: ''
```

# Outputs
* `TASK_OUTPUT`: if your command sent anything to `stdout`, it will be accessible through this output variable
