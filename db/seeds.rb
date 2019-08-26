User.destroy_all
Item.destroy_all

10.times do
  user =
    User.create(
      username: Faker::Internet.unique.username,
      password: Faker::Internet.unique.password,
      email: Faker::Internet.unique.email
    )

  5.times do
    item =
      Item.create(
        name: Faker::Food.ingredient,
        quantity: Faker::Number.within(range: 1..100)
      )
    item.user = user
    user.items << item
  end
end
