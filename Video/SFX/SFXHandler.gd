extends Node

func play_sfx(sound, pitch_range: Vector2 = Vector2(1.0,1.0), 
			  volume_db: float = 1.0, parent: Node = get_tree().current_scene):
	if sound != null and parent != null:
		var stream = AudioStreamPlayer2D.new()
		
		stream.stream = sound
		
		stream.connect("finished",stream,"queue_free")
		
		stream.pitch_scale = rand_range(pitch_range.x, pitch_range.y)
		stream.volume_db = volume_db
		
		parent.add_child(stream)
		stream.play()
	
