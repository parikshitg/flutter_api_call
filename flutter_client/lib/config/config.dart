const PORT = 8080;
const HOST = '127.0.0.1'; // localhost or 10.0.2.2
const BASE_URL = 'http://$HOST:$PORT';

Map<String, String> headers = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Access-Control-Allow-Origin':"*",
};