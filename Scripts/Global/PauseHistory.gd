extends Node

var _current_scene_path = "res://Scenes/Menu.tscn"
var _history := []
var _paused_scenes := {}  

func switch_scene(path: String, pause: bool = false) -> Error:
	_history.push_back(_current_scene_path)
	if pause:
		var current_scene = get_tree().get_current_scene()
		current_scene.process_mode = Node.PROCESS_MODE_DISABLED
		_paused_scenes[_current_scene_path] = current_scene
		current_scene.get_parent().remove_child(current_scene)
		var new_scene = load(path).instantiate()
		get_tree().root.add_child(new_scene)
		get_tree().set_current_scene(new_scene)
		_current_scene_path = path
		return Error.OK
		
	_current_scene_path = path
	return get_tree().change_scene_to_file(path)
	
func return_to_last(was_paused: bool = false) -> Error:
	if _history.is_empty():
		exit_game()
		return Error.OK
		
	_current_scene_path = _history.pop_back()
	
	if was_paused:
		var current_scene = get_tree().current_scene
		current_scene.queue_free()
		var paused_scene = _paused_scenes[_current_scene_path]
		get_tree().root.add_child(paused_scene)
		get_tree().set_current_scene(paused_scene)
		_paused_scenes.erase(_current_scene_path)
		paused_scene.process_mode = Node.PROCESS_MODE_ALWAYS
		return Error.OK
		
	return get_tree().change_scene_to_file(_current_scene_path)

func clear_history() -> void:
	_history.clear()
	_paused_scenes.clear()

func exit_game() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
