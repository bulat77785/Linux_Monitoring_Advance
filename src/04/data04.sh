#!/bin/bash

for i in {1..5}; do
	touch nginx$i.log
	record=$(shuf -i 100-1000 -n 1)
	a=10
	day=$(shuf -i 1-29 -n 1)
	if [ $day -ge $a ]; then
		day="$day"
	else
		day="0$day"
	fi

	for ((j = 0; $record > j; j++ )); do
		first=$(shuf -i 1-255 -n 1)
		second=$(shuf -i 1-255 -n 1)
		third=$(shuf -i 1-255 -n 1)
		fourth=$(shuf -i 1-255 -n 1)
		echo -n "$first.$second.$third.$fourth" >> nginx$i.log
		rangeMinute=$(shuf -i 0-59 -n 1)
		rangeSecond=$(shuf -i 0-59 -n 1)
		rangeHour=$(shuf -i 0-23 -n 1)
		if [ $rangeMinute -ge $a ]; then
			rangeMinute="$rangeMinute"
		else
			rangeMinute="0$rangeMinute"
		fi
		if [ $rangeSecond -ge $a ]; then
                        rangeSecond="$rangeSecond"
                else
                        rangeSecond="0$rangeSecond"
                fi
		if [ $rangeHour -ge $a ]; then
                        rangeHour="$rangeHour"
                else
                        rangeHour="0$rangeHour"
                fi
		dates=$(date -u "+/%b/%Y")
		echo -n " - - [$day$dates:$rangeHour:$rangeMinute:$rangeSecond $(date -u +%z)]" >> nginx$i.log

		method=$(shuf -n1 methods)
		echo -n " \"$method" >> nginx$i.log

		protocol=$(shuf -n1 protocols)
		echo -n " $protocol\"" >> nginx$i.log

		codes=$(shuf -n1 codeAnswers)
		bytes=$(shuf -i 400-8000 -n 1)
		echo -n " $codes $bytes \"-\" " >> nginx$i.log
	
		agent=$(shuf -n1 agents)
		echo "\"$agent\"" >> nginx$i.log
	done
	sort -n -t ':' -k 2,2 -k 3,3 -k 4,4 nginx$i.log > nginx0$i.log
done
rm nginx1.log nginx2.log nginx3.log nginx4.log nginx5.log

# 200 OK
# Standard response for successful HTTP requests. The actual response will depend on the request method used. In a GET request, the response will contain an entity corresponding to the requested resource. In a POST request, the response will contain an entity describing or containing the result of the action.

# 201 Created
# The request has been fulfilled, resulting in the creation of a new resource.
# 400 Bad Request
# The server cannot or will not process the request due to an apparent client error (e.g., malformed request syntax, size too large, invalid request message framing, or deceptive request routing).

# 401 Unauthorized (RFC 7235)
# Similar to 403 Forbidden, but specifically for use when authentication is required and has failed or has not yet been provided. The response must include a WWW-Authenticate header field containing a challenge applicable to the requested resource. See Basic access authentication and Digest access authentication. 401 semantically means "unauthorised", the user does not have valid authentication credentials for the target resource.
# Note: Some sites incorrectly issue HTTP 401 when an IP address is banned from the website (usually the website domain) and that specific address is refused permission to access a website.

# 403 Forbidden
# The request contained valid data and was understood by the server, but the server is refusing action. This may be due to the user not having the necessary permissions for a resource or needing an account of some sort, or attempting a prohibited action (e.g. creating a duplicate record where only one is allowed). This code is also typically used if the request provided authentication by answering the WWW-Authenticate header field challenge, but the server did not accept that authentication. The request should not be repeated.

# 404 Not Found
# The requested resource could not be found but may be available in the future. Subsequent requests by the client are permissible.

# 500 Internal Server Error
# A generic error message, given when an unexpected condition was encountered and no more specific message is suitable.

# 501 Not Implemented
# The server either does not recognize the request method, or it lacks the ability to fulfil the request. Usually this implies future availability (e.g., a new feature of a web-service API).

# 502 Bad Gateway
# The server was acting as a gateway or proxy and received an invalid response from the upstream server.

# 503 Service Unavailable
# The server cannot handle the request (because it is overloaded or down for maintenance). Generally, this is a temporary state.
