/datum/job/roguetown/tuoro
	title = "Bastiono"
	flag = TUORO
	department_flag = RISVON
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You're a Risvonian Shield Bearer. \
				You're supposed to follow the orders of the Oficiro and Commandant, while working with your squadron and providing support where needed. \
				You are meant to stay close to your team, raise your shield and keep them covered. Do not stray from them, this defeats the purpose.\
				Tuoros are typically picked from Soldati, promoted via their will to fight and their builds, chosen as the most enduring of the pack. Keep your squadron covered." 

	outfit = /datum/outfit/job/roguetown/tuoro
	display_order = JDO_TUORO
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_tuoro.ogg'

/datum/job/roguetown/tuoro/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/risvon))
			var/obj/item/clothing/S = H.wear_ring
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = " [index]'s nailtag"

/datum/outfit/job/roguetown/tuoro/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/armor/ebboots/armored
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron/ziggurate
	cloak = /obj/item/clothing/cloak/templar/malumite
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	head = /obj/item/clothing/head/roguetown/helmet/kettle/iron/visored
	mask = /obj/item/clothing/mask/rogue/gasmask/risvonmask
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/bomb/dynamite
	wrists = /obj/item/scomstone
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	backl = /obj/item/rogueweapon/stoneaxe/woodcut/risvon
	backr = /obj/item/storage/backpack/rogue/backpack/risvon
	id = /obj/item/roguekey/risvon
	r_hand = /obj/item/rogueweapon/shield/tower/metal
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	var/subrole = list("BASTIONE (RANGED)", "INSANGUINATO (MELEE)")
	var/subrole_choice = input(H, "Who are you?", "DECIDE ON YOUR SPECIALTY.") as anything in subrole
	switch(subrole_choice)
		if	("BASTIONE (RANGED)")
			H.adjust_skillrank(/datum/skill/combat/pistols, 4, TRUE)
			backpack_contents = list(
				/obj/item/storage/belt/rogue/pouch/coins/mid,
				/obj/item/grenade/gas/smoke,
				/obj/item/bomb/dynamite,
				/obj/item/rogueweapon/stoneaxe/woodcut/risvon,
				/obj/item/gun/ballistic/rifle/repeater/jackal,
				/obj/item/ammo_box/magazine/jackal = 3,)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		if	("INSANGUINATO (MELEE)")
			H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
			backpack_contents = list(
				/obj/item/storage/belt/rogue/pouch/coins/mid,
				/obj/item/grenade/gas/smoke,
				/obj/item/bomb/dynamite,)
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	H.change_stat("strength", 2)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 2)
	H.change_stat("perception", 1)
	H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC) //We have to see how this plays out for the Bastiono's
