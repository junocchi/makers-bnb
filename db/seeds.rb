require 'faker'

User.create(
  username: 'alex_hogg',
  firstname: 'alex',
  lastname: 'hoggett',
  email: 'alex@gmail.com',
  password: 'password'
)

Space.create(
  name: "alex's crib",
  description: 'lovely place',
  price: 12.99,
  user_id: 1,
  address: '123 shoreditch'
)