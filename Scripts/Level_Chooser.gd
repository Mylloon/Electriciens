extends Control

@onready var switcher = get_node("/root/PauseHistory")


func _on_level_1_pressed() -> void:
	print("level 1")


func _on_level_2_pressed() -> void:
	print("level 2")


func _on_level_3_pressed() -> void:
	print("level 3")


func _on_level_4_pressed() -> void:
	print("level 4")


func _on_level_infinite_pressed() -> void:
	print("infini")


func _on_button_return_pressed() -> void:
	switcher.return_to_last()
