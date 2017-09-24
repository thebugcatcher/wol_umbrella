defmodule IterationsManager do
  alias Wol.Organization, as: Org
  alias ListFilterer, as: Filterer
  alias Filterer.Filter

  @moduledoc """
  Documentation for IterationsManager.
  """

  def check_iteration() do
    iteration = Org.get_current_iteration()
    people = Org.list_people()

    # In future for an edge case when last three people are inter-related
    # filters = [unpaired_filter(), relationship_filter(people)]
    filters = [unpaired_filter()]

    eligible_people = people
      |> Filterer.filter(filters)

    case Enum.count(eligible_people) < 2 do
      true ->
        Org.update_iteration(iteration, %{end_date: Date.utc_today})
        Org.create_iteration(%{})

      _ -> {:ok, iteration}
    end
  end

  defp unpaired_filter() do
    %Filter{
      fun: &Org.is_paired?/1,
      desired: false
    }
  end

  # In future for an edge case when last three people are inter-related
  defp relationship_filter(people) do
    %Filter{
      fun: fn(p) -> unrelated_present?(p, people) end,
      desired: true
    }
  end

  # In future for an edge case when last three people are inter-related
  defp unrelated_present?(person, people) do
    Enum.any?(people, &Org.is_unrelated?(&1, person))
  end
end
