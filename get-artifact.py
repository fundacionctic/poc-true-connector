import http.client
import ssl
import json
import pprint
import logging
from base64 import b64encode

_USER = "connector"
_PASS = "password"
# be-dataapp-consumer
_HOST = "localhost:8084"

_logger = logging.getLogger()


def _basic_auth(user, passw):
    token = b64encode(f"{user}:{passw}".encode("utf-8")).decode("ascii")
    return f"Basic {token}"


logging.basicConfig(level=logging.DEBUG)
conn = http.client.HTTPSConnection(_HOST, context=ssl._create_unverified_context())

payload = {
    "multipart": "form",
    "Forward-To": "https://ecc-provider:8889/data",
    "messageType": "ArtifactRequestMessage",
    "requestedArtifact": "http://w3id.org/engrd/connector/artifact/1",
}

_logger.info("Request payload:\n%s", pprint.pformat(payload))

headers = {
    "Content-Type": "application/json",
    "Authorization": _basic_auth(_USER, _PASS),
}

conn.request("POST", "/proxy", json.dumps(payload), headers)
res = conn.getresponse()
data = res.read()
artifact = json.loads(data)
_logger.info("Response:\n%s", pprint.pformat(artifact))
