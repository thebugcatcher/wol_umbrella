defmodule ListFilterer.Filter do
  alias ListFilterer.Filter

  defstruct fun: &Filter.no_fun/1,
    desired: true,
    exceptions: []

  def apply(list, filter = %ListFilterer.Filter{}) do
    Enum.filter(list, fn(item) ->
      Enum.member?(filter.exceptions, item) || filter.fun.(item) == filter.desired
    end)
  end

  def no_fun(x), do: x
end
