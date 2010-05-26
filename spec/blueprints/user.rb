
# USER

User.blueprint do 
  email
  password "pasword"
  password_confirmation "pasword"
end


User.blueprint(:registered) do 
  email
  state    'registered'
  password "pasword"
  password_confirmation "pasword"
  first_name  { Sham.name }
  last_name   { Sham.name }
  birth_date
end
User.blueprint(:registered_with_credit) do 
  email
  state    'registered_with_credit'
  password "pasword"
  password_confirmation "pasword"
  first_name  { Sham.name }
  last_name   { Sham.name }
  birth_date
end