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

@onready var ray = $RayCast2d
@onready var timer = $Timer  # Ensure a Timer node is added in the scene


func _ready():
	randomize()
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2

	# Generate 4 random movement directions
	for n in 4:
		var alea = randi_range(0, inputs.keys().size() - 1)
		directions.append(inputs.keys()[alea])
		directions_inv.append(inputs_inv.keys()[alea])

	print(directions)
	directions_inv.reverse()
	print(directions_inv)

	# Start timer for automatic movement
	timer.wait_time = 1.5
	timer.one_shot = false
	timer.timeout.connect(_on_Timer_timeout)
	timer.start()


func _on_Timer_timeout():
	print("here")
	if !moving:
		print("Je vais bouger")
		move(directions_inv[dir] if inv else directions[dir])


func next():
	print(dir)
	dir = (dir + 1) % directions.size()
	if dir == 0:
		inv = !inv


func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()

	if !ray.is_colliding():
		moving = true
		var tween = get_tree().create_tween()
		(
			tween
			. tween_property(
				self, "position", position + inputs[dir] * tile_size, 1.0 / animation_speed
			)
			. set_trans(Tween.TRANS_SINE)
		)
		$AnimationPlayer.play(dir)
		await tween.finished
		moving = false
	next()
