test_that("skellm_skeleton fails without required fields", {
  expect_error(
  	skellm_skeleton()
  )
})

test_that("skellm_skeleton returns expected output", {
	skellm_skeleton("http://localhost:11434/api/chat", "mistral") %>% 
		S7::S7_inherits(skellm_skeleton) %>% 
		expect_true()
})

test_that("skellm_skeleton can only receive TRUE or FALSE `stream` value", {
	skellm_skeleton("http://localhost:11434/api/chat", "mistral", stream = FALSE) %>% 
		S7::S7_inherits(skellm_skeleton) %>% 
		expect_true()
	
	skellm_skeleton("http://localhost:11434/api/chat", "mistral", stream = TRUE) %>% 
		S7::S7_inherits(skellm_skeleton) %>% 
		expect_true()
	
	expect_error(skellm_skeleton("http://localhost:11434/api/chat", "mistral", stream = NA))
	expect_error(skellm_skeleton("http://localhost:11434/api/chat", "mistral", stream = c(TRUE, TRUE)))
	expect_error(skellm_skeleton("http://localhost:11434/api/chat", "mistral", stream = "TRUE"))
	expect_error(skellm_skeleton("http://localhost:11434/api/chat", "mistral", stream = NULL))
})

test_that("skellm_skeleton `api_key` slot accepts only scalar chr or NULL", {
	skellm_skeleton("http://localhost:11434/api/chat", "mistral", api_key = "<api_key>") %>% 
		S7::S7_inherits(skellm_skeleton) %>% 
		expect_true()
	
	skellm_skeleton("http://localhost:11434/api/chat", "mistral", api_key = NULL) %>% 
		S7::S7_inherits(skellm_skeleton) %>% 
		expect_true()
	
	expect_error(skellm_skeleton("http://localhost:11434/api/chat", "mistral", api_key = NA))
	expect_error(skellm_skeleton("http://localhost:11434/api/chat", "mistral", api_key = TRUE))
	expect_error(skellm_skeleton("http://localhost:11434/api/chat", "mistral", api_key = 123))
})
