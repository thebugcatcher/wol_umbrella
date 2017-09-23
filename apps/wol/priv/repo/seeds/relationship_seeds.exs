alias Wol.{Repo, Organization.Person, Organization.Relationship}

adi = Repo.get_by(Person, email: "adi.iyengar@annkissam.com")
allison = Repo.get_by(Person, email: "allison.dyer@annkissam.com")
clarence = Repo.get_by(Person, email: "clarence.lee@annkissam.com")
david = Repo.get_by(Person, email: "david.argueta@annkissam.com")
josh = Repo.get_by(Person, email: "josh.adams@annkissam.com")
ryan = Repo.get_by(Person, email: "ryan.vasios@annkissam.com")
zoe = Repo.get_by(Person, email: "zoe.carlberg@annkissam.com")

Repo.insert!(%Relationship{person1_id: josh.id, person2_id: adi.id, relationship_type: "supervisor"})
Repo.insert!(%Relationship{person1_id: josh.id, person2_id: allison.id, relationship_type: "supervisor"})
Repo.insert!(%Relationship{person1_id: josh.id, person2_id: clarence.id, relationship_type: "supervisor"})
Repo.insert!(%Relationship{person1_id: josh.id, person2_id: david.id, relationship_type: "supervisor"})
Repo.insert!(%Relationship{person1_id: josh.id, person2_id: zoe.id, relationship_type: "supervisor"})
Repo.insert!(%Relationship{person1_id: david.id, person2_id: ryan.id, relationship_type: "supervisor"})
Repo.insert!(%Relationship{person1_id: david.id, person2_id: ryan.id, relationship_type: "mentor"})
Repo.insert!(%Relationship{person1_id: zoe.id, person2_id: clarence.id, relationship_type: "mentor"})

