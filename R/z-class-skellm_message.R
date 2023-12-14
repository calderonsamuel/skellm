#' Create a message
#' 
#' This class represents a standard message format.
#' 
#' @param role The role of the message's author. Typically one of "user", "system" or "assistant". We don't enforce a closed list of roles to offer more freedom.
#' @param content The content of the message.
#' @param name (Optional) The name of the message's author. Useful to differentiate between agents that have the same role.
#' 
#' @returns An object with class `skellm_message`
#' 
#' @export
#' 
#' @examples
#' skellm_message(role = "system", content = "You are a helpful assistant")
#' skellm_message(role = "user", content = "What is 2 + 2")
#' skellm_message(role = "user", content = "<Object documentation>", name = "docs")
#' 
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

#' Create a message history
#' 
#' This class wraps a list of messages.
#' 
#' @param ... Any number of messages you provide. Each one of them must be a `skellm_message` object.
#' 
#' @returns An object with class `skellm_message_history`.
#' 
#' @export
#' 
#' @examples
#' skellm_message_history(
#'   skellm_message(
#'     role = "user",
#'     content = "What is 2 + 2"
#'   )
#' )
#' 
skellm_message_history <- S7::new_class(
	name = "skellm_message_history",
	parent = S7::class_list,
	validator = function(self) {
		if(length(self) == 0L) return(NULL)
		
		element_are_messages <- unlist(lapply(self, function(x) S7::S7_inherits(x, skellm_message)))
		
		if (!all(element_are_messages)) {
			"All elements must be `skellm_message` objects"	
		}
	},
	constructor = function(...) {
		S7::new_object(rlang::list2(...))
	}
)
