defmodule BillSplitter.Router do
  @moduledoc """
  This module defines the router and web interface for the BillSplitter
  Application.
  """

  alias BillSplitter.Parser

  use Plug.Router

  plug :match
  plug :dispatch

  get "/:bill/:emails" do
    bill = Parser.parse_bill(bill)
    emails = Parser.parse_emails(emails)

    group_bill = BillSplitter.split(bill, emails)

    bill_text =
      Enum.reduce(bill, "", fn item, acc ->
        acc <>
          """
          #{item.name}
            Unit price: #{item.unit_price}
            Amount: #{item.amount}
            Total: #{item.unit_price * item.amount}
          """ <> "\n"
      end)

    final_bill_text =
      Enum.reduce(group_bill, "", fn {email, price}, acc ->
        acc <> "#{email} will pay #{price}\n\n"
      end)

    response_body = """
    #{bill_text}

    #{final_bill_text}
    """

    send_resp(conn, 200, response_body)
  end

  match _ do
    send_resp(conn, 404, "Oops! This is not the right place to be!")
  end
end
