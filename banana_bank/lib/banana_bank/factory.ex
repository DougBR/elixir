defmodule BananaBank.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: BananaBank.Repo

  alias BananaBank.Users.User

  def user_factory do
    %User{
      name: "Jane Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "hello123",
      cep: "12345678"
    }
  end
end
