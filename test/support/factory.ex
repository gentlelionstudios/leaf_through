defmodule Test.Factory do
  use ExMachina.Ecto, repo: Test.Repo

  def user_factory do
    username = Faker.Internet.user_name
    %Test.User{
      first_name: Faker.Name.first_name,
      last_name: Faker.Name.last_name,
      username: username, 
      email_address: "#{username}@example.com"
    }
  end
end
