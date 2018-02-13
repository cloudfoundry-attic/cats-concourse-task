# cats-concourse-task

This repo contains [concourse](http://concourse.ci/) tasks
which enable a CF developer to easily run CATs
in a pipeline.

More information about CATs
and the format of the integration config
can be found in the
[cf-acceptance-tests](https://github.com/cloudfoundry/cf-acceptance-tests#test-configuration) repo.

* [CI](https://runtime.ci.cf-app.com/teams/main/pipelines/cf-deployment)
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
