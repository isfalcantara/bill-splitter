defmodule BillSplitter do
  @moduledoc """
  A set of functions to split bills between payers.

  Bills are represented by using a list of `%BillSplitter.Item{}`,
  and payers are represented by a list of emails.
  """

  alias BillSplitter.Item, as: Item

  @doc """
  Splits the bill between all given emails in the fairest way possible.

  It takes the total price of the bill and distributes it equally between all emails.
  If there are any remaining cents, it distributes them one by one starting from the
  beggining of the list until all cents have been distributed.

  ## Examples

      iex> bill = [
      ...> %BillSplitter.Item{name: "Ham", unit_price: 25_99, amount: 5},
      ...> %BillSplitter.Item{name: "Cheese", unit_price: 19_95, amount: 4}
      ...> ]
      iex> emails = ["ameno@dori.me", "john.doe@example.com"]
      iex> BillSplitter.split(bill, emails)
      %{"ameno@dori.me" => 104_88, "john.doe@example.com" => 104_87}
  """
  @spec split(bill :: [Item.t()], emails :: [String.t()]) :: %{String.t() => non_neg_integer}
  def split([], _emails), do: %{}
  def split(_bill, []), do: %{}

  def split(bill, emails) do
    distribution_list =
      bill
      |> sum_total()
      |> build_distribution_list(length(emails))

    emails
    |> Enum.zip(distribution_list)
    |> Enum.into(%{})
  end

  defp sum_total(%{}), do: 0

  defp sum_total(bill) do
    Enum.reduce(bill, 0, fn line_item, sum ->
      sum + line_item.unit_price * line_item.amount
    end)
  end

  defp build_distribution_list(_total, payers) when payers < 1, do: []

  defp build_distribution_list(total, payers) do
    base_cents = div(total, payers)
    remainder_cents = rem(total, payers)

    base_distribution = List.duplicate(base_cents, payers - remainder_cents)
    remainder_distribution = List.duplicate(base_cents + 1, remainder_cents)

    remainder_distribution ++ base_distribution
  end
end
