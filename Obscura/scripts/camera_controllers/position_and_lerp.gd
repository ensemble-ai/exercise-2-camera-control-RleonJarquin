class_name PositionLockLerpingCamera
extends CameraControllerBase

@export var follow_speed:float
@export var catchup_speed:float
@export var leash_distance:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	position = target.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

		
	super(delta)
	
func draw_logic() -> void:
	pass
