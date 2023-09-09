extends Area2D
signal consumida()

func _on_ZanahoriaLlave_body_entered(_body):
	DatosPlayer.restar_llaves()
	emit_signal("consumida")
	$DetectorPersonaje.set_deferred("disabled", true)
	$AnimationPlayer.play("consumir")
