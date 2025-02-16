extends TileMapLayer

@export var tile_set_source_id: int = 0  # TileSet source ID (check your TileSet
@export var atlas_tile_id: int = 0  # ID of the atlas tile to use
var atlas_coord: Vector2i = Vector2i(2,3)
var atlas_coord_r: Vector2i = Vector2i(2,3)
var atlas_coord_b: Vector2i = Vector2i(3,3)
var atlas_coord_g: Vector2i = Vector2i(4,3)
var pos = Vector2i(12,0)
@export var pos_test: Vector2i
@export var color: int
@export var caller: Node



func _ready():
	var callable = Callable(self, "changeColorOrder")
	caller.connect("changeColorFilter", callable)
	changeColorOrder()
	


func changeColorOrder():
	print("on change de couleur")
	var color=FilterColor.current(true)
	for n in 5:
		var colors = ((color+n)%ColorsEnum.colors.size())
		print("colors : ", color)
		set_cell(Vector2i(pos.x+n,pos.y), 0, Vector2i(1+colors, 3))
