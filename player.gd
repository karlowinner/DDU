extends CharacterBody2D

var character_speed = 400

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = direction * character_speed
	move_and_slide()


func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation=(get_global_mouse_position()-global_position).angle()+deg_to_rad(90) #rotated 90 degrees to point it to mouse position start position

@onready var main = get_tree().get_root().get_node("main")
@onready var projectile = load("res://projectile.tscn")

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		shoot()
		#runs func shoot on costum event

func shoot():
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = rotation
	instance.zdex =z_index-1
	
	var base_velocity = Vector2(0, -instance.Speed).rotated(instance.dir)
	#beregner projektiles fart
	
	instance.initial_velocity =base_velocity+get_real_velocity()
	#ligger spilleren hastighed
	
	main.add_child.call_deferred(instance)
