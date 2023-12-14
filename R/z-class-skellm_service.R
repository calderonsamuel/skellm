skellm_service <- S7::new_class(
	name = "skellm_provider",
	package = "skellm",
	properties = list(
		name = S7::new_property(
			class = S7::class_character,
			validator = prop_scalar_validator("character")
		),
		url = S7::new_property(
			class = S7::class_character,
			validator = prop_scalar_validator("character")
		)
	)
)

build_skeleton <- S7::new_generic("build_skeleton", "service", function(service, ..., model, history, stream, api_key) {
	S7::S7_dispatch()
}) 

S7::method(build_skeleton, skellm_service) <- function(service, model, history, stream, api_key, ...) {
	skellm_skeleton(
		url = service@url,
		model = model,
		history = history,
		stream = stream, 
		api_key = api_key,
		extra = rlang::list2(...)
	)
}

get_models <- S7::new_generic("get_models", "service")

S7::method(get_models, skellm_service) <- function(service) {
	sample(letters, 10)
}
