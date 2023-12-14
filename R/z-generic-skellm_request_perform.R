skellm_request_perform <- S7::new_generic("skellm_request_perform", "skeleton")

S7::method(skellm_request_perform, skellm_skeleton) <- function(skeleton) {
	request <- as_httr2_request(skeleton)
	
	response <- NULL
	
	if (skeleton@stream) {
		buffer <- ""
		
		httr2::req_perform_stream(request, callback = function(x) {
			buffer <<- rawToChar(x)
			TRUE
		})
		response <- buffer
	} else {
		response <- httr2::req_perform(request)
	}
}
