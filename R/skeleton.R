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


skellm_message <- S7::new_class(
	name = "skellm_message",
	properties = list(
		role = S7::new_property(
			class = S7::class_character,
			validator = prop_scalar_validator("character")
		),
		content = S7::new_property(
			class = S7::class_character,
			validator = prop_scalar_validator("character")
		),
		name = S7::new_property(
			class = NULL | S7::class_character,
			validator = prop_scalar_validator("character", allow_null = TRUE),
			default = NULL
		)
	)
)


skellm_message_history <- S7::new_class(
	name = "skellm_message_history",
	parent = S7::class_list,
	validator = function(self) {
		if(length(self) == 0L) return(NULL)
		
		element_are_messages <- unlist(lapply(self, function(x) S7::S7_inherits(x, skellm_message)))
		
		if (!all(element_are_messages)) {
			"All elements must have have class `skellm_message`"	
		}
	},
	constructor = function(...) {
		S7::new_object(rlang::list2(...))
	}
)


skellm_skeleton <- S7::new_class(
	name = "skellm_skeleton",
	package = "skellm",
	properties = list(
		url = S7::new_property(
			class = S7::class_character,
			validator = prop_scalar_validator("character")
		),
		api_key = S7::new_property(
			class = NULL | S7::class_character,
			validator = prop_scalar_validator("character", allow_null = TRUE),
			default = NULL
		),
		model = S7::new_property(
			class = S7::class_character,
			validator = prop_scalar_validator("character")
		),
		prompt = S7::new_property(
			class = S7::class_character,
			validator = prop_scalar_validator("character")
		),
		history = S7::new_property(
			class = skellm_message_history,
			default = skellm_message_history()
		),
		stream = S7::new_property(
			class = S7::class_logical,
			validator = prop_scalar_validator("boolean"),
			default = FALSE
		)
	)
)

