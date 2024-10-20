extends Resource
class_name Adopter

@export var address: Address:
	set(new_value):
		address = new_value
		emit_changed()

@export var adopted_animals: Array[Animal]:
	set(new_value):
		adopted_animals = new_value
		emit_changed()

@export var name: String:
	set(new_value):
		name = new_value
		emit_changed()

@export var cpf: String:
	set(new_value):
		cpf = new_value
		emit_changed()

@export var telephone_number: String:
	set(new_value):
		telephone_number = new_value
		emit_changed()

@export var observations: String:
	set(new_value):
		observations = new_value
		emit_changed()
