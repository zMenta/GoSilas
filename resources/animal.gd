extends Resource
class_name Animal

@export var adopter: Adopter:
	set(new_value):
		adopter = new_value
		emit_changed()

@export var address: Address:
	set(new_value):
		address = new_value
		emit_changed()

@export var name: String:
	set(new_value):
		name = new_value
		emit_changed()

@export var image: Texture2D:
	set(new_value):
		image = new_value
		emit_changed()

@export var is_castrated: bool:
	set(new_value):
		is_castrated = new_value
		emit_changed()

@export_enum("Male", "Female") var Sex: int:
	set(new_value):
		Sex = new_value
		emit_changed()

@export_enum("Small", "Medium", "Big", "Extra_Big") var Size: int:
	set(new_value):
		Size = new_value
		emit_changed()

@export_enum("Friendly", "Agressive") var Character: int:
	set(new_value):
		Character = new_value
		emit_changed()

@export var health_state: String:
	set(new_value):
		health_state = new_value
		emit_changed()
