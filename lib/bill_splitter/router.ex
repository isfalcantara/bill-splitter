defmodule BillSplitter.Router do
  @moduledoc """
  This module defines the router and web interface for the BillSplitter
  Application.
  """

  alias BillSplitter.Parser

  use Plug.Router

  import Plug.Conn

  plug :match
  plug :dispatch

  get "/:bill/:emails" do
    response =
      bill
      |> splitted_bill(emails)
      |> Jason.encode!(pretty: true)

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, response)
  end

  match _ do
    response = Jason.encode!(%{error: "Not Found"})

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(404, response)
  end

  defp splitted_bill(bill_string, emails_string)
       when is_binary(bill_string) and is_binary(emails_string) do
    bill = Parser.parse_bill(bill_string)
    emails = Parser.parse_emails(emails_string)

    BillSplitter.split(bill, emails)
  end
end
