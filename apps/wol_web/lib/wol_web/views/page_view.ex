defmodule WolWeb.PageView do
  use WolWeb, :view

  @base_url "http://wheeldecide.com/e.php?"
  @end_url "col=wol&t=Participant+1&time=5"
  @colors [
    '#eae56f',
    '#89f26e',
    '#7de6ef',
    '#e7706f'
  ]

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

  def wheel_segments(people) do
    Enum.reduce(people, {"", 0}, fn(person, {segments, index}) ->
      {segments <> """
      {'fillStyle' : '#{rem(index, 4) |> color()}', 'text' : '#{person.name}'},
      """, index + 1}
    end) |> elem(0)
  end

  def color(num) do
    Enum.at(@colors, num)
  end
end
