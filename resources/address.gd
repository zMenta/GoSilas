extends Resource
class_name Address

@export var state: String:
	set(new_value):
		state = new_value
		emit_changed()

@export var city: String:
	set(new_value):
		city = new_value
		emit_changed()

@export var street_name: String:
	set(new_value):
		street_name = new_value
		emit_changed()

@export var street_number: int:
	set(new_value):
		street_number = new_value
		emit_changed()
