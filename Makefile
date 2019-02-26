VERSION = 0.0.2
DOCKER_REPO = neeboor
DOCKER_REGISTORY = 515884054720.dkr.ecr.ap-northeast-1.amazonaws.com
NAME = kubernetes-fluentd-s3

.PHONY: login
login:
	$(shell aws ecr get-login --no-include-email --region ap-northeast-1 --profile neeboor)

.PHONY: build
build:
	docker build -t $(DOCKER_REPO)/$(NAME):latest .
	docker rmi -f $(DOCKER_REGISTORY)/$(DOCKER_REPO)/$(NAME):latest
	docker tag $(DOCKER_REPO)/$(NAME):latest $(DOCKER_REGISTORY)/$(DOCKER_REPO)/$(NAME):latest
	docker tag $(DOCKER_REPO)/$(NAME):latest $(DOCKER_REGISTORY)/$(DOCKER_REPO)/$(NAME):$(VERSION)

.PHONY: push
push:
	docker push $(DOCKER_REGISTORY)/$(DOCKER_REPO)/$(NAME):latest
	docker push $(DOCKER_REGISTORY)/$(DOCKER_REPO)/$(NAME):$(VERSION)

.PHONY: release
release: login build push