defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "User created",
      data: data(user)
    }
  end

  def delete(%{user: user}) do
    %{
      message: "User deleted",
      data: data(user)
    }
  end

  def get(%{user: user}), do: %{data: data(user)}

  def list(%{users: users}) do
    Enum.map(users, fn user ->
      data(user)
    end)
  end

  def update(%{user: user}), do: %{message: "Usuário atualizado com sucesso!", data: data(user)}

  defp data(%User{} = user) do
    %{
      id: user.id,
      cep: user.cep,
      email: user.email,
      name: user.name
    }
  end
end
