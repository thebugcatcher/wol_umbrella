defmodule ListFilterer do
  alias ListFilterer.Filter

  @moduledoc """
  Documentation for ListFilterer.
  """

  def filter(list, filters) do
    Enum.reduce(filters, list, fn(filter, items) ->
      Filter.apply(items, filter)
    end)
  end
end
