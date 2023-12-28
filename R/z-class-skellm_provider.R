skellm_provider <- S7::new_class(
	name = "skellm_provider",
	package = "skellm"
)

list_services <- S7::new_generic("list_services", "provider") 

S7::method(list_services, skellm_provider) <- function(provider) {
	utils::methods("list_services")
}
