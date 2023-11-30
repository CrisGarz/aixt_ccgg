@[task] fn move_square() {
    for {
        acquire(move_mutex)
        forward(out_ac, 75)
		sleep(1000)
        reverse(out_c, 75)
		sleep(500)
        release(move_mutex)
    }
}

@[task] fn check_sensors() {
    for {
        if sensor_1 == 1 {
            acquire(move_mutex)
            reverse(out_ac, 75)
			sleep(500)
            forward(out_a, 75)
			sleep(500)
            release(move_mutex)
        }
    }
}

@[task] fn main() {
	move_mutex := mutex('') //initialization value is necesary but will be ingnored 

	precedes(move_square, check_sensors)
	set_sensor_touch(in_1)
}