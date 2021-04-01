defmodule BillSplitter.ParserTest do
  alias BillSplitter.Parser
  alias BillSplitter.Item

  use ExUnit.Case, async: true

  doctest Parser

  setup_all do
    %{
      bill_string: "maca_12_5_banana_2_4_pera_5_10",
      bill: [
        %Item{name: "maca", unit_price: 12, amount: 5},
        %Item{name: "banana", unit_price: 2, amount: 4},
        %Item{name: "pera", unit_price: 5, amount: 10}
      ],
      emails_string: "email1_email2_email3",
      emails: ~w(email1 email2 email3)
    }
  end

  describe "parse_bill/1" do
    test "parses the bill string correctely", %{bill_string: bill_string, bill: bill} do
      assert Parser.parse_bill(bill_string) == bill
    end
  end

  describe "parse_emails/1" do
    test "parses the emails string correctely", %{emails_string: emails_string, emails: emails} do
      assert Parser.parse_emails(emails_string) == emails
    end
  end
end
