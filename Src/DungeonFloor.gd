class_name DungeonFloor

var floor_num = 0
var rooms = Array(Array())
var exit_path = Array()
var visited = Array()

func _init(fnum):
	var depth = 3 + fnum
	floor_num = fnum
	
	for flr in range(depth):
		exit_path.append(randi() % 4)
		rooms.append([])
		visited.append([])
		
		for _rms in range(4):
			rooms[flr].append(randi() % 4)
			visited[flr].append(false)
		
	var next_lvl_exit = exit_path[depth - 1]
	rooms[depth - 1][next_lvl_exit] = 4

func is_visited(flr, room):
	return visited[flr][room] == true

func mark_visited(flr, room):
	visited[flr][room] = true

func is_exit(flr, room):
	return exit_path[flr] == room
	
func is_last_set(flr):
	var depth = 3 + floor_num
	
	return flr == depth - 1
