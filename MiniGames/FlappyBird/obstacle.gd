extends Node2D

signal score
signal collision


func _on_upper_body_entered(body: Node2D) -> void:
	if body is PlayerBird:
		emit_signal("collision")

func _on_lower_body_entered(body: Node2D) -> void:
	if body is PlayerBird:
		emit_signal("collision")

func _on_score_body_entered(body: Node2D) -> void:
	if body is PlayerBird:
		emit_signal("score")
