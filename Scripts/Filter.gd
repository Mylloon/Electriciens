extends ColorRect

@onready var timer = $Timer
signal changeColor


func _ready() -> void:
	await get_tree().create_timer(1).timeout
	changeColor.emit()

	self.color = FilterColor.current()
	# Start timer for automatic movement
	timer.wait_time = 3
	timer.one_shot = false
	timer.timeout.connect(_on_Timer_timeout)
	timer.start()


func _on_Timer_timeout():
	self.color = FilterColor.next()
	changeColor.emit()
