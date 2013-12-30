module Helpers
  def sign_in(user)
    click_on 'Sign In'
    fill_in 'Email', with: user[:email]
    fill_in 'Password', with: "helloworld" # yup, hardcoding this here, I have a delicious bookmark somwhere explaining why
    click_button 'Sign in'  
  end
end