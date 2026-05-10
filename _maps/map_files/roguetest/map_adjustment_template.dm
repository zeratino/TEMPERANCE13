/*
			< ATTENTION >
	If you need to add more map_adjustment, check 'map_adjustment_include.dm'
	These 'map_adjustment.dm' files shouldn't be included in 'dme'
*/

/datum/map_adjustment/template
	map_file_name = "roguetest.dmm"
	realm_name = "Roguetest"
	slot_adjust = list(
		/datum/job/roguetown/soldato = 42,
		/datum/job/roguetown/adventurer = 69
	)
	title_adjust = list(
		/datum/job/roguetown/soldato = list(display_title = "Crungler", f_title = "Boingler")
	)
	tutorial_adjust = list(
		/datum/job/roguetown/soldato = "It's so fucking over dude you have no idea"
	)