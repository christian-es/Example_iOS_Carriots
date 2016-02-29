#-*-coding:utf8-*-
"""
    Carriots.com
    Created 29 Feb 2016
"""

from urllib2 import urlopen, Request
import json

class Carriots (object):
    api_url = "http://api.carriots.com/"

    def __init__(self, api_key=None, client_type='json'):
        self.client_type = client_type
        self.api_key = api_key
        self.content_type = "application/vnd.carriots.api.v2+%s" % self.client_type
        self.headers = {'User-Agent': 'Raspberry-Carriots',
                        'Content-Type': self.content_type,
                        'Accept': self.content_type,
                        'Carriots.apikey': self.api_key}
        self.data = None
        self.response = None

    def send(self, data):
        self.data = dumps(data)
        request = Request(self.api_url + "streams", self.data, self.headers)
        self.response = urlopen(request)
        return self.response

    def get(self, device):
        self.data = None
        request = Request(self.api_url + "devices/" + device, self.data, self.headers)
        self.response = urlopen(request)
        return self.response
