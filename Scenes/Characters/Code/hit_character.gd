extends Node;
class_name HitCharacter;

@export var time_hit : float = 0.2;
@onready var character : Character = get_parent().get_parent();
@onready var timer_hit: Timer = $TimerHit
@onready var meter : int = GlobalVariables.meter;
var impactSpeed : int = 15;

var deltaVelocity : Vector2;
var directionHit : Vector2;

func _ready() -> void:
	timer_hit.wait_time = time_hit;

func activated() -> void:
	timer_hit.start();

func local_physics_process(delta) -> void:
	
	character.velocity = lerp(character.velocity,directionHit*meter*impactSpeed*delta,0.8);
	pass;


func _hit_timeout() -> void:
	character.admin_states.movement();
