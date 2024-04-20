defmodule BananaBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias BananaBank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "successfully returns cep info", %{bypass: bypass} do
      cep = "39816000"

      body =
        ~s({"bairro": "", "cep": "39816-000", "complemento": "", "ddd": "33", "gia": "", "ibge": "3115458", "localidade": "Catuji", "logradouro": "", "siafi": "2653", "uf": "MG"})

      Bypass.expect_once(bypass, "GET", "/#{cep}/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      expected_response =
        {:ok,
         %{
           "bairro" => "",
           "cep" => "39816-000",
           "complemento" => "",
           "ddd" => "33",
           "gia" => "",
           "ibge" => "3115458",
           "localidade" => "Catuji",
           "logradouro" => "",
           "siafi" => "2653",
           "uf" => "MG"
         }}

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(cep)

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"
end
