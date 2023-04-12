import http.client
import ssl
import json
import pprint
import logging
from base64 import b64encode

# https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/blob/master/doc/SECURITY.md

_USER = "admin"
_PASS = "password"
_HOST = "localhost:8090"

_logger = logging.getLogger()


def _basic_auth(user, passw):
    token = b64encode(f"{user}:{passw}".encode("utf-8")).decode("ascii")
    return f"Basic {token}"


logging.basicConfig(level=logging.DEBUG)
conn = http.client.HTTPSConnection(_HOST, context=ssl._create_unverified_context())
payload = ""
headers = {"Authorization": _basic_auth(_USER, _PASS)}
conn.request("GET", "/", payload, headers)
res = conn.getresponse()
data = res.read()
sd = json.loads(data)
_logger.debug("Consumer connector Self-Description:\n%s", pprint.pformat(sd))
assert sd["@id"] == "https://w3id.org/engrd/connector/provider"
assert sd["@type"] == "ids:BaseConnector"
_logger.info("Self-Description looks OK")
