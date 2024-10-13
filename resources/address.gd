extends Resource
class_name Address

var state: String:
	set(new_value):
		state = new_value
		emit_changed()

var city: String:
	set(new_value):
		city = new_value
		emit_changed()

var street_name: String:
	set(new_value):
		street_name = new_value
		emit_changed()

var street_number: int:
	set(new_value):
		street_number = new_value
		emit_changed()
