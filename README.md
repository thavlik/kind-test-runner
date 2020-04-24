# Notes

- Must run as privileged with host networking
- $TESTPATH, if defined, is executed after the cluster starts.
- $NO_DELETE=0 will scope the cluster to the lifetime of the container

### Example

```
FROM thavlik/kind-test-runner:latest
WORKDIR /test
COPY crds crds                            # contains any CRDs your tests depend on
COPY manifest manifest                    # contains your yaml
COPY scripts scripts                      # contains bash scripts
ENV TESTPATH=/test/scripts/run-e2e-tests
```

```
docker build -t my-kind-test . # use above Dockerfile
docker run -it \
  --rm \
  --name my-kind-test \
  --network host \
  --privileged \
  -e "NO_DELETE=1" \
  -e "CLUSTER_NAME=test" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  my-kind-test

# The cluster is now running. Do work locally on your
# dev machine, push images to localhost:5000, run e2e
# tests, etc...
kind export kubeconfig --name test
```
