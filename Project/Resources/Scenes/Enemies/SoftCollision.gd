extends Area2D


func isColliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0 
	
func getPushed():
	var areas = get_overlapping_areas()
	var pushV = Vector2.ZERO
	if isColliding():
		var area = areas[0]
		pushV = area.global_position.direction_to(global_position)
		pushV = pushV.normalized()
	return pushV
