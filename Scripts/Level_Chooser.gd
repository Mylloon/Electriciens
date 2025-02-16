extends Control

@onready var switcher = get_node("/root/PauseHistory")


func _on_level_1_pressed() -> void:
	switcher.switch_scene("res://Scenes/Levels/Level1.tscn")


func _on_level_2_pressed() -> void:
	switcher.switch_scene("res://Scenes/Levels/Level2.tscn")


func _on_level_3_pressed() -> void:
	switcher.switch_scene("res://Scenes/Levels/Level3.tscn")


func _on_level_4_pressed() -> void:
	switcher.switch_scene("res://Scenes/Levels/Level4.tscn")


func _on_level_infinite_pressed() -> void:
	print("infini")


func _on_button_return_pressed() -> void:
	switcher.return_to_last()
