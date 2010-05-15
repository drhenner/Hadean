
# USER

User.blueprint do 
  email
  password "pasword"
end


User.blueprint(:admin) do 
  email
  registration_info { post.registration_info.make }
end