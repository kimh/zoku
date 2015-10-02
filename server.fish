#!/usr/local/bin/fish

while true
  echo "Request!!!!"
  echo -e 'HTTP/1.1 200 OK\r\n' | nc -l 4567 | wc -l
end
