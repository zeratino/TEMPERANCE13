/datum/status_effect/debuff
	status_type = STATUS_EFFECT_REFRESH

///////////////////////////

/datum/status_effect/debuff/hungryt1
	id = "hungryt1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hungryt1
	effectedstats = list(STATKEY_CON = -1)
	duration = -1
	status_type = STATUS_EFFECT_REFRESH

/atom/movable/screen/alert/status_effect/debuff/hungryt1
	name = "Hungry"
	desc = "My stomach growls and my body yearns for food."
	icon_state = "hunger1"

/datum/status_effect/debuff/hungryt2
	id = "hungryt2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hungryt2
	effectedstats = list(STATKEY_STR = -2, STATKEY_CON = -2, STATKEY_END = -1)
	duration = -1
	status_type = STATUS_EFFECT_REFRESH

/atom/movable/screen/alert/status_effect/debuff/hungryt2
	name = "Hungry"
	desc = "Hunger gnaws at my strength. I should eat soon."
	icon_state = "hunger2"

/datum/status_effect/debuff/hungryt3
	id = "hungryt3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hungryt3
	effectedstats = list(STATKEY_STR = -5, STATKEY_CON = -3, STATKEY_END = -2)
	duration = -1
	status_type = STATUS_EFFECT_REFRESH

/atom/movable/screen/alert/status_effect/debuff/hungryt3
	name = "Hungry"
	desc = "My body is beginning to fail from starvation!"
	icon_state = "hunger3"



/datum/status_effect/debuff/thirstyt1
	id = "thirsty1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/thirstyt1
	effectedstats = list(STATKEY_END = -1)
	duration = -1
	status_type = STATUS_EFFECT_REFRESH

/atom/movable/screen/alert/status_effect/debuff/thirstyt1
	name = "Thirsty"
	desc = "My mouth feels a little dry."
	icon_state = "thirst1"

/datum/status_effect/debuff/thirstyt2
	id = "thirsty2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/thirstyt2
	effectedstats = list(STATKEY_SPD = -1, STATKEY_END = -2)
	duration = -1
	status_type = STATUS_EFFECT_REFRESH

/atom/movable/screen/alert/status_effect/debuff/thirstyt2
	name = "Thirsty"
	desc = "My throat is dry, and it's harder to focus."
	icon_state = "thirst2"

/datum/status_effect/debuff/thirstyt3
	id = "thirsty3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/thirstyt3
	effectedstats = list(STATKEY_STR = -1, STATKEY_SPD = -2, STATKEY_END = -3)
	duration = -1
	status_type = STATUS_EFFECT_REFRESH

/atom/movable/screen/alert/status_effect/debuff/thirstyt3
	name = "Thirsty"
	desc = "I urgently need to drink something! Anything!"
	icon_state = "thirst3"



/datum/status_effect/debuff/vthirstt1
	id = "vthirst1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/vthirstt1
	effectedstats = list(STATKEY_CON = -1)
	duration = -1
	status_type = STATUS_EFFECT_REFRESH

/atom/movable/screen/alert/status_effect/debuff/vthirstt1
	name = "Blood Starved"
	desc = "Food and drink brings no comfort. The thought of consuming blood lingers in my mind."
	icon_state = "vthirst1"

/datum/status_effect/debuff/vthirstt2
	id = "vthirst2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/vthirstt2
	effectedstats = list(STATKEY_CON = -2, STATKEY_LCK = -2)
	duration = -1
	status_type = STATUS_EFFECT_REFRESH

/atom/movable/screen/alert/status_effect/debuff/vthirstt2
	name = "Blood Starved"
	desc = "My fangs ache and I am twitchy. Every heartbeat nearby draws my attention."
	icon_state = "vthirst2"

/datum/status_effect/debuff/vthirstt3
	id = "vthirst3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/vthirstt3
	effectedstats = list(STATKEY_STR = 6, STATKEY_SPD = 6, STATKEY_CON = -4, STATKEY_LCK = -4)
	duration = -1
	tick_interval = 5 SECONDS
	status_type = STATUS_EFFECT_REFRESH

