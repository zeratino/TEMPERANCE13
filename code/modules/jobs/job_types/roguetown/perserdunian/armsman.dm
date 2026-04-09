/datum/job/roguetown/armsman
	title = "Armsman"
	flag = ARMSMAN
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 8
	spawn_positions = 8
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You are the rank and file soldier of the Great Empire of Perserdun. \
				Your main purpose is to bundle together with other Armsmen and to kill the enemies of the Empire. \
				Typically, Armsmen are filled with a great love for their nation and volunteer. Others are conscripted, or are convicts." 

	outfit = /datum/outfit/job/roguetown/armsman
	display_order = JDO_ARMSMAN
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_armsman.ogg'

/datum/job/roguetown/armsman/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/perserdun))
			var/obj/item/clothing/S = H.wear_ring
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = " [index]'s dogtag"

/datum/outfit/job/roguetown/armsman/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
	cloak = /obj/item/clothing/cloak/perserduntrenchcoat
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	head = /obj/item/clothing/head/roguetown/helmet/sallet/visored/iron
	mask = /obj/item/clothing/mask/rogue/gasmask/perserdunmask
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/belt/rogue/pouch/ammobag/rifle
	backl = /obj/item/gun/ballistic/rifle/repeater/perserdun
	wrists = /obj/item/scomstone/garrison
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	backr = /obj/item/storage/backpack/rogue/backpack/perserdun
	id = /obj/item/roguekey/perserdun
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/poor,
		/obj/item/gasgrenade,
		/obj/item/smokegrenade,
		/obj/item/rogueweapon/sword/iron/short,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/rifles, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.change_stat("strength", 1)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
