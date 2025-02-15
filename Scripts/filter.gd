extends ColorRect

func _ready() -> void:
	self.color = FilterColor.current()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("changefilter"):
		self.color = FilterColor.next()
