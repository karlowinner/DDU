extends CharacterBody2D

var character_speed = 400
@onready var main = get_tree().current_scene
@onready var projectile = load("res://projectile.tscn")

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = direction * character_speed
	move_and_slide()

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation = (get_global_mouse_position() - global_position).angle() + deg_to_rad(90)

func _input(_event):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = rotation
	instance.zdex = z_index - 1

	var base_velocity = Vector2(0, -instance.Speed).rotated(instance.dir)
	instance.initial_velocity = base_velocity + velocity

	main.call_deferred("add_child", instance)


@export var health_max: int = 100
var health: int
@onready var health_bar: ProgressBar =$"../CanvasLayer/healthbar"
@onready var enemy: Node2D=$"../enemy"

func _ready() -> void:
	health = health_max
	health_bar.min_value = 0
	health_bar.max_value = health_max
	health_bar.value = health
	print("healthbar:",health_bar)


func die()->void:
	get_tree().change_scene_to_file("res://gameover.tscn")

func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		print("Player døde!")
		die()
	if health_bar:
		health_bar.value = health
		
#func _on_hit_box_body_entered(body: Node2D) -> void:
#	if body is enemy:
#		died.emit()
#		queue_free()
