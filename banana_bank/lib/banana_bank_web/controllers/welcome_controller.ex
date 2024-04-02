defmodule BananaBankWeb.WelcomeController do
  use BananaBankWeb, :controller

  def index(conn, _params) do

    conn
    |> json(%{message: "Welcome to the Banana Bank"})
  end

end
