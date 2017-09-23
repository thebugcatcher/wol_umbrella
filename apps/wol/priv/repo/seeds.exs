# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Wol.Repo.insert!(%Wol.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Code.require_file("apps/wol/priv/repo/seeds/people_seeds.exs")
Code.require_file("apps/wol/priv/repo/seeds/relationship_seeds.exs")
Code.require_file("apps/wol/priv/repo/seeds/iteration_seeds.exs")