/datum/status_effect/debuff/vthirstt3/tick()
	. = ..()
	to_chat(owner, span_artery(pick(
		"I NEED BLOOD!",
		"I AM WASTING AWAY!",
		"I NEED TO FEED!",
		"MY BLOOD... I NEED BLOOD!",
		"I CAN FEEL SOMEONE TAKING OVER ME!",
		"I AM RUNNING DRY!",
		"I MUST HAVE BLOOD!",
		"THE HUNGER IS BECOMING UNBEARABLE!",
		"I CANNOT ENDURE THIS THIRST!",
		"BLOOD! I NEED BLOOD!",
		"MY BODY IS CRYING OUT FOR BLOOD!",
		"I AM WITHERING!",
		"FILL ME WITH BLOOD!",
		"I CAN ONLY SEE RED!",
		"IT'S THEIR FAULT!",
		"FUCK THEM!",
		"WOBBLEMEATS!!",
		"I HATE YOU!",
		"I'LL HAVE BLOOD ONE WAY OR THE OTHER!",
	)))
	if(prob(50))
		owner.emote("twitch")
	owner.adjustBruteLoss(rand(5,15))

/atom/movable/screen/alert/status_effect/debuff/vthirstt3
	name = "Blood Starved"
	desc = "<font color='#ff0000'><b>I CAN'T TAKE IT ANYMORE!! BLOOD!! WHERE IS BLOOD?! I NEED BLOOD!! I WANT BLOOD!!</b></font>"
	icon_state = "vthirst3"

/////////

//SILVER DAGGER EFFECT

/datum/status_effect/debuff/silver_curse
	id = "silver_curse"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/silver_curse
	effectedstats = list("strength" = -2,"perception" = -2,"intelligence" = -2, "constitution" = -2, "endurance" = -2, "speed" = -2)
	duration = 45 SECONDS

/atom/movable/screen/alert/status_effect/debuff/silver_curse
	name = "Silver Curse"
	desc = "My BANE!"
	icon_state = "hunger3"

/////////

/datum/status_effect/debuff/uncookedfood
	id = "uncookedfood"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/uncookedfood/on_apply()
	if(HAS_TRAIT(owner, TRAIT_YUANITE))
		owner.adjust_vitae(200)
	if(HAS_TRAIT(owner, TRAIT_NASTY_EATER) || HAS_TRAIT(owner, TRAIT_ORGAN_EATER) || HAS_TRAIT(owner, TRAIT_WILD_EATER))
		return ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_nausea(100)
	return ..()

/datum/status_effect/debuff/badmeal
	id = "badmeal"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/badmeal/on_apply()
	owner.add_stress(/datum/stressevent/badmeal)
	return ..()

/datum/status_effect/debuff/burnedfood
	id = "burnedfood"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/burnedfood/on_apply()
	if(HAS_TRAIT(owner, TRAIT_NASTY_EATER))
		return ..()
	owner.add_stress(/datum/stressevent/burntmeal)
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_nausea(100)
	return ..()

/datum/status_effect/debuff/rotfood
	id = "rotfood"
	effectedstats = null
	duration = 1

/datum/status_effect/debuff/rotfood/on_apply()
	if(HAS_TRAIT(owner, TRAIT_YUANITE))
		owner.adjust_vitae(100)
	if(HAS_TRAIT(owner, TRAIT_NASTY_EATER) || HAS_TRAIT(owner, TRAIT_ROT_EATER))
		return ..()
	owner.add_stress(/datum/stressevent/rotfood)
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_nausea(200)
	return ..()

/datum/status_effect/debuff/bleeding
	id = "bleedingt1"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/bleedingt1
	effectedstats = list("speed" = -1)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/bleedingt1
	name = "Dizzy"
	desc = ""
	icon_state = "bleed1"

/datum/status_effect/debuff/bleedingworse
	id = "bleedingt2"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/bleedingt2
	effectedstats = list("strength" = -1, "speed" = -2)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/bleedingt2
	name = "Faint"
	desc = ""
	icon_state = "bleed2"

/datum/status_effect/debuff/bleedingworst
	id = "bleedingt3"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/bleedingt3
	effectedstats = list("strength" = -3, "speed" = -4)
	duration = 100

/atom/movable/screen/alert/status_effect/debuff/bleedingt3
	name = "Drained"
	desc = ""
	icon_state = "bleed3"

/datum/status_effect/debuff/sleepytime
	id = "sleepytime"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/sleepytime

/atom/movable/screen/alert/status_effect/debuff/netted
	name = "Net"
	desc = "A net was thrown on me.. how can I move?"
	icon_state = "muscles"

/datum/status_effect/debuff/netted
	id = "net"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/netted
	effectedstats = list("speed" = -5, "endurance" = -2)
	duration = 3 MINUTES

