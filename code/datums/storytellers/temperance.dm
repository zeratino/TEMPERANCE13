///Snowflake Storytellers
#define TEMPERANCE_STORYTELLERS list( \
	/datum/storyteller/standard, \
	/datum/storyteller/evil, \
	)

/datum/storyteller/standard
	name = "STANDARD"
	desc = "You have been given the right to vote for.. NOTHING! The standard Temperance 13 experience."
	weight = 6
	always_votable = TRUE
	color_theme = "#80ced8"

	//Sets probability of roundstart antag to 0. One would think no character injection would be good enough, but here we are. This is also on other codebases psydon so prob the way to fix it.
	guarantees_roundstart_roleset = FALSE
	roundstart_prob = 0 //Sets probability of roundstart antag to 0. One would think no character injection would be good enough, but here we are. This is also on other codebases psydon so prob the way to fix it.

	//Has no influence, your actions will not impactspawn rates.
	//Tl;dr - higher event spawn rates to keep stuff interesting, no god intervention, no antags. (Raids and omens will still happen at normal rate.)
	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1.2,
		EVENT_TRACK_MODERATE = 1.2,
		EVENT_TRACK_INTERVENTION = 0,			//No god intervention, cus he's asleep.
		EVENT_TRACK_CHARACTER_INJECTION = 0,	//No antagonist spawns.
	)

/datum/storyteller/evil
	name = "DANGER"
	desc = "You have been given the right to vote for.. WAR! Foreign Powers are at play, and the reaper sharpens his scythe in waiting."
	weight = 6
	always_votable = FALSE
	color_theme = "#CC4444"

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_PERSONAL = 1.2,
		EVENT_TRACK_MODERATE = 1.1,
		EVENT_TRACK_INTERVENTION = 0, //I'm assuming we don't want divine intervention in our grimshittening.
		EVENT_TRACK_CHARACTER_INJECTION = 1,	//Guarenteed antagonist spawn
		EVENT_TRACK_OMENS = 1.3,
		EVENT_TRACK_RAIDS = 0.8,
	)

	cost_variance = 50  // Events will be highly variable in cost