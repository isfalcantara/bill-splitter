defmodule BillSplitter.Item do
  @moduledoc """
  A bill item. The unit price is in cents.
  """

  defstruct name: "", unit_price: 0, amount: 0

  @type t :: %__MODULE__{
          name: String.t(),
          unit_price: non_neg_integer(),
          amount: non_neg_integer()
        }
end