/datum/status_effect/debuff/netted/on_apply()
		. = ..()
		var/mob/living/carbon/C = owner
		C.add_movespeed_modifier(MOVESPEED_ID_NET_SLOWDOWN, multiplicative_slowdown = 3)

/datum/status_effect/debuff/netted/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.legcuffed = null
		C.update_inv_legcuffed()
		C.remove_movespeed_modifier(MOVESPEED_ID_NET_SLOWDOWN)

/atom/movable/screen/alert/status_effect/debuff/sleepytime
	name = "Tired"
	desc = "I should get some rest."
	icon_state = "sleepy"

/datum/status_effect/debuff/muscle_sore
	id = "muscle_sore"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/muscle_sore
	effectedstats = list("strength" = -1, "endurance" = -1)

/atom/movable/screen/alert/status_effect/debuff/muscle_sore
	name = "Muscle Soreness"
	desc = "My muscles need some sleep to recover."
	icon_state = "muscles"

/datum/status_effect/debuff/devitalised
	id = "devitalised"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/devitalised
	effectedstats = list("strength" = -1, "endurance" = -1, "constitution" = -1, "speed" = -1, "fortune" = -1)	//Slightly punishing.
	duration = 15 MINUTES	//Punishing, same time as revival, but mildly less punishing than revival itself.

/atom/movable/screen/alert/status_effect/debuff/devitalised
	name = "Devitalised"
	desc = "Something has been taken from me, and it will take time to recover."

/datum/status_effect/debuff/vamp_dreams
	id = "sleepytime"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/vamp_dreams

/atom/movable/screen/alert/status_effect/debuff/vamp_dreams
	name = "Insight"
	desc = "With some sleep in a coffin I feel like I could become better."
	icon_state = "sleepy"

/datum/status_effect/debuff/ritualdefiled
	id = "ritualdefiled"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/ritualdefiled
	effectedstats = list("strength" = -2, "perception" = -1, "intelligence" = -1, "endurance" = -2, "constitution" = -2, "speed" = -1, "fortune" = -1)
	duration = 2 HOURS // Punishing AS FUCK, but not as punishing as being dead.

/atom/movable/screen/alert/status_effect/debuff/ritualdefiled
	name = "Tainted Lux"
	desc = "My Lux has been tainted in a vile heretic ritual."

/// SURRENDERING DEBUFFS

/datum/status_effect/debuff/breedable
	id = "breedable"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/breedable
	duration = 30 SECONDS

/datum/status_effect/debuff/breedable/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE, id)

/datum/status_effect/debuff/breedable/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE, id)

/atom/movable/screen/alert/status_effect/debuff/breedable
	name = "Obedient"
	desc = "They won't hurt me too much..."

/datum/status_effect/debuff/submissive
	id = "submissive"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/submissive
	duration = 60 SECONDS

/datum/status_effect/debuff/submissive/on_apply()
	. = ..()
	owner.add_movespeed_modifier("SUBMISSIVE", multiplicative_slowdown = 4)

/datum/status_effect/debuff/submissive/on_remove()
	. = ..()
	owner.remove_movespeed_modifier("SUBMISSIVE")

/atom/movable/screen/alert/status_effect/debuff/submissive
	name = "Conformable"
	desc = "Falling in line is my only choice."

/datum/status_effect/debuff/chilled
	id = "chilled"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/chilled
	effectedstats = list("speed" = -5, "strength" = -2, "endurance" = -2)
	duration = 15 SECONDS

/atom/movable/screen/alert/status_effect/debuff/chilled
	name = "Chilled"
	desc = "I can barely feel my limbs!"
	icon_state = "chilled"


/datum/status_effect/debuff/ritesexpended
	id = "ritesexpended"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/ritesexpended
	duration = 30 MINUTES

/atom/movable/screen/alert/status_effect/debuff/ritesexpended
	name = "Rites Complete"
	desc = "It will take time before I can next perform a rite."
	icon_state = "ritesexpended"

/datum/status_effect/debuff/ritesexpended_heavy
	id = "ritesexpended_heavy"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/ritesexpended_heavy
	duration = 1 HOURS

/atom/movable/screen/alert/status_effect/debuff/ritesexpended_heavy
	name = "Rites Complete"
	desc = "It will take a lot of time before I can perform a next rite. I am drained."
	icon_state = "ritesexpended"

