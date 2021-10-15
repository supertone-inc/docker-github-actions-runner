DOCKER_PROJECT_URL = supertone.iptime.org:30003/supertone
NODE_DOCKER_REPOSITORY = $(DOCKER_PROJECT_URL)/github_node_runner:12

node:
	docker build -t $(NODE_DOCKER_REPOSITORY) -f node_runner/Dockerfile .

node-push:
	docker push $(NODE_DOCKER_REPOSITORY)

test-node:
	docker run --name github-runner --rm \
  -e RUNNER_NAME_PREFIX="node-runner" \
	-e RUNNER_TOKEN="AA4N7OT76U3EBDOYX6MMDYDBNEWIC" \
  -e RUNNER_WORKDIR="/tmp/supertone-inc" \
  -e RUNNER_GROUP="Default" \
  -e RUNNER_SCOPE="org" \
  -e ORG_NAME="supertone-inc" \
  -e LABELS="node,v12" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /tmp/supertone-inc:/tmp/supertone-inc \
	$(NODE_DOCKER_REPOSITORY)
