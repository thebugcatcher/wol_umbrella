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
    paired_ids = Org.paired_person_ids()

    %Filter{
      fun: &Enum.member?(paired_ids, &1.id),
      desired: false
    }
  end

  defp relationship_filter(person) do
    relative_ids = Org.load_relatives(person)

    %Filter{
      fun: &Enum.member?(relative_ids, &1.id),
      desired: false
    }
  end

  defp not_identical(person), do: %Filter{fun: & &1.id != person.id}
end
