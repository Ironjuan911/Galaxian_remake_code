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

func start_state() -> void:
	character.velocity = lerp(character.velocity,directionHit*meter*impactSpeed,0.8);
	character.rotation_degrees = -30;
	timer_hit.start();

func local_physics_process(delta) -> void:
	character.rotation_degrees = lerp(character.rotation_degrees,0.0,0.3*delta);


func end_state() -> void:
	timer_hit.is_stopped();
	character.rotation_degrees = 0;


func _hit_timeout() -> void:
	end_state();
	character.admin_states.movement();
