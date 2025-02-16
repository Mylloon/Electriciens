extends Node2D

@onready var switcher = get_node("/root/PauseHistory")

@onready var success: TileMapLayer = $TileMap/floor/success
@onready var walls: TileMapLayer = $TileMap/walls
@onready var player: Player = $Player


func _physics_process(_delta: float) -> void:
	if(!player):
		player = $Player
		return
	else :	
		var tile_loc := success.local_to_map(player.position)
		var tile := success.get_cell_tile_data(tile_loc)
		if tile and tile.get_custom_data("coin"):
			switcher.switch_scene("res://Scenes/LevelChooser.tscn")
			return
		
		for el:TileMapLayer in walls.get_children():
			var tile_loc_laser := el.local_to_map(player.position)
			var tile_laser := el.get_cell_tile_data(tile_loc_laser)
			if tile_laser and tile_laser.get_custom_data("laser") and el.enabled:
				player.queue_free()
		
		


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		switcher.switch_scene("res://Scenes/Pause.tscn", true)
