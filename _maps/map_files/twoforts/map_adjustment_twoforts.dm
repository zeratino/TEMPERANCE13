/*
			< ATTENTION >
	If you need to add more map_adjustment, check 'map_adjustment_include.dm'
	These 'map_adjustment.dm' files shouldn't be included in 'dme'
*/

/datum/map_adjustment/twoforts
	map_file_name = "twoforts.dmm"
	realm_name = "Two Forts"
	slot_adjust = list(
		/datum/job/roguetown/soldato = 20,
		/datum/job/roguetown/armsman = 20
	)
	title_adjust = list(
		/datum/job/roguetown/soldato = list(display_title = "RED Soldier"),
		/datum/job/roguetown/armsman = list(display_title = "BLU Soldier"),
		/datum/job/roguetown/kaspafisto = list(display_title = "RED Sniper"),
		/datum/job/roguetown/blackguard = list(display_title = "BLU Spy")
	)
	tutorial_adjust = list(
		/datum/job/roguetown/soldato = "BLU Team has acted against you ONCE AGAIN!!! The baby eating monsters they hire are ontollogically evil. Feel no guilt when you extinguish their light...",
		/datum/job/roguetown/armsman = "RED Team has acted against you ONCE AGAIN!!! The baby eating monsters they hire are ontollogically evil. Feel no guilt when you extinguish their light...",
		/datum/job/roguetown/kaspafisto = "Professionals have standards. Be polite. Be efficient. Have a plan to kill everyone you meet.",
		/datum/job/roguetown/blackguard = "You've breached their defenses before... You've killed their colleagues before... you'll do it again."
	)
	blacklist = list(
		/datum/job/roguetown/adventurer,
		/datum/job/roguetown/pilgrim,
		/datum/job/roguetown/hierarch,
		/datum/job/roguetown/merchant,
		/datum/job/roguetown/bulwark,
		/datum/job/roguetown/barkeep
	)