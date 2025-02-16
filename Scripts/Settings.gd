extends Control

@onready var switcher = get_node("/root/PauseHistory")


func _on_button_pressed() -> void:
	switcher.return_to_last()
