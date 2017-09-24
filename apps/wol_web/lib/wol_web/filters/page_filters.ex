defmodule WolWeb.PageFilters do
  alias Wol.Organization, as: Org
  alias ListFilterer, as: Filterer
  alias Filterer.Filter

  def index_filters() do
    [unpaired_filter()]
  end

  def first_select_filters(person) do
    [unpaired_filter(), relationship_filter(person), not_identical(person)]
  end

  def second_chance_filters(person) do
    [unpaired_filter(), not_identical(person)]
  end

  defp unpaired_filter() do
    %Filter{
      fun: &Org.is_paired?/1,
      desired: false
    }
  end

  defp relationship_filter(person) do
    %Filter{
      fun: fn(p) -> Org.is_unrelated?(p, person) end,
    }
  end

  defp not_identical(person), do: %Filter{fun: fn(p) -> p.id != person.id end}
end
