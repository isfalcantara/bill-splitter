defmodule BillSplitter.Parser do
  @moduledoc """
  A set of functions to parse underscore-separated data for the web router.
  """

  alias BillSplitter.Item

  @doc """
  Parses a bill string into a bill.

  The bill string has to be composed of a series of three things: a name, a
  unit price and an amount, all separated by underscores.

  ## Examples

      iex> BillSplitter.Parser.parse_bill("apple_11_6_pear_24_4")
      [
        %BillSplitter.Item{name: "apple", unit_price: 11, amount: 6},
        %BillSplitter.Item{name: "pear", unit_price: 24, amount: 4}
      ]
  """
  @spec parse_bill(bill :: String.t()) :: list(Item.t())
  def parse_bill(bill)

  def parse_bill(bill) when is_binary(bill) do
    bill
    |> String.split("_")
    |> Enum.chunk_every(3)
    |> Enum.map(fn [name, unit_price, amount] ->
      parse_item(name, unit_price, amount)
    end)
  end

  @doc """
  Parses a emails string into a list of emails.

  The emails have to be separated by underscores.
  ## Examples

      iex> BillSplitter.Parser.parse_emails("email1_email2")
      ["email1", "email2"]
  """
  @spec parse_emails(emails :: String.t()) :: list(String.t())
  def parse_emails(emails)

  def parse_emails(emails) when is_binary(emails) do
    String.split(emails, "_")
  end

  defp parse_item(name, unit_price, amount)
       when is_binary(name) and is_binary(unit_price) and is_binary(amount) do
    %Item{
      name: "#{name}",
      unit_price: String.to_integer(unit_price),
      amount: String.to_integer(amount)
    }
  end
end
