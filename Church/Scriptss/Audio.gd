extends AudioStreamPlayer

func _on_Ink_call_sfx(sfx):
	var stream: AudioStream = load("res://audio/" + sfx + ".ogg")
	self.set_stream(stream)
	self.set_volume_db(3.0)
	play()


func _on_Ink_stop_sfx():
	stop()
	print("stop")
