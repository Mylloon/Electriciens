class_name FilterColor

enum Colors {
	RED,
	BLUE
}

static var colors: Dictionary = {
	Colors.RED: Color(0.5, 0, 0, 0.4),
	Colors.BLUE: Color(0, 0, 0.5, 0.4),
}

static var current_color: Colors = Colors.RED

static func next() -> Color:
	current_color = Colors.values()[(current_color + 1) % colors.size()]
	return current()

static func current(name: bool = false) -> Variant:
	if name:
		return current_color
	return colors[current_color]
