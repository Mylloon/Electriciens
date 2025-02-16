extends Node2D

var player_scene = preload("res://Characters/Player.tscn")
var player = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player == null:
		var new_obj = player_scene.instantiate()
		var posX: int = position.x
		var posY: int = position.y
		new_obj.position.x = posX
		new_obj.position.y = posY
		get_parent().add_child(new_obj)
		player = new_obj
