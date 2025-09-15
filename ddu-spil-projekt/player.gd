extends CharacterBody2D

var character_speed = 40000

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = direction * character_speed*delta
	move_and_slide()


func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation=(get_global_mouse_position()-global_position).angle()+deg_to_rad(90) #rotated 90 degrees to point it to mouse position start position
