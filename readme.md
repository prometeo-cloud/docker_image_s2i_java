# OpenShift s2i Docker Image Java Applications

An OpenShift source to image Docker Image builder for Java applications.

## Using the Image

Create a build configuration for the Dockerfile and an image stream in OpenShift as follows:

```bash
$ oc new-build https://github.com/prometeo-cloud/docker_image_s2i_java --context-dir=centos7_java8 --to=java --strategy=docker -n myproject
```