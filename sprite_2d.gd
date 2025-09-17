extends Sprite2D
@export var speed: float=100
@export var area_min: Vector2=Vector2(0,1152)
@export var area_max: Vector2=Vector2(300,520)

@onready var ninja: CharacterBody2D=get_node("../../player")
@export var damage:int=20
@export var damage_cooldown:float=1
var time_since_last_hit:float=0
var hp=10

func _ready() -> void:
	var random_x =randf_range(area_min.x,area_max.x)
	var random_y =randf_range(area_min.y,area_max.y)
	position=Vector2(random_x,random_y)



func _process(delta: float) -> void:
	time_since_last_hit+=delta
	
	if ninja:
		var direction=(ninja.global_position-global_position).normalized()
		position+=direction*speed*delta

	if global_position.distance_to(ninja.position)<120:
		if time_since_last_hit>=damage_cooldown:
			ninja.take_damage(damage)
			time_since_last_hit=0


var enemy_health=100

func _on_area_2d_area_entered(area: Area2D) -> void:
	enemy_health-=damage
	if enemy_health<=0:
		#tilfør animation
		queue_free()
	
