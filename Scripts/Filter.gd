extends ColorRect

@onready var timer = $Timer
signal changeColor()

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	emit_signal("changeColor")
	
	self.color = FilterColor.current()
	# Start timer for automatic movement
	timer.wait_time = 3
	timer.one_shot = false
	timer.timeout.connect(_on_Timer_timeout)
	timer.start()


func _process(_delta: float) -> void:
	pass
	#if Input.is_action_just_pressed("changefilter"):
	#self.color = FilterColor.next()


func _on_Timer_timeout():
	self.color = FilterColor.next()
	emit_signal("changeColor")
