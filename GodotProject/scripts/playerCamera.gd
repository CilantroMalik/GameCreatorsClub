extends Camera2D

onready var player = get_node("../player")

var camera_track_x = 250
var camera_track_y = 150

func _process (delta):
	# tracking x value
	if player.position.x > position.x + camera_track_x:
		position.x = player.position.x - camera_track_x
	if player.position.x < position.x - camera_track_x:
		position.x = player.position.x + camera_track_x

	# tracking y value
	if player.position.y > position.y + camera_track_y:
		position.y = player.position.y - camera_track_y
	if player.position.y < position.y - camera_track_y:
		position.y = player.position.y + camera_track_y
