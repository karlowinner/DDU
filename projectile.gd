extends CharacterBody2D

@export var Speed = 500

var dir : float
var spawnPos : Vector2
var spawnRot : float
var zdex : int
var initial_velocity: Vector2 =Vector2.ZERO

func _ready() -> void:
	global_position = spawnPos
	global_rotation = spawnRot
	z_index =zdex
	
func _physics_process(delta: float) -> void:
	global_position+=initial_velocity*delta
