use Mix.Config

config :wol, ecto_repos: [Wol.Repo]

import_config "#{Mix.env}.exs"
