extends Node;
class_name HitCharacter;

@export var time_hit : float = 0.2;
@onready var character : Character = get_parent().get_parent();
@onready var timer_hit: Timer = $TimerHit
@onready var meter : int = GlobalVariables.meter;

var baseImpactSpeed : int = 15;
var impactSpeed : int;

const defaultDamage : int = 1;
var damage : float = defaultDamage;

var directionHit : Vector2;
var colorSprite : float;

func _ready() -> void:
	impactSpeed = baseImpactSpeed;
	timer_hit.wait_time = time_hit;

func start_state() -> void:
	character.healt = character.healt - damage;
	if (character.healt <= 0):
		await get_tree().process_frame;
		character.admin_states.dead();
	else:
		start();

func start() -> void:
	character.velocity = lerp(character.velocity,directionHit*meter*impactSpeed,0.8);
	character.rotation_degrees = -30;
	character.sprite.material.set("shader_parameter/white",1);
	colorSprite = character.sprite.material.get("shader_parameter/white");
	timer_hit.start();


func local_physics_process(delta) -> void:
	character.rotation_degrees = lerp(character.rotation_degrees,0.0,0.3*delta);
	
	colorSprite = lerp(colorSprite,0.0,0.2*delta);
	character.sprite.material.set("shader_parameter/white",colorSprite);


func end_state() -> void:
	damage = defaultDamage;
	impactSpeed = baseImpactSpeed;
	timer_hit.is_stopped();
	character.rotation_degrees = 0;
	character.sprite.material.set("shader_parameter/white",0);


func _hit_timeout() -> void:
	end_state();
	character.admin_states.movement();
