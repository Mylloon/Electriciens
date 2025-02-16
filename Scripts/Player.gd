class_name Player
extends CharacterBody2D

var animation_speed = 2.5
var moving = false
var tile_size = 64
var inputs = {"right": Vector2.RIGHT, "left": Vector2.LEFT, "up": Vector2.UP, "down": Vector2.DOWN}

@onready var ray = $RayCast2d

var frozen := false
@onready var collision := self.get_collision_layer()


func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2


func _unhandled_input(event):
	if moving:
		return

	for dir in inputs.keys():
		if event.is_action_pressed(dir, true):
			move(dir)


func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding() and !frozen:
		#position += inputs[dir] * tile_size
		var tween = get_tree().create_tween()
		(
			tween
			. tween_property(
				self, "position", position + inputs[dir] * tile_size, 1.0 / animation_speed
			)
			. set_trans(Tween.TRANS_SINE)
		)
		moving = true
		$AnimationPlayer.play(dir)
		await tween.finished
		moving = false


func get_frozen_color() -> Color:
	return Color(FilterColor.current(), 0.2)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("freeze"):
		frozen = !frozen
		if frozen:
			self.set_collision_layer(0)
			self.modulate = get_frozen_color()
		else:
			self.set_collision_layer(collision)
			self.modulate = Color.WHITE


func _on_filter_change_color_filter() -> void:
	if frozen:
		self.modulate = get_frozen_color()