/datum/status_effect/debuff/call_to_arms
	id = "call_to_arms"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/call_to_arms
	effectedstats = list("endurance" = -2, "constitution" = -2)
	duration = 2.5 MINUTES

/atom/movable/screen/alert/status_effect/debuff/call_to_arms
	name = "Ravox's Call to Arms"
	desc = "His voice keeps ringing in your ears, rocking your soul.."
	icon_state = "call_to_arms"

/datum/status_effect/debuff/ravox_burden
	id = "ravox_burden"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/ravox_burden
	effectedstats = list("speed" = -2, "endurance" = -3)
	duration = 12 SECONDS

/atom/movable/screen/alert/status_effect/debuff/ravox_burden
	name = "Ravox's Burden"
	desc = "My arms and legs are restrained by divine chains!\n"
	icon_state = "restrained"

/datum/status_effect/debuff/call_to_slaughter
	id = "call_to_slaughter"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/call_to_slaughter
	effectedstats = list("endurance" = -2, "constitution" = -2)
	duration = 2.5 MINUTES

/atom/movable/screen/alert/status_effect/debuff/call_to_slaughter
	name = "Call to Slaughter"
	desc = "A putrid rotting scent fills your nose as Graggar's call for slaughter rattles you to your core.."
	icon_state = "call_to_slaughter"

//For revive - your body DIDN'T rot, but it did suffer damage. Unlike being rotted, this one is only timed. Not forever.
/datum/status_effect/debuff/revived
	id = "revived"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/revived
	effectedstats = list("strength" = -1, "perception" = -1, "intelligence" = -1, "endurance" = -1, "constitution" = -1, "speed" = -1, "fortune" = -1)
	duration = 15 MINUTES		//Should be long enough to stop someone from running back into battle. Plus, this stacks with body-rot debuff. RIP.

/atom/movable/screen/alert/status_effect/debuff/revived
	name = "Revival Sickness"
	desc = "You felt lyfe itself course through you, restoring your lux and your essance. You.. live - but your body aches. It still needs time to recover.."
	icon_state = "revived"

//For de-rot - your body ROTTED. Harsher penalty for longer, can be fully off-set with a cure-rot potion.
/datum/status_effect/debuff/rotted
	id = "rotted_body"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/rotted
	effectedstats = list("strength" = -2, "perception" = -2, "intelligence" = -2, "endurance" = -2, "constitution" = -2, "speed" = -2, "fortune" = -2)
	duration = 30 MINUTES	//Back to a temporary 30 min duration. It hurts.

/atom/movable/screen/alert/status_effect/debuff/rotted
	name = "Body Rot Paralysis"
	desc = "You came back from death, but everything aches.. you can feel it in your muscles. Even in your nose, you can smell something putrid and foul. You live yet, but at what cost..?"
	icon_state = "rotted_body"

//Replaces the flat-stat change, this should ONLY apply to zombies who have been dead for some time. Makes them easier to kill.
/datum/status_effect/debuff/rotted_zombie
	id = "rotted_zombie"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/rotted_zombie
	effectedstats = list("constitution" = -8)
	//No duration = infinate in time - this is removed on de-rot miricle OR de-rot surgery. Won't be applied unless you've been a zombie for ~20 min.

/atom/movable/screen/alert/status_effect/debuff/rotted_zombie
	name = "Decomposing Corpse"
	desc = "You've been dead for some time.. your body is finally starting to give out on you."
	icon_state = "rotted_body"	//Temp holdover, no idea what I'd do for a new icon for this.

/datum/status_effect/debuff/dazed
	id = "dazed"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/dazed
	effectedstats = list("perception" = -2, "intelligence" = -2)
	duration = 15 SECONDS
	status_type = STATUS_EFFECT_REFRESH

/datum/status_effect/debuff/dazed/shield
	effectedstats = list("perception" = -3, "fortune" = -1)
	duration = 8 SECONDS

/atom/movable/screen/alert/status_effect/debuff/dazed
	name = "Dazed"
	desc = "You've been smacked on the head very hard. Which way is left, again?"
	icon_state = "dazed"

/datum/status_effect/debuff/cold
	id = "Frostveiled"
	alert_type =  /atom/movable/screen/alert/status_effect/debuff/cold
	effectedstats = list("speed" = -2)
	duration = 12 SECONDS

/datum/status_effect/debuff/cold/on_apply()
	. = ..()
	var/mob/living/target = owner
	var/newcolor = rgb(136, 191, 255)
	target.add_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)
	addtimer(CALLBACK(target, TYPE_PROC_REF(/atom, remove_atom_colour), TEMPORARY_COLOUR_PRIORITY, newcolor), 12 SECONDS)

