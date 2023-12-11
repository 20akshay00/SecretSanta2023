extends Area2D

@onready var rect = $CollisionShape2D.shape
@onready var particles = $GPUParticles2D

# var default_gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	var extents = rect.get_size()
	particles.process_material.emission_box_extents = Vector3(extents.x/2 - 10., extents.y/2 - 10., 0.)
	
	var acc = gravity * gravity_direction
	particles.process_material.gravity = Vector3(acc.x, acc.y, 0.)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
