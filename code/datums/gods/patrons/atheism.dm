/datum/patron/godless
	name = null
	associated_faith = /datum/faith/godless

/datum/patron/godless/faithless
	name = "NONE"
	domain = "You do not follow a god."
	desc = "Other faiths may exist, but they're largely shadowed by the ever-encroaching arms race."
	worshippers = "Virtually everyone."
	associated_faith = /datum/faith/godless
	preference_accessible = TRUE
	undead_hater = FALSE
	confess_lines = list(
		"Gods are WORTHLESS!",
		"I DON'T NEED GODS!",
		"I AM MY OWN GOD!",
		"NO GODS, NO MASTERS!",
	)

/datum/patron/godless/can_pray(mob/living/follower)
	to_chat(follower, span_danger("You cannot pray, if you don't believe in anything."))
	return FALSE	//heathen

/datum/patron/godless/perserdun
	name = "Venerable-Master Rab"
	domain = "The Great Perserdunian Empire."
	desc = "The God-King 'Rab' is the only human who has both a divine and mortal nature. Even to nonbelievers, he is known for being the only monarch who has reigned for over two hundred years. Followers tend to practice conformity and adherence to strict societal norms."
	worshippers = "Perserdunian Troopers."
	associated_faith = /datum/faith/godless
	preference_accessible = TRUE
	undead_hater = FALSE
	confess_lines = list(
		"Gods are WORTHLESS!",
		"I DON'T NEED GODS!",
		"I AM MY OWN GOD!",
		"NO GODS, NO MASTERS!",
	)

/datum/patron/godless/can_pray(mob/living/follower)
	to_chat(follower, span_danger("Your actions are your prayer, idiot."))
	return FALSE	//heathen
