extends Area2D

export var es_trampa = false
onready var detector_personaje = $RayCast2D
var color_trampa =  Color.purple

func _ready():
	if es_trampa:
		$Sprite.modulate = color_trampa
		rotation_degrees = 180
		detector_personaje.enabled = true
		
func _process(_delta):
	if detector_personaje.is_colliding():
		detector_personaje.set_deferred("enabled", true)
		$AnimationPlayer.play("caer")

func _on_Pinchos_body_entered(body):
	body.respawn()
