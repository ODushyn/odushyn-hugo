---
author: "O. Dushyn"
date: 2016-05-18
linktitle: HTTP. How to return errors to the clients?
menu:
  main:
    parent: tutorials
next: /tutorials/github-pages-blog
prev: /tutorials/automated-deployments
title: HTTP. How to return errors to clients?
weight: 10
---

HTTP is based on the exchange of representations. 
Errors are not an exception. 
Whenever error happens on a server either because of wrong request or server internal problems - *always* return a representation that reflects the current state of the error. 

Response must contain: 

1. Response code
2. Body containing the error description.

--

#### Response code

1. *helps clients to understand the reason why error happened*

Return *4xx* status code for errors due to client inputs, *5xx* - for errors due to server implementation.
 
2. *keeps interacting correctly "visible" for middle-ware software*
		
Common mistake is to return success status code (200 - 206 and 300 - 307) for error describing. 

	HTTP/1.1 200 OK
	Content-Type: application/xml
	
	<error>
		<message>There are no free seats left</message>
	</error>
	
Doing this prevents HTTP-aware software from detecting errors. 
For example, a cache will store it as a successful response and serve it to subsequent clients even when clients may be able to make a successful request.

Client can rely on error status returned by a server. Client error handling may looks like: 

```js
	if(response.code >= 400 and response.code < 400) {
		// Failure due to client error
		...
	}
	else if(response.code >= 500) {
		// Failure due to server error
		...
	}
```

Error due to client inputs (the most often used ones):

* 	400 (Bad Request) - return this error when your server cannot decipher client requests because of syntactical errors.
* 	401 (Unauthorized) - return this when the client is not authorized to access the resource but may be able to gain access after authentication.
* 	403 (Forbidden) - use this when your server will not let the client gain access to the resource and
authentication will not help. For instance, you can return this when the user is already authenticated but is not
allowed to request a resource.
*	404 (Not Found) - return this when the resource is not found. If possible, specify a reason in the
message body.
*	405 (Not Allowed) - return this when an HTTP method is not allowed for this resource.
Return an Allow header with methods that are valid for this resource.
* 	409 (Conflict) - return this when the request conflicts with the current state of the resource. Include
a body explaining the reason.
*	410 (Gone) - return this when the resource used to exist, but it does not anymore (if you don't keep track of deleted files on a server then just return 404).
* 	413 (Request Entity Too Large) - return this when the body of a POST of PUT request is too large. If possible, specify what is allowed in the body, and provide alternatives.
*	415 (Unsupported Media Type) - return this error when a client sends the message body in a format that the server
does not understand.

--

Error due to server (the most often used ones):

*	500 (Internal Server Error) - this is the best code to return when your code on the server side failed due to some	implementation bug.
*	503 (Service Unavailable) - return this when the server cannot fulfil the request either for some specific interval
or for an undetermined amount of time.
Two common conditions that prompt this error are failures with back-end servers
(such as a database connection failure) or when the client exceeded some rate limit
set by the server.
If possible, include a Retry-After response header with either a date or a number
of seconds as a hint.

--
####  Response body
*describes the error in a plain text or human readable HTML*

**The body must contain enough information to understand why the error occurred and how it can be fixed by the client.**

* 	Provide a link to the documentation with error detailed description if the one exist.  
*	If you are logging errors on a server side provide a link that can be used to refer to this error.
*	Keep the response body descriptive, but exclude details such as stack traces, errors from
database connection failures, etc.

--

I prefer using the next template:
```json
{
	message: Impossible to order a seat
	description: There are no free seats left
	code: 1000
	link: http://myproject/documentation/seats/ordering
}
```
	
*code* is a identifier for an error message. It makes possible maintaining different translations for each error message on a client side for example. 

#### References
1. MOE (My Own Experience)
2. RESTful Web Services Cookbook (O'Reilly Media) by Subbu Allamaraju






	





 


