# Proof of Concept for the TRUE Connector

This repository features a minimal proof of concept for the International Data Spaces (IDS) ecosystem's [TRUE Connector](https://github.com/International-Data-Spaces-Association/true-connector). 

The proof of concept involves deploying the [Compose stack](https://github.com/International-Data-Spaces-Association/true-connector/blob/main/docker-compose.yml) that is included in the original TRUE Connector repository. However, we deploy our own version of a _data application_ to interact with the ECC component. This version is essentially an exact copy of the [original DataApp](https://github.com/Engineering-Research-and-Development/true-connector-basic_data_app) with a minor update to verify that we can inject our own logic to fetch data assets.

Please note that the following dependencies have to be installed in the system for the scripts to work:

* Java 11
* Maven
* Git
* Docker and Docker Compose
* cURL
* Python 3

To deploy all services simply run:

```
make up
```

This will produce the following stack:

```
docker ps -a
CONTAINER ID        IMAGE                                             COMMAND                  CREATED             STATUS                    PORTS                                                                    NAMES
b15ed2d3df4f        rdlabengpa/ids_execution_core_container:v1.11.0   "/bin/sh -c 'java -j…"   58 minutes ago      Up 58 minutes (healthy)   0.0.0.0:8087->8086/tcp, 0.0.0.0:8091->8449/tcp, 0.0.0.0:8890->8889/tcp   ecc-consumer
d978e5f83433        poc-true-data-app:latest                          "/bin/sh -c 'java -j…"   58 minutes ago      Up 58 minutes (healthy)   0.0.0.0:8084->8083/tcp, 0.0.0.0:9001->9000/tcp                           be-dataapp-consumer
0239d7ab1094        rdlabengpa/ids_uc_data_app_platoon:v1.5           "/bin/sh -c 'java -j…"   58 minutes ago      Up 58 minutes             8080/tcp                                                                 uc-dataapp-consumer
964c5b652924        rdlabengpa/ids_uc_data_app_platoon:v1.5           "/bin/sh -c 'java -j…"   58 minutes ago      Up 58 minutes             8080/tcp                                                                 uc-dataapp-provider
29cee312a48f        poc-true-data-app:latest                          "/bin/sh -c 'java -j…"   58 minutes ago      Up 58 minutes (healthy)   0.0.0.0:8083->8083/tcp, 0.0.0.0:9000->9000/tcp                           be-dataapp-provider
fd8235204af6        rdlabengpa/ids_execution_core_container:v1.11.0   "/bin/sh -c 'java -j…"   58 minutes ago      Up 58 minutes (healthy)   0.0.0.0:8086->8086/tcp, 0.0.0.0:8889->8889/tcp, 0.0.0.0:8090->8449/tcp   ecc-provider
```

You may run the following script to have the _consumer_ fetch an artifact from the _provider_:

```
python3 get-artifact.py
INFO:root:Request payload:
{'Forward-To': 'https://ecc-provider:8889/data',
 'messageType': 'ArtifactRequestMessage',
 'multipart': 'form',
 'requestedArtifact': 'http://w3id.org/engrd/connector/artifact/1'}
INFO:root:Response:
{'date': '2023-04-13T10:46:18.517326Z',
 'description': 'Minimal proof-of-concept of the IDS TRUE Connector'}
```

Finally, you can run `make clean` to remove all side effects, including Docker containers, volumes and Java artifacts.