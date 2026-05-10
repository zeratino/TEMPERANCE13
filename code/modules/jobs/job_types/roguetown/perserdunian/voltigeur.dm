/datum/job/roguetown/voltigeur
	title = "Voltigeur"
	flag = VOLTIGEUR
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You are an Armsman, given the honor of being a Voltigeur. You are expected to serve as a specialist. \
				Having done intense physical training in the mountains of Osk Averwael, you've passed the rigorous selection to get this position.\
				While Voltigeurs were always above traditional Armsman, the guns are fairly new; replacing crossbows with weapons from the WAR MACHINE. \
				Be careful not to get caught on your own. Use your grenade launcher to help your allies move around safely. \
				Voltigeurs have a reputation as the best of Armsman; try to live up to that standard, and take pride in your role." 

	outfit = /datum/outfit/job/roguetown/voltigeur
	display_order = JDO_VOLTIGEUR
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_voltigeur.ogg'

/datum/job/roguetown/voltigeur/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
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

/datum/outfit/job/roguetown/voltigeur/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine
	cloak = /obj/item/clothing/cloak/perserduntrenchcoat/voltigeur
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	head = /obj/item/clothing/head/roguetown/helmet/sallet/visored/gilded
	mask = /obj/item/clothing/mask/rogue/gasmask/perserdunmask/cloth
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/belt/rogue/pouch/ammobag/shotgun
	backl = /obj/item/gun/ballistic/shotgun/levershotgun
	wrists = /obj/item/scomstone/garrison
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	backr = /obj/item/storage/backpack/rogue/backpack/perserdun
	id = /obj/item/roguekey/perserdun
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/mid,
		/obj/item/grenade/gas/poison,
		/obj/item/rogueweapon/sword/iron/short,
		/obj/item/gun/ballistic/revolver/flaregun,
		/obj/item/storage/belt/rogue/pouch/ammobag/flare,
		/obj/item/ammo_box/handfuls/a40mm/smoke,
		/obj/item/ammo_box/handfuls/a40mm/smoke,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/rifles, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shotguns, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
	H.change_stat("strength", 1)
	H.change_stat("constitution", 1)
	H.change_stat("intelligence", 0)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 3)
	H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SLEUTH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
