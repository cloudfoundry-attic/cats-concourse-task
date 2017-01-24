# cats-concourse-task

This repo contains [concourse](http://concourse.ci/) tasks
which enable a CF developer to easily run CATs
in a pipeline

* [CI](https://runtime.ci.cf-app.com/teams/main/pipelines/cf-release?groups=cf-release)
* [Roadmap](https://www.pivotaltracker.com/n/projects/1382120)

## Running CATs from `cf-acceptance-tests` master branch
```yaml
groups:
- name: run-cats
  jobs:
  - run-cats

resources:
- name: cats-concourse-task
  type: git
  source:
    branch: master
    uri: https://github.com/cloudfoundry/cats-concourse-task.git

- name: cf-acceptance-tests
  type: git
  source:
    branch: master
    uri: https://github.com/cloudfoundry/cf-acceptance-tests.git

- name: integration-config
  type: git
  source:
    branch: master
    uri: ""

jobs:
- name: run-cats
  public: true
  plan:
    - aggregate:
      - get: cats-concourse-task
      - get: integration-config
      - get: cf-acceptance-tests
    - task: run-cats
      file: cats-concourse-task/task.yml
```

## Running the CATs included in `cf-release`
In order to use this task with `cf-release`,
you must first run `cats-from-cf-release`
in order to extract the cf-acceptance-tests submodule.
You may then provide the output from that task
as the `cf-acceptance-tests` input to
the `cats-concourse-task`.

```yaml
groups:
- name: run-cats
  jobs:
  - run-cats

resources:
- name: cats-concourse-task
  type: git
  source:
    branch: master
    uri: https://github.com/cloudfoundry/cats-concourse-task.git

- name: cf-release
  type: git
  source:
    branch: master
    uri: https://github.com/cloudfoundry/runtime-ci.git

- name: integration-config
  type: git
  source:
    branch: master
    uri: ""

jobs:
- name: run-cats
  public: true
  plan:
    - aggregate:
      - get: cf-release
      - get: cats-concourse-task
      - get: integration-config
    - task: cats-from-cf-release
      file: cats-concourse-task/cats-from-cf-release/task.yml
    - task: run-cats
      file: cats-concourse-task/task.yml
```
