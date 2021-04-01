defmodule BillSplitter.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts BillSplitter.Router.init([])

  doctest BillSplitter.Router

  describe "GET /:bill/:emails" do
    setup do
      %{
        conn:
          BillSplitter.Router.call(
            conn(:get, "/maca_12_5_banana_2_4_pera_5_10/email1_email2_email3"),
            @opts
          )
      }
    end

    test "returns 200 OK", %{conn: conn} do
      assert conn.status == 200
    end

    test "returns valid JSON", %{conn: conn} do
      {status, _data} = Jason.decode(conn.resp_body)
      assert status == :ok
    end

    test "returns the result encoded as JSON", %{conn: conn} do
      {_status, response_data} = Jason.decode(conn.resp_body)

      assert(
        response_data == %{
          "email1" => 40,
          "email2" => 39,
          "email3" => 39
        }
      )
    end
  end

  describe "GET /*" do
    setup do
      %{
        conn: BillSplitter.Router.call(conn(:get, "/test"), @opts)
      }
    end

    test "returns 404", %{conn: conn} do
      assert conn.status == 404
    end

    test "returns valid JSON", %{conn: conn} do
      {status, _response_data} = Jason.decode(conn.resp_body)

      assert status == :ok
    end

    test "returns a JSON error message", %{conn: conn} do
      {_status, response_data} = Jason.decode(conn.resp_body)

      assert response_data == %{"error" => "Not Found"}
    end
  end
end
