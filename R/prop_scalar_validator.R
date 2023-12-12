#' Validate scalar properties of S7 classes
#'
#' Validator function factory for scalar properties. Use it to create functions to be passed as validators for S7 properties.
#'
#' @param type A character specifying the type of scalar property. Possible values are "character" and "boolean".
#' @param allow_null A logical indicating whether NULL is an allowed value for the property. 
#' When this is used, should be accompanied by defining the property's `class` argument to the union of NULL and a targeted class, 
#' and using NULL as the property's `default` value.
#'  
#' @return A function that returns a validation message if the value does not pass the validation, NULL otherwise.
#'
#' @examples
#' prop_scalar_validator("character")(5)
#' prop_scalar_validator("boolean")(TRUE)
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
