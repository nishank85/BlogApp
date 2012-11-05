 class UserMailer < ActionMailer::Base
   default from: "test.app.rubyonrails@gmail.com"

   def signup_confirmation(user)
     @user = user
     mail to: user.email, subject: "Sign-up Confirmation"
   end
 end