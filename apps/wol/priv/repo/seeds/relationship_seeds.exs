alias Wol.{Repo, Organization.Person, Organization.Relationship}

adi = Repo.get_by(Person, email: "adi.iyengar@annkissam.com")
dana = Repo.get_by(Person, email: "dana.lewis@annkissam.com")
josh = Repo.get_by(Person, email: "josh.adams@annkissam.com")
matteo = Repo.get_by(Person, email: "matteo.ramosmucci@annkissam.com")
sarah = Repo.get_by(Person, email: "sarah.kulik@annkissam.com")

Repo.insert!(%Relationship{person1_id: josh.id, person2_id: adi.id, relationship_type: "supervisor"})
Repo.insert!(%Relationship{person1_id: matteo.id, person2_id: dana.id, relationship_type: "supervisor"})
Repo.insert!(%Relationship{person1_id: matteo.id, person2_id: dana.id, relationship_type: "mentor"})
Repo.insert!(%Relationship{person1_id: matteo.id, person2_id: sarah.id, relationship_type: "supervisor"})
Repo.insert!(%Relationship{person1_id: matteo.id, person2_id: sarah.id, relationship_type: "mentor"})

