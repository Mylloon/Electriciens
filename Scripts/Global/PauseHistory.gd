extends Node

var _current_scene_path = "res://Scenes/Menu.tscn"
var _history := []

func switch_scene(path: String) -> Error:
	_history.push_back(_current_scene_path)
	_current_scene_path = path
	return get_tree().change_scene_to_file(path)

func return_to_last() -> Error:
	if _history.is_empty():
		exit_game()
		return Error.OK
	
	_current_scene_path = _history.pop_back()
	return get_tree().change_scene_to_file(_current_scene_path)

func clear_history() -> void:
	_history.clear()

func exit_game() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
