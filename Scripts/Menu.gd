extends Control

@onready var switcher = get_node("/root/PauseHistory")
@onready var light_o1: PointLight2D = %FirstO
@onready var light_o2: PointLight2D = %SecondO
@onready var start_button: TextureButton = $HFlowContainer/StartButton


func _ready():
	if !Input.get_connected_joypads().is_empty():
		start_button.grab_focus()


func _on_start_button_pressed() -> void:
	switcher.switch_scene("res://Scenes/Main.tscn")


func _on_options_button_pressed() -> void:
	switcher.switch_scene("res://Scenes/Settings.tscn")


func _on_levels_button_pressed() -> void:
	switcher.switch_scene("res://Scenes/LevelChooser.tscn")


func _on_exit_button_pressed() -> void:
	switcher.exit_game()


func get_random_color() -> Color:
	var size = ColorsEnum.colors.size()
	print(size)
	var random_key = ColorsEnum.colors.keys()[randi() % size]
	print(random_key)
	return Color(ColorsEnum.colors[random_key], 1.)


func _on_timer_timeout() -> void:
	print(get_random_color())
	light_o1.color = get_random_color()
	light_o2.color = get_random_color()
