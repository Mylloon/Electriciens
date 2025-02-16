extends Node2D

@onready var switcher = get_node("/root/PauseHistory")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		switcher.switch_scene("res://Scenes/Pause.tscn")
