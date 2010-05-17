
# USER

User.blueprint do 
  email
  password "pasword"
  password_confirmation "pasword"
end


User.blueprint(:admin) do 
  email
  registration_info { post.registration_info.make }
end