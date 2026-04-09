/datum/job/roguetown/armilteknikisto
	title = "Armilteknikisto"
	flag = ARMILTEKNIKISTO
	department_flag = RISVON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You are a soldato, promoted to the special position of Heavy Weapons Technician. \
				You are part of a team. Work with your Municioteknikisto to achieve complete efficiency with your gun. \
				Your main purpose is follow the orders of your superiors. They are your Oficiros, and your Commandant. \
				For most of your life, you've been filled with a firm belief that the strong must rule. \
				You are also a firm believer of the denial of one's desires, in favor for unity and a greater good." 

	outfit = /datum/outfit/job/roguetown/armilteknikisto
	display_order = JDO_ARMILTEKNIKISTO
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_soldato.ogg'

/datum/job/roguetown/armilteknikisto/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
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



/datum/outfit/job/roguetown/armilteknikisto/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron/ziggurate
	cloak = /obj/item/clothing/cloak/templar/malumite
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	head = /obj/item/clothing/head/roguetown/helmet/kettle/iron
	mask = /obj/item/clothing/mask/rogue/gasmask/risvonmask
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/gun/ballistic/rifle/repeater/offiseroluger
	wrists = /obj/item/scomstone
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	id = /obj/item/roguekey/risvon
	backr = /obj/item/storage/backpack/rogue/backpack/risvon
	backl = /obj/item/mg_disassembled/mark1
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/poor,
		/obj/item/smokegrenade = 1,
		/obj/item/mg_tripod/mark1,
		/obj/item/ammo_box/magazine/hmg/a303,
		/obj/item/ammo_box/magazine/luger = 3,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/pistols, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 3)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
