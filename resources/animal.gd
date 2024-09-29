extends Resource
class_name Animal

var id: int
@export var adopter_id: int = 0
@export var address_id: int = 0

@export var image: Texture2D
@export var is_castrated: bool
@export_enum("Male", "Female") var Sex: int
@export_enum("Small", "Medium", "Big", "Extra_Big") var Size: int
@export_enum("Friendly", "Agressive") var Character: int
@export var health_state: String
