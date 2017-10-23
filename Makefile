build:
	docker build -t joshhsoj1902/docker-kong-ogpweb .
test-xml:
	docker run --rm joshhsoj1902/docker-kong-ogpweb:latest /validate-xml-config.sh
test:
	$(MAKE) build
	$(MAKE) test-xml

.PHONY: build test test-xml
