# Image to run a jenkins locally to test pipelines and utils

To be able to debug and code on the deployment pipeline it is nice to avoid having to do commits each and every time you do a change.
My current need is to be able to run a pipeline which is using a groovy library for development.

## Supported OS

This container has only been tested on Mac. I assume that it would be working on Linux too.
I highly doubt that Windows will work, but the Linux subsystem on Windows might be a good choice.

## Running docker inside docker

As all of the builds fire of the builds inside a new docker container, we need to support running a docker "inside" the jenkins docker image.

To run docker inside docker is not something that is applauded by the community. The best solution is to map in the docker.sock to the container.
This means that instead of the new container is running as a child it is running as a sibling on the host docker service.

This is achived by mounting the hosts docker sock into jenkins:
```
-v /var/run/docker.sock:/var/run/docker.sock
```

## The project to build

The project that is checked out from SCM should be mapped into the Jenkins container.
```
IE: -v ${pwd}:/var/projects/ if your shell is in the folder of the project
or
-v /home/someuser/github/myproject:/var/projects
```

## Groovy utils

If you need any groovy utils for your build you must also map them into the jenkins container
```
-IE: -v /home/someuser/github/myutils:/var/utils/
```
these will now be available to be executed with your pipeline


## Full command
```
docker run --rm --name jenkins_local -p 8080:8080 -v ${pwd}:/var/projects/ -v /home/someuser/github/myutils:/var/utils/ -v /var/run/docker.sock:/var/run/docker.sock mskjeret/jenkins-local:latest
```
