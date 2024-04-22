defmodule BananaBank.Users.List do
  alias Hex.API.User
  alias BananaBank.Users.User
  alias BananaBank.Repo

  @moduledoc false

  def call() do
    case Repo.all(User.all_users_query()) do
      nil -> {:error, :not_found}
      users -> {:ok, users}
    end
  end
end
