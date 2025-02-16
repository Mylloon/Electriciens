extends Control

@onready var switcher = get_node("/root/PauseHistory")

@onready var playback: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var volume: HSlider = $HBoxContainer/Volume
@export var audio_bus_name := "Master"
@onready var bus := AudioServer.get_bus_index(audio_bus_name)


func _ready() -> void:
	volume.value = db_to_linear(AudioServer.get_bus_volume_db(bus))


func _on_button_pressed() -> void:
	switcher.return_to_last()


func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))


func _on_button() -> void:
	playback.stop()
	playback.play()
