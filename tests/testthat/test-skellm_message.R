test_that("skellm_message fails without role", {
  expect_error(skellm_message(content = "What is 2 + 2", name = "test"))
})

test_that("skellm_message fails without content", {
  expect_error(skellm_message(role = "user", name = "test"))
})

test_that("skellm_message succeeds without name", {
  expect_s3_class(skellm_message(role = "user", content = "What is 2 + 2"), class = "skellm_message")
})

test_that("skellm_message has expected properties", {
	message <- skellm_message(
		role = "user",
		content = "You are a helpful assistant."
	)
	
	expected <- list(
		role = "user",
		content = "You are a helpful assistant.",
		name = NULL
	)
	
	expect_identical(S7::props(message), expected)
})

test_that("skellm_message_history succeds when empty", {
	skellm_message_history() %>% 
		expect_s3_class("skellm_message_history")
})

test_that("skellm_message_history accepts a skell_message", {
	skellm_message_history(
		skellm_message(role = "user", content = "What is 2 + 2")
	) %>% 
		expect_s3_class("skellm_message_history")
})

test_that("skellm_message_history accepts splicing list of skellm_message objects", {
	message_list <- list(
		skellm_message(role = "system", content = "You are a helpful asssitant."),
		skellm_message(role = "user", content = "what is 2 + 2")
	)
	
	skellm_message_history(!!!message_list) %>% 
		expect_s3_class("skellm_message_history")
})

test_that("skellm_message_history rejects bare list", {
	expect_error(
		skellm_message_history(list(role = "user", content = "What is 2 + 2"))
	)
})
