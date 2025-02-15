extends TileMapLayer

@export var tile_set_source_id: int = 0  # TileSet source ID (check your TileSet
@export var atlas_tile_id: int = 0  # ID of the atlas tile to use
@export var  atlas_coord : Vector2i
@export var  pos_test : Vector2i
@export var  color : int
@export var  caller : Node


func _ready():
	
	var callable = Callable(self, "changeVisibility")
	caller.connect("changeColorFilter", callable)
	randomize()  # Ensure randomness each run
	set_cell(pos_test, 0, atlas_coord)
func changeVisibility():
	if(FilterColor.current(true) == color):
		enabled = false
	else:
		enabled = true 
		



	
