sphere = Sphere.new(name: "General and reference", description: "General and reference", parent_id: 0)
sphere.save
id = sphere.id

sphere1 = Sphere.new(name: "Document types", description: "Document types", parent_id: id)
sphere1.save
id1 = sphere1.id
Sphere.create(name: "Surveys and overviews", description: "Surveys and overviews", parent_id: id1)
Sphere.create(name: "Reference works", description: "Reference works", parent_id: id1)
Sphere.create(name: "General conference proceedings", description: "General conference proceedings", parent_id: id1)
Sphere.create(name: "Biographies", description: "Biographies", parent_id: id1)

sphere2 = Sphere.new(name: "Cross-computing tools and techniques", description: "Cross-computing tools and techniques", parent_id: id)
sphere2.save
id2 = sphere2.id
Sphere.create(name: "Reliability", description: "Reliability", parent_id: id2)
Sphere.create(name: "Empirical studies", description: "Empirical studies", parent_id: id2)
Sphere.create(name: "Measurement", description: "Measurement", parent_id: id2)
Sphere.create(name: "Experimentation", description: "Experimentation", parent_id: id2)


_sphere = Sphere.new(name: "Hardware", description: "Hardware", parent_id: 0)
_sphere.save
_id = _sphere.id

_sphere1 = Sphere.new(name: "Printed circuit boards", description: "Printed circuit boards", parent_id: _id)
_sphere1.save
_id1 = _sphere1.id
Sphere.create(name: "Signal processing systems", description: "Signal processing systems", parent_id: _id1)
Sphere.create(name: "Sensors and actuators", description: "Sensors and actuators", parent_id: _id1)
Sphere.create(name: "Buses and high-speed links", description: "Buses and high-speed links", parent_id: _id1)
Sphere.create(name: "Displays and imagers", description: "Displays and imagers", parent_id: _id1)

_sphere2 = Sphere.new(name: "3D integrated circuits", description: "3D integrated circuits", parent_id: _id)
sphere2.save
_id2 = sphere2.id
Sphere.create(name: "Input / output circuits", description: "Input / output circuits", parent_id: _id2)
Sphere.create(name: "Metallic interconnect", description: "Metallic interconnect", parent_id: _id2)
Sphere.create(name: "Photonic and optical interconnect", description: "Photonic and optical interconnect", parent_id: _id2)
Sphere.create(name: "Radio frequency and wireless interconnect", description: "Radio frequency and wireless interconnect", parent_id: _id2)
