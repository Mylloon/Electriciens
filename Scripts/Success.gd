extends TileMapLayer

# Temps de cooldown avant de redétecter une collision, en attendant de savoir ce qu'on en fait
var grace_period := 0.2
var time_since_last_hit := 0.
var can_detect_collission := true
@onready var area := self

var under_light := false  # Vrai si dans la lumière

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	#if !can_detect_collission:
		#time_since_last_hit += delta
		#if time_since_last_hit >= grace_period:
			#time_since_last_hit = 0.
			#can_detect_collission = true
		#return

	var player_under_light := false
	print("dans la func")
	for body in area.get_overlapping_bodies():
		print("test")

	if under_light and !player_under_light:
		under_light = false
	elif player_under_light:
		under_light = true


func _process(_delta: float) -> void:
	if under_light:
		print("Dans la viande")
