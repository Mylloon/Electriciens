extends Area2D

var animation_speed = 1
var moving = false
var tile_size = 64
var inputs = {"right": Vector2.RIGHT, "left": Vector2.LEFT, "up": Vector2.UP, "down": Vector2.DOWN}

var inputs_inv = {
	"left": Vector2.LEFT, "right": Vector2.RIGHT, "down": Vector2.DOWN, "up": Vector2.UP
}

var inv = false

var directions = []
var directions_inv = []
var dir = 0

@onready var ray := $RayCast2d
@onready var timer := $Timer  # Ensure a Timer node is added in the scene
@onready var torch := $Torch
@onready var area := $Torch/ZoneDetection
@onready var check_player := $Torch/CheckPlayer

# Temps de cooldown avant de redétecter une collision, en attendant de savoir ce qu'on en fait
var grace_period := 0.2
var time_since_last_hit := 0.
var can_detect_collission := true

var under_light := false  # Vrai si dans la lumière


func _ready():
	randomize()
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2

	# Generate 4 random movement directions
	for n in 4:
		var alea = randi_range(0, inputs.keys().size() - 1)
		directions.append(inputs.keys()[alea])
		directions_inv.append(inputs_inv.keys()[alea])

	directions_inv.reverse()

	# Start timer for automatic movement
	timer.wait_time = 1.5
	timer.one_shot = false
	timer.timeout.connect(_on_Timer_timeout)
	timer.start()


func _on_Timer_timeout():
	if !moving:
		move(directions_inv[dir] if inv else directions[dir])


# Return correct direction
func direction():
	if inv:
		return directions_inv[dir]
	return directions[dir]


# Return the rotation of the light, depending of the current direction
func get_rotation_light(asked_dir: String):
	match inputs_inv[asked_dir]:
		Vector2.UP:
			return 180
		Vector2.DOWN:
			return 0
		Vector2.LEFT:
			return 90
		Vector2.RIGHT:
			return -90


func next():
	dir = (dir + 1) % directions.size()
	if dir == 0:
		inv = !inv


func move(asked_dir):
	ray.target_position = inputs[asked_dir] * tile_size
	ray.force_raycast_update()

	if !ray.is_colliding():
		moving = true
		var tween = get_tree().create_tween()
		(
			tween
			. tween_property(
				self, "position", position + inputs[asked_dir] * tile_size, 1.0 / animation_speed
			)
			. set_trans(Tween.TRANS_SINE)
		)

		torch.set_rotation_degrees(get_rotation_light(direction()))

		$AnimationPlayer.play(asked_dir)
		await tween.finished
		moving = false
	next()


func _physics_process(delta: float) -> void:
	if !can_detect_collission:
		time_since_last_hit += delta
		if time_since_last_hit >= grace_period:
			time_since_last_hit = 0.
			can_detect_collission = true
		return

	var player_under_light := false

	for body in area.get_overlapping_bodies():
		if body is Player:
			check_player.set_target_position(check_player.to_local(body.get_global_position()))
			ray.force_raycast_update()
			if check_player.get_collider() is Player:
				can_detect_collission = false
				player_under_light = true
				break

	if under_light and !player_under_light:
		under_light = false
	elif player_under_light:
		under_light = true


func _process(delta: float) -> void:
	if under_light:
		print("Dans la viande")
