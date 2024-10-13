extends Resource
class_name Adopter

var address: Address:
	set(new_value):
		address = new_value
		emit_changed()

var adopted_animals: Array[Animal]:
	set(new_value):
		adopted_animals = new_value
		emit_changed()

var name: String:
	set(new_value):
		name = new_value
		emit_changed()

var cpf: String:
	set(new_value):
		cpf = new_value
		emit_changed()

var telephone_number: String:
	set(new_value):
		telephone_number = new_value
		emit_changed()

var observations: String:
	set(new_value):
		observations = new_value
		emit_changed()
