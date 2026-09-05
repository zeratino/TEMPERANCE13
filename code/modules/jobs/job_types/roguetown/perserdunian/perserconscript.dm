/datum/job/roguetown/perserconscript
	title = "Perserdunian Conscript"
	flag = PERSERDUN_CONSCRIPT
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "I'M TESTING IT!! I'M TESTING IT SO HARD!!!." 

	outfit = /datum/outfit/job/roguetown/perserconscript
	display_order = JDO_PERSERDUN_CONSCRIPT
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_armsman.ogg'

/datum/job/roguetown/perserconscript/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/perserdun))
			var/obj/item/roguekey/perserdun/S = H.wear_ring
			S.set_soldier_name(H)

/datum/outfit/job/roguetown/perserconscript/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron
	cloak = /obj/item/clothing/cloak/perserduntrenchcoat
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	head = /obj/item/clothing/head/roguetown/helmet/sallet/visored/iron
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
		/obj/item/grenade/gas/smoke,
		/obj/item/rogueweapon/sword/iron/short,
		/obj/item/rope,
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
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.change_stat("strength", 1)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
