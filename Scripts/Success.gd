extends Node2D

@onready var switcher = get_node("/root/PauseHistory")

@onready var success: TileMapLayer = $TileMap/floor/success
@onready var player: Player = $Player


func _physics_process(_delta: float) -> void:
	var tile_loc := success.local_to_map(player.position)
	var tile := success.get_cell_tile_data(tile_loc)
	if tile and tile.get_custom_data("coin"):
		switcher.switch_scene("res://Scenes/LevelChooser.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		switcher.switch_scene("res://Scenes/Pause.tscn")
