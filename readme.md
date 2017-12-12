# OpenShift s2i Docker Image Java Applications

An OpenShift source to image Docker Image builder for Java applications.

## Using the Image

Create a build configuration for the Dockerfile and an image stream in OpenShift as follows:

```bash
# clone the repository
git clone https://github.com/prometeo-cloud/docker_image_s2i_java

# create a build configuration
oc new-build https://github.com/prometeo-cloud/docker_image_s2i_java --name=java --to=java --strategy=docker -n myproject
```