build:
	docker build -t joshhsoj1902/docker-kong-ogpweb .
test-xml:
	docker run --rm joshhsoj1902/docker-kong-ogpweb:latest /validate-xml-config.sh
test:
	$(MAKE) build
	$(MAKE) test-xml
gomplate:
	$(MAKE) build-gomplate-snippets

build-gomplate-snippets:
	rm -rf config_templates/gomplate_snippets
	mkdir config_templates/gomplate_snippets
	for f in config_templates/xml_snippets
	do
		basename=$(basename "$f")
		filename="${basename%.*}"
		echo "{" >> config_templates/gomplate_snippets/$(filename).json
		cat config_templates/xml_snippets/$(filename).xml | base64 >> config_templates/gomplate_snippets/$(filename).json
		echo "}" >> config_templates/gomplate_snippets/$(filename).json
	done



.PHONY: build test test-xml
