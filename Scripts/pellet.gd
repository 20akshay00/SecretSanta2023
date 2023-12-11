extends Area2D

func _on_body_entered(body: Node2D) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(0., 0.), 0.25)
	tween.tween_callback(queue_free)
