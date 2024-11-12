class_name LerpTargetFocus
extends CameraControllerBase

@export var lead_speed:float
@export var catchup_delay_duration:float
@export var catchup_speed:float
@export var leash_distance:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	#position = target.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic: 
		draw_logic()
		
	super(delta)
	
	var tpos = target.global_position
	var cpos = global_position
	
	var smoothing = 0.95
	var follow_direction = target.velocity.normalized()
	var target_speed = target.velocity.length()
	
	#If the player is at max leash distance relative to the camrea. 
	#Have the player go at the same speed as the camera
	if Vector2(cpos.x, cpos.z).distance_to(Vector2(tpos.x,tpos.z)) > leash_distance:
		target.global_position = target.global_position + follow_direction * lead_speed * delta 

	#If the player is moving follow the camera at catch up speed. Otherwise if not moving follow 
	# use catch up delay to slow down the camera to player position.4
	if(target.velocity.length() != 0):
		global_position = global_position + follow_direction * (lead_speed + target_speed) * delta * smoothing
	else:
		var new_x = lerp(cpos.x, tpos.x, 1/catchup_delay_duration)
		var new_z =  lerp(cpos.z, tpos.z, 1/catchup_delay_duration)
		global_position = Vector3(new_x, global_position.y, new_z)
		
	
func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -5))
	
	immediate_mesh.surface_add_vertex(Vector3(5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(-5, 0, 0))

	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
