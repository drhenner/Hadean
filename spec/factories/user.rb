
# USER

Factory.define :user do |s|
  s.name                  'Macys'
  s.password              'pasword'
  s.password_confirmation "pasword"
end

Factory.define :registered_user, :parent => :user do |s|
  s.state    'registered'
  s.first_name  'John'
  s.last_name   'Doe'
  s.birth_date  Time.now.to_date
end

Factory.define :registered_user_with_credit, :parent => :registered_user do |s|
  s.state    'registered_with_credit'
end