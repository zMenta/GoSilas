extends Node

@export var data : SaveFile
var test := 15

func _ready() -> void:
	print(test)
	print("Cool test")
	data.hello()
