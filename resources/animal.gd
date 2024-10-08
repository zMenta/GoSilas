extends Resource
class_name Animal

@export var adopter: Adopter
@export var address: Address

@export var name: String
@export var image: Texture2D
@export var is_castrated: bool
@export_enum("Male", "Female") var Sex: int
@export_enum("Small", "Medium", "Big", "Extra_Big") var Size: int
@export_enum("Friendly", "Agressive") var Character: int
@export var health_state: String
