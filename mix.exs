defmodule Wol.Umbrella.Mixfile do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      aliases: aliases(),
      included_applications: included_applications(),
    ]
  end

  defp included_applications do
    []
  end

  defp deps do
    []
  end

  defp aliases do
    [
      "ecto.setup": [
        "ecto.create",
        "ecto.migrate",
        "run apps/wol/priv/repo/seeds.exs"
      ],
     "ecto.reset": [
        "ecto.drop",
        "ecto.setup"
      ],
     "test": [
        # "ecto.drop", # NOTE: If a developer modified existing migrations, uncomment this for a test run...
        "ecto.create --quiet",
        "ecto.migrate",
        "test"
      ],
    ]
  end
end
