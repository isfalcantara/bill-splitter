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

    test "returns a message string", %{conn: conn} do
      assert is_binary(conn.resp_body)
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

    test "returns an error message string", %{conn: conn} do
      assert is_binary(conn.resp_body)
    end
  end
end
