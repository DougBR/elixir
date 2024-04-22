defmodule BananaBank.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: BananaBank.Repo

  alias BananaBank.Users.User

  def user_factory do
    %User{
      name: "Jane Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "hello123",
      cep: "39816000"
    }
  end

  def cep_factory() do
    %{
      "cep" => "39816000",
      "logradouro" => "",
      "complemento" => "",
      "bairro" => "",
      "localidade" => "Catuji",
      "uf" => "MG",
      "ibge" => "3115458",
      "gia" => "",
      "ddd" => "33",
      "siafi" => "2653"
    }
  end
end
