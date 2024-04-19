defmodule BananaBank.ViaCep.Client do
  alias Tesla.Middleware
  use Tesla
  plug Middleware.BaseUrl, "https://viacep.com.br/ws"
  plug Tesla.Middleware.JSON

  def call(cep) do
    "/#{cep}/json/"
    |> get()
    |> handle_response()
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: %{"erro" => true}}}), do: {:error, "CEP inválido"}
  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_response({:ok, %Tesla.Env{status: 400, body: _body}}), do: {:error, "CEP não encontrado"}
  defp handle_response({:error, _reason} = error), do: error
end
