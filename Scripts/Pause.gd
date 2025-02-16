extends Control

@onready var switcher = get_node("/root/PauseHistory")
@onready var playback: AudioStreamPlayer2D = $AudioStreamPlayer2D
# TODO: Pause the scene instead of replacing it with the pause screen


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		switcher.return_to_last(true)


func _on_back_button_pressed() -> void:
	switcher.return_to_last(true)


func _on_menu_button_pressed() -> void:
	switcher.clear_history()
	switcher.switch_scene("res://Scenes/Menu.tscn")


func _on_exit_button_pressed() -> void:
	switcher.exit_game()

	
func _on_button_focus() -> void:
	playback.stop()
	playback.play()
