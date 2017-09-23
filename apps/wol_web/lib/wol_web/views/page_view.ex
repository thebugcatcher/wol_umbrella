defmodule WolWeb.PageView do
  use WolWeb, :view

  @base_url "http://wheeldecide.com/e.php?"
  @end_url "col=wol&t=Participant+1&time=5"

  def form_wheel_url(people) do
    people
    |> Enum.reduce({@base_url, 1}, fn(person, {url, num}) ->
      {url <> "c#{num}=" <> trim_name(person) <> "&", num + 1}
    end)
    |> elem(0)
    |> (& &1 <> @end_url).()
  end

  defp trim_name(person) do
    person
    |> (& &1.name).()
    |> String.split(" ")
    |> Enum.join("-")
  end
end