/atom/movable/screen/alert/status_effect/debuff/cold
	name = "Cold"
	desc = "Something has chilled me to the bone! It's hard to move."
	icon_state = "muscles"

/*/atom/movable/screen/alert/status_effect/debuff/dazed/shield
	name = "Dazed by fencer's wrap"
	desc = "That stupid piece of cloth is so distracting! It pisses me off!"
	icon_state = "dazed" */

/datum/status_effect/debuff/staggered
	id = "staggered"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/staggered
	effectedstats = list("perception" = -2, "speed" = -2, "constitution" = -2)
	duration = 10 SECONDS

/atom/movable/screen/alert/status_effect/debuff/staggered
	name = "Staggered"
	desc = "You've been smacked by something big. The force of impact has left you staggered."
	icon_state = "dazed"

/datum/status_effect/debuff/staggered/on_apply()
		. = ..()
		var/mob/living/carbon/C = owner
		C.add_movespeed_modifier(MOVESPEED_ID_DAMAGE_SLOWDOWN, multiplicative_slowdown = 1.5)

/datum/status_effect/debuff/staggered/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_movespeed_modifier(MOVESPEED_ID_DAMAGE_SLOWDOWN)

/datum/status_effect/debuff/excomm
	id = "Excommunicated!"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/excomm
	effectedstats = list("fortune" = -2, "intelligence" = -2, "speed" = -1, "endurance" = -1, "constitution" = -1)
	duration = 999 MINUTES

/atom/movable/screen/alert/status_effect/debuff/excomm
	name = "Excommunicated!"
	desc = "The Ten have forsaken me!"
	icon_state = "muscles"
	color ="#6d1313"

/datum/status_effect/debuff/apostasy
	id = "Apostasy!"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/apostasy
	effectedstats = list("fortune" = -5, "intelligence" = -3, "perception" = -2 , "speed" = -2, "endurance" = -2, "constitution" = -2)
	duration = 999 MINUTES

/atom/movable/screen/alert/status_effect/debuff/apostasy
	name = "Apostasy!"
	desc = "Shame upon the member of clergy!"
	icon_state = "debuff"
	color ="#7a0606"

/datum/status_effect/debuff/hereticsermon
	id = "Heretic on sermon!"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/hereticsermon
	effectedstats = list("intelligence" = -2, "speed" = -2, "fortune" = -2)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/debuff/hereticsermon
	name = "Heretic on sermon!"
	desc = "I was on the sermon. My patron is not proud of me."
	icon_state = "debuff"
	color ="#af9f9f"

/datum/status_effect/debuff/no_coom_cheating //Gets triggered when someone sets their arousal, prevents orgasms from sating vice/giving mood boosts
	id = "nocoomcheating"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/no_coom_cheating
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/debuff/no_coom_cheating
	name = "Arousal Imbalanced"
	desc = "My arousal level changed drastically, any orgasm I have now will not be satisfactory."
	icon_state = "arousalimbalance"

/datum/status_effect/debuff/no_coom_cheating/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_UNSATISFIED, id)

/datum/status_effect/debuff/no_coom_cheating/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_UNSATISFIED, id)

/datum/status_effect/debuff/crit_resistance_cd
	id = "crit_resist_cd"
	duration = CRIT_RESISTANCE_TIMER_CD
	alert_type = /atom/movable/screen/alert/status_effect/debuff/crit_resistance_cd
	var/my_stack = 1 // How many time it was triggered. Default to 1 because this is only created when it triggers

// Helper, call this everytime you try to crit
/datum/status_effect/debuff/crit_resistance_cd/proc/try_crit()
	my_stack++
	if(!owner) // wtf
		return TRUE
	if(owner.stat) // Dead / Unconscious	
		return TRUE
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		if(NOBLOOD in C.dna?.species?.species_traits)
			return (my_stack > CRIT_RESISTANCE_STACKS_OP)
	if(!owner.mind)
		return (my_stack > CRIT_RESISTANCE_STACKS_NPC)
	return (my_stack > CRIT_RESISTANCE_STACKS_PLAYER)

/atom/movable/screen/alert/status_effect/debuff/crit_resistance_cd
	name = "Critical Resistance"
	desc = "My body is temporarily resisting critical wounds."
	icon_state = "debuff"
