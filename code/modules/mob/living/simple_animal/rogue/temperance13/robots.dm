/mob/living/simple_animal/hostile/rogue/robot
	name = "STRANGER"
	desc = ""
	icon = 'icons/roguetown/mob/robots/mech_infantry.dmi'
	icon_state = "EB-scout"
	icon_living = "EB-scout_MG"
	icon_dead = "EB-scout_dead"
	gender = NEUTER
	speech_span = SPAN_ROBOT
	mob_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	robust_searching = 1
	turns_per_move = 1
	move_to_delay = 3
	STACON = 12
	STASTR = 10
	STASPD = 7
	STAEND = 12
	maxHealth = STRANGER_HEALTH
	health = STRANGER_HEALTH
	harm_intent_damage = 10
	melee_damage_lower = 10
	melee_damage_upper = 25
	vision_range = 7
	aggro_vision_range = 9
	retreat_distance = 0
	minimum_distance = 0
	limb_destroyer = 1
	base_intents = list(/datum/intent/hit)
	attack_verb_continuous = "bashes"
	attack_verb_simple = "bash"
	attack_sound = 'sound/blank.ogg'
	canparry = TRUE
	d_intent = INTENT_PARRY
	defprob = 50
	speak_emote = list("computes")
	loot = list(/obj/item/natural/bone,	/obj/item/natural/bone, /obj/item/natural/bone,	/obj/item/skull)
	faction = list("undead")
	footstep_type = FOOTSTEP_MOB_HEAVY
	del_on_death = FALSE
	pixel_x = -16

	can_have_ai = FALSE
	AIStatus = AI_OFF
	ai_controller = /datum/ai_controller/deepone
	melee_cooldown = STRANGER_ATTACK_SPEED

/mob/living/simple_animal/hostile/rogue/robot/gunner
	name = "STRANGER"
	desc = "A lithe, springy thing. It has a gun attached to the side."
	icon = 'icons/roguetown/mob/robots/mech_infantry.dmi'
	icon_state = "EB-scout"
	icon_living = "EB-scout_MG"
	icon_dead = "EB-scout_dead"
	projectiletype = /obj/projectile/bullet/a9mm
	projectilesound = 'sound/combat/Ranged/pistol1.ogg'
	ranged = 1
	retreat_distance = 2
	minimum_distance = 5
	ranged_cooldown_time = 60
	check_friendly_fire = 1
	loot = list(
			/obj/item/ammo_box/clip/pistol,
			/obj/item/ammo_box/clip/pistol,
			/obj/item/ammo_box/clip/pistol,
			)
	ai_controller = /datum/ai_controller/stranger

/mob/living/simple_animal/hostile/rogue/robot/gunner/rifle
	name = "STRANGER"
	desc = "A hulking, mechanical thing. It doesn't like the look on your mug."
	icon = 'icons/roguetown/mob/robots/mech_infantry.dmi'
	icon_state = "gunnerknight"
	icon_living = "gunnerknight"
	icon_dead = "gunnerknight_dead"
	projectiletype = /obj/projectile/bullet/a762
	projectilesound = 'sound/combat/Ranged/la_fire.ogg'
	ranged = 1
	retreat_distance = 2
	minimum_distance = 5
	ranged_cooldown_time = 40
	check_friendly_fire = 1
	loot = list(
			/obj/item/ammo_box/handfuls/rifle,
			/obj/item/ammo_box/handfuls/rifle,
			/obj/item/ammo_box/handfuls/rifle,
			)
	ai_controller = /datum/ai_controller/stranger

/mob/living/simple_animal/hostile/rogue/robot/gunner/shotgun
	name = "IMITATION"
	desc = "A hulking, mechanical beast. It doesn't seem too happy to see you."
	icon = 'icons/roguetown/mob/robots/mech_infantry.dmi'
	icon_state = "shotgunknight"
	icon_living = "shotgunknight"
	icon_dead = "shotgunknight_dead"
	projectiletype = /obj/projectile/bullet/shotgun_slug
	projectilesound = 'sound/combat/Ranged/shotgun2.ogg'
	ranged = 1
	retreat_distance = 2
	minimum_distance = 5
	ranged_cooldown_time = 40
	check_friendly_fire = 1
	loot = list(
			/obj/item/ammo_box/handfuls/shotgun,
			/obj/item/ammo_box/handfuls/shotgun,
			/obj/item/ammo_box/handfuls/shotgun/buckshot,
			)
	ai_controller = /datum/ai_controller/stranger

/mob/living/simple_animal/hostile/rogue/robot/gunner/boss
	name = "BEAST"
	desc = "The metaphorical father of most STRANGERS. This one has two machine guns."
	icon = 'icons/roguetown/mob/robots/mech_infantry.dmi'
	icon_state = "beast"
	icon_living = "beast"
	icon_dead = "beast_dead"
	projectiletype = /obj/projectile/bullet/a762
	harm_intent_damage = 65
	melee_damage_lower = 65
	melee_damage_upper = 75 //ow
	projectilesound = 'sound/combat/Ranged/hmg_fire.ogg'
	extra_projectiles = 3
	ranged = 1
	retreat_distance = 2
	minimum_distance = 5
	ranged_cooldown_time = 40
	check_friendly_fire = 1
	loot = list(
			/obj/item/ammo_box/handfuls/rifle,
			/obj/item/ammo_box/handfuls/rifle,
			/obj/item/ammo_box/handfuls/rifle,
			/obj/item/ammo_box/handfuls/rifle,
			/obj/item/ammo_box/handfuls/rifle,
			/obj/item/ammo_box/handfuls/rifle,
			/obj/item/ammo_box/handfuls/rifle,
			/obj/item/ammo_box/handfuls/rifle,
			/obj/item/ammo_box/handfuls/rifle,
			)
	ai_controller = /datum/ai_controller/stranger
	maxHealth = 1300
	health = 1300


/mob/living/simple_animal/hostile/rogue/robot/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/robots/robot_aggro1.ogg','sound/vo/mobs/robots/robot_aggro2.ogg','sound/vo/mobs/robots/robot_aggro3.ogg',)
		if("pain")
			return pick('sound/vo/mobs/robots/robopain1.ogg', 'sound/vo/mobs/robots/robopain2.ogg','sound/vo/mobs/robots/robopain3.ogg')
		if("death")
			return pick('sound/vo/mobs/robots/death1.ogg','sound/vo/mobs/robots/death2.ogg')
		if("idle")
			return pick('sound/vo/mobs/robots/idle1.ogg','sound/vo/mobs/robots/idle2.ogg','sound/vo/mobs/robots/idle3.ogg','sound/vo/mobs/robots/idle4.ogg')

