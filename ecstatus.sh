#!/bin/bash
url='http://ec2-52-15-100-77.us-east-2.compute.amazonaws.com'
data=$(curl "$url")
status_code=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "$url")

if [ "$status_code" -eq "200" ]; then
echo -e "Nginx browser response status_code is:$status_code \nBrowser data:$data"
else
echo "Error status_code: $status_code"
exit 0
fi
