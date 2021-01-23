defmodule BillSplitterTest do
  use ExUnit.Case, async: true

  alias BillSplitter.Item, as: Item

  doctest BillSplitter

  setup_all do
    %{
      bill: [
        %Item{name: "Banana", unit_price: 60, amount: 55},
        %Item{name: "Apple", unit_price: 1_00, amount: 25},
        %Item{name: "Peach", unit_price: 1_50, amount: 10},
        %Item{name: "Cheese", unit_price: 25_97, amount: 1}
      ],
      emails: [
        "bruce@wayneenterprises.com",
        "tony@starkindustries.com",
        "pudim@pudim.com.br",
        "ameno@dori.me",
        "john.doe@example.com"
      ]
    }
  end

  describe "BillSplitter.split/2" do
    test "it splits the bill equally between the emails", state do
      assert(
        BillSplitter.split(state[:bill], state[:emails]) == %{
          "bruce@wayneenterprises.com" => 19_80,
          "tony@starkindustries.com" => 19_80,
          "pudim@pudim.com.br" => 19_79,
          "ameno@dori.me" => 19_79,
          "john.doe@example.com" => 19_79
        }
      )
    end

    test "it does not split when the bill is empty", state do
      assert BillSplitter.split([], state[:emails]) == %{}
    end

    test "it does not split when there are no emails", state do
      assert BillSplitter.split(state[:bill], []) == %{}
    end
  end
end
