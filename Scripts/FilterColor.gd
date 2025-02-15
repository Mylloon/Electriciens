class_name FilterColor

static var current_color: ColorsEnum.Colors = ColorsEnum.Colors.RED


static func next() -> Color:
	current_color = ColorsEnum.Colors.values()[(current_color + 1) % ColorsEnum.colors.size()]
	return current()


static func current(name: bool = false) -> Variant:
	if name:
		return current_color
	return ColorsEnum.colors[current_color]
