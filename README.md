# cats-concourse-task

In order to use this task with cf-release, you must first run the `cats-from-cf-release` task in order to extract  
the cf-acceptance-tests submodule. You may then provide the output from that task as the `cf-acceptance-tests` input to 
the `cats-concourse-task`.
