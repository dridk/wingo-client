.pragma library

var Screen = {
	"width": 	540,
	"height": 	960
}

var BASE_UNIT = 8

var Grid = {
	"Row": {
		"length": 16,
		"HEIGHT": 8 * BASE_UNIT,
		"PT": function(n) { return this.HEIGHT * n; }
	},
	"Column": {
		"length": 8,
		"WIDTH": 8 * BASE_UNIT,
		"PT": function(n) { return this.WIDTH * n; }
	}
}

var Elements = {
	"Actionbar":{
		"HEIGHT": Grid.Row.PT(1.5),
		"Padding": {
			"TOP":		3 * BASE_UNIT,
			"RIGHT":	2 * BASE_UNIT,
			"BOTTOM":	3 * BASE_UNIT,
			"LEFT":		0
		},
		"Button": {
			"WIDTH": 	12 * BASE_UNIT,
			"HEIGHT": 	12 * BASE_UNIT
		},
		"Icon": {
			"WIDTH": 	6 * BASE_UNIT,
			"HEIGHT": 	6 * BASE_UNIT
		}
	}
}

var Text = {
	"DEFAULT": 	2 * BASE_UNIT,
	"SMALL": 	1.4 * BASE_UNIT,
	"MINI": 	1.2 * BASE_UNIT,
	"LARGE": 	2.2 * BASE_UNIT,
	"HUGE": 	2.4 * BASE_UNIT
}