class ShopperWelcomeMailer < ApplicationMailer

	def welcome_email(shopper)
		@shopper = shopper
		mail(to: @shopper.email, subject: "welcome to shoda")
	end
	
end
