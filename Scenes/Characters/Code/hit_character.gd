extends Node;
class_name HitCharacter;

@export var time_hit : float = 0.3;
@onready var character : Character = get_parent().get_parent();
@onready var timer_hit: Timer = $TimerHit

var deltaVelocity : Vector2;

func _ready() -> void:
	timer_hit.wait_time = time_hit;

func activated() -> void:
	timer_hit.start();

func local_physics_process(delta) -> void:
	deltaVelocity = Vector2(
		GlobalVariables.create_random_number2(-5.0,5.0),
		GlobalVariables.create_random_number2(-5.0,5.0)
	);
	
	character.velocity = lerp(character.velocity,deltaVelocity,0.1);
	pass;


func _hit_timeout() -> void:
	character.admin_states.movement();
