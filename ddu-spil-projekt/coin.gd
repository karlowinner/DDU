extends Area2D

func _ready():
	$AnimationPlayer.play("active")

func _on_body_entered(body: Node2D) -> void:
	if body.name =="player":
		$AnimationPlayer.play("destroy")
		await $AnimationPlayer.animation_finished
		queue_free()
