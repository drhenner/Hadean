
# RegistrationInfo 
#class RegistrationInfo
RegistrationInfo.blueprint do
  first_name  { Sham.name }
  last_name   { Sham.name }
  birth_date  
end

RegistrationInfo.blueprint(:admin) do
  last_name  { Sham.name + " (admin)" }
#  admin { true }
end
#end