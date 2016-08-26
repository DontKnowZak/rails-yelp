module SignupHelpers

  def sign_up(email: 'test@test.com',
              password: 'qwerty',
              password_confirmation: 'qwerty')
    visit '/users/sign_up'
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end

  def add_restaurant(name: 'KFC', description: 'Deep fried goodness')
    visit '/restaurants'
    click_link 'Add restaurant'
    fill_in :restaurant_name, with: name
    fill_in :restaurant_description, with: description
    click_button 'Create Restaurant'
  end
end
