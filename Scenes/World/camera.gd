extends Camera2D

enum SubViewports_list {
	Center_Viewport,
}

@export var SubViewport_select_index : SubViewports_list; 

var SubViewport_Node : SubViewport;
var base_resolution : Vector2 = GlobalVariables.base_resolution_center_viewport;


var exist_SubViewport : bool;
var real_resolution : Vector2;
var real_zoom : Vector2;

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout;
	var SubViewport_select : String = SubViewports_list.find_key(SubViewport_select_index);
	exist_SubViewport = get_tree().has_group(SubViewport_select);
	if (exist_SubViewport):
		SubViewport_Node = get_tree().get_first_node_in_group(SubViewport_select);
	
	
	real_zoom = zoom;

func _physics_process(delta: float) -> void:
	if (exist_SubViewport):
		zoom_resolution_camara();

func zoom_resolution_camara() -> void:
	real_resolution = SubViewport_Node.size;
	zoom = (real_zoom*real_resolution)/base_resolution;
