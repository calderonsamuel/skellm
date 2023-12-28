#' Perform a request
#' 
#' This performs a request
#' 
#' @param skeleton The skeleton
#' 
#' @return A httr2_response object
#' 
#' @export
#' 
skellm_req_perform <- S7::new_generic("skellm_req_perform", "skeleton")

S7::method(skellm_req_perform, skellm_skeleton) <- function(skeleton) {
	
	response <- NULL
	
	if (skeleton@stream) {
		response <- skellm_req_perform_stream(skeleton)
	} else {
		request <- as_httr2_request(skeleton)
		response <- httr2::req_perform(request)
	}
	
	response
}

as_httr2_request <- S7::new_generic("as_httr2_request", "skeleton") 

S7::method(as_httr2_request, skellm_skeleton) <- function(skeleton) {
	httr2::request(skeleton@url)
}

skellm_req_perform_stream <- S7::new_generic("skellm_req_perform_stream", "skeleton") 

S7::method(skellm_req_perform_stream, skellm_skeleton) <- function(skeleton) {
	httr2::response_json(
		status_code = 200,
		url = skeleton@url,
		body = list(
			data = "Here you should put the response data"
		)
	)
}
