#' Create a LLM skeleton
#' 
#' This class handles the creation of LLM skeletons
#' 
#' @param url The host's URL.
#' @param model Identifier of the model to be used.
#' @param history Messages to be included in the request. By default, is an empty `skellm_message_history` S7 object.
#' @param stream Whether or not to stream the incomming response. FALSE by default.
#' @param api_key (Optional) The API key of the service. 
#' 
#' @returns An object with class `skellm_skeleton`.
#' 
#' @export
#' 
#' @examples
#' # For Ollama
#' skellm_skeleton(
#'   url = "http://localhost:11434/api/chat", 
#'   model = "mistral"
#' )
#' 
#' # For OpenAI
#' skellm_skeleton(
#'   url = "https://api.openai.com/v1/chat/completions", 
#'   model = "gpt-3.5-turbo",
#'   history = skellm_message_history(
#'     skellm_message(role = "system", content = "You are a helpful assistant"),
#'     skellm_message(role = "user", content = "What is 2 + 2")
#'   ),
#'   stream = TRUE,
#'   api_key = "<your_api_key>"
#' )
#' 
skellm_skeleton <- S7::new_class(
	name = "skellm_skeleton",
	package = "skellm",
	properties = list(
		url = S7::new_property(
			class = S7::class_character,
			validator = prop_scalar_validator("character")
		),
		model = S7::new_property(
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
		),
		api_key = S7::new_property(
			class = NULL | S7::class_character,
			validator = prop_scalar_validator("character", allow_null = TRUE),
			default = NULL
		),
		extra = S7::new_property(
			class = S7::class_list,
			default = list()
		)
	)
)

openai_chat_skeleton <- S7::new_class(
	name = "openai_chat_skeleton",
	parent = skellm_skeleton,
	constructor = function(url, model, history = skellm_message_history(), stream = FALSE, api_key = NULL, ...) {
		S7::new_object(
			skellm_skeleton(
				url = url,
				model = model,
				history = history,
				stream = stream,
				api_key = api_key,
				extra = rlang::list2(...)
			)
		)
	}
)

