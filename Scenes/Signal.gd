extends Node

@export var caller: Node
signal changeColorFilter


func _ready() -> void:
	var callable = Callable(self, "_changeColorFilter")
	caller.connect("changeColor", callable)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _changeColorFilter():
	emit_signal("changeColorFilter")
