extends Area2D

onready var detector_jugador = $DetectorJugador
onready var detector_pisoton = $DetectorPisoton/Colisionador
onready var animacion = $AnimationPlayer

func _on_DetectorPisoton_body_entered(body):
	desactivarColisionares([detector_jugador,detector_pisoton])
	animacion.stop()
	animacion.play("morir")
	body.impulsar()
	


func _on_Volon_body_entered(body):
	body.respawn()


func desactivarColisionares(colisionadores):
	for colision in colisionadores:
		colision.set_deferred("disabled", true)
		colision.set_deferred("visible", false)
