include .env.default
export $(shell sed 's/=.*//' .env.default)

ifneq (,$(wildcard ./.env.local))
	include .env.local
	export $(shell sed 's/=.*//' .env.local)
endif

data_app_image = poc-true-data-app
connector_dir = true-connector
mml_dir = multipart-message-library
wms_dir = websocket-message-streamer
post_up_sleep = 10

check:
	mvn --version
	python3 --version
	docker compose version

clean:
	(cd ${connector_dir} && docker compose down -v) || true
	(cd be-dataapp-provider && mvn clean) || true
	rm -fr ${connector_dir} ${mml_dir} ${wms_dir}

data-app-deps:
	rm -fr ${mml_dir}
	
	git clone --depth 1 --branch ${MML_TAG} \
		git@github.com:Engineering-Research-and-Development/true-connector-multipart_message_library.git \
		${mml_dir}

	cd ${mml_dir} && mvn clean install

	rm -fr ${wms_dir}

	git clone --depth 1 --branch ${WMS_TAG} \
		git@github.com:Engineering-Research-and-Development/true-connector-websocket_message_streamer.git \
		${wms_dir}

	cd ${wms_dir} && mvn clean install

data-app: data-app-deps
	cd be-dataapp-provider && \
		mvn clean package && \
		docker build -t ${data_app_image} .

clone:
	rm -fr ${connector_dir}
	git clone git@github.com:International-Data-Spaces-Association/true-connector.git ${connector_dir}
	cd ${connector_dir} && git reset --hard ${TRUE_CONNECTOR_COMMIT_SHA}

up: data-app clone
	sed -i -E -r "s|image: rdlabengpa/ids_be_data_app:.*|image: ${data_app_image}:latest|g" ${connector_dir}/docker-compose.yml
	cd ${connector_dir} && docker compose up -d --build --wait && sleep ${post_up_sleep}
	./check-connector-health.sh

.PHONY: check clean data-app-deps data-app clone up