extends Node2D


@onready var audio_stream_player = $AudioStreamPlayer

func _on_audio_stream_player_finished():
	audio_stream_player.play()
