defmodule WolWeb.PageFilters do
  alias Wol.Organization, as: Org
  alias ListFilterer, as: Filterer
  alias Filterer.Filter

  def index_filters() do
    paired_ids = Org.paired_person_ids()
    [unpaired_filter(paired_ids)]
  end

  def first_select_filters(person) do
    paired_ids = Org.paired_person_ids()
    relative_ids = Org.load_relatives(person)
    paired_person_ids = Org.load_paired_person_ids(person, 2)

    [unpaired_filter(paired_ids), relationship_filter(person, relative_ids), not_identical(person), different_pair(person, paired_person_ids)]
  end

  def second_chance_filters(person) do
    paired_ids = Org.paired_person_ids()
    [unpaired_filter(paired_ids), not_identical(person)]
  end

  defp unpaired_filter(paired_ids) do
    %Filter{
      fun: &Enum.member?(paired_ids, &1.id),
      desired: false
    }
  end

  defp relationship_filter(person, relative_ids) do
    %Filter{
      fun: &Enum.member?(relative_ids, &1.id),
      desired: false
    }
  end

  defp different_pair(person, paired_person_ids) do
    %Filter{
      fun: &Enum.member?(paired_person_ids, &1.id),
      desired: false
    }
  end

  defp not_identical(person), do: %Filter{fun: & &1.id != person.id}
end
