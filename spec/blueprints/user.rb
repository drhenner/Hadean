
# USER

User.blueprint do 
  email
  password "pasword"
  password_confirmation "pasword"
end


User.blueprint(:registered) do 
  email
  password "pasword"
  password_confirmation "pasword"
  first_name  { Sham.name }
  last_name   { Sham.name }
  birth_date
end