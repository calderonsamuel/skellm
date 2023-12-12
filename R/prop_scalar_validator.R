prop_scalar_validator <- function(type, allow_null = FALSE) {
	type <- rlang::arg_match(type, c("character", "boolean"))
	stopifnot(rlang::is_bool(allow_null))
	
	passes_validator <- switch(
		EXPR = type,
		"character" = rlang::is_scalar_character,
		"boolean" = rlang::is_bool
	)
	
	function(value) {
		if (allow_null) {
			if (!passes_validator(value) && !is.null(value)) {
				msg <- sprintf("should be a scalar %s or NULL", type)
				return(msg)
			}
		} else if (!passes_validator(value)) {
			msg <- sprintf("should be a scalar %s", type)
			return(msg)
		}
	}
}
