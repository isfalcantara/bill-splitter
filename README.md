# BillSplitter

A set of functions to split bills between payers.
Built as part of the selection process for Stone's Elixir training program.

Bills are represented by using a list of `%BillSplitter.Item{}`,
and payers are represented by a list of emails.

## Usage

Load the modules in `iex`:

`$ iex -S mix`

Create a bill by filling a list with many `Item` structs, and a list of emails:

```elixir
iex> bill = [
...> %BillSplitter.Item{name: "Ham", unit_price: 25_99, amount: 5},
...> %BillSplitter.Item{name: "Cheese", unit_price: 19_95, amount: 4}
...> ]
iex> emails = ["ameno@dori.me", "john.doe@example.com"]
```

Split the bill!

```elixir
iex> BillSplitter.split(bill, emails)
%{"ameno@dori.me" => 104_88, "john.doe@example.com" => 104_87}
```

## Do you want some tests? We have them!

`$ mix test`

Built with ❤ by Isai Alcântara.
