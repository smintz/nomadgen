import requests
import json

from nomadgen.helpers import fromJson

from nomadgen.consul.ttypes import IndexedServices, IndexedServiceNodes


class ConsulAPI(object):
    default_params = {}
    verify_tls = None
    cert_path = None
    key_path = None
    job = None

    def __init__(self, addr="http://127.0.0.1:8500"):
        self.addr = addr

    def get_services(self):
        result = self.get("/v1/catalog/services")
        return IndexedServices().readFromJson(result.text)

    def get_service(self, service_id):
        result = self.get("/v1/catalog/service/" + service_id)
        _my = json.dumps({"ServiceNodes": json.loads(result.text)})
        return fromJson(_my, IndexedServiceNodes())

    def set_ca(self, ca):
        self.verify_tls = ca
        return self

    def set_tls_key(self, key):
        self.key_path = key
        return self

    def set_tls_cert(self, cert):
        self.cert_path = cert
        return self

    def get_tls_tuple(self):
        if self.key_path and self.cert_path:
            return (self.cert_path, self.key_path)
        else:
            return None

    # HTTP Methods
    def get(self, path, params={}):
        params.update(self.default_params)
        return requests.get(
            self.addr + path,
            verify=self.verify_tls,
            params=params,
            cert=self.get_tls_tuple(),
        )

    def post(self, path, data, params={}):
        params.update(self.default_params)
        return requests.post(
            self.addr + path,
            data=data,
            verify=self.verify_tls,
            params=params,
            cert=self.get_tls_tuple(),
        )

    def put(self, path, data, params={}):
        params.update(self.default_params)
        return requests.put(
            self.addr + path,
            data=data,
            verify=self.verify_tls,
            params=params,
            cert=self.get_tls_tuple(),
        )

    def delete(self, path, params={}):
        params.update(self.default_params)
        return requests.delete(
            self.addr + path,
            verify=self.verify_tls,
            params=params,
            cert=self.get_tls_tuple(),
        )
