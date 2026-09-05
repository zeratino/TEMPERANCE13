/datum/job/roguetown/mulo
	title = "Mulo"
	flag = MULO
	department_flag = RISVON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You are a soldato, promoted to the special postition of Municioteknikisto- often called Mulo. \
				Your main purpose is follow the orders of the Pafanto. Coordinate to achieve peak heavy weapons efficiency. \
				For most of your life, you've been filled with a firm belief that the strong must rule. \
				You are also a firm believer of the denial of one's desires, in favor for unity and a greater good." 

	outfit = /datum/outfit/job/roguetown/mulo
	display_order = JDO_MULO
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_soldato.ogg'

/datum/job/roguetown/mulo/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/risvon))
			var/obj/item/roguekey/risvon/S = H.wear_ring
			S.set_soldier_name(H)



/datum/outfit/job/roguetown/mulo/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron/ziggurate
	cloak = /obj/item/clothing/cloak/templar/malumite
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	head = /obj/item/clothing/head/roguetown/helmet/kettle/iron/soldato
	mask = /obj/item/clothing/mask/rogue/gasmask/risvonmask
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/belt/rogue/pouch/ammobag/pistol
	wrists = /obj/item/scomstone
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	id = /obj/item/roguekey/risvon
	backr = /obj/item/storage/backpack/rogue/satchel/risvon
	backl = /obj/item/storage/backpack/rogue/satchel/chestrig
	r_hand = /obj/item/gun/ballistic/rifle/repeater/offiseroluger
	backpack_contents = list(
		/obj/item/ammo_box/magazine/hmg/a303 = 9,
		/obj/item/ammo_box/magazine/luger = 6,
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
	H.adjust_skillrank(/datum/skill/combat/pistols, 4, TRUE) // this is literally just flavor to be completely honest with you, it does fucking nothing
	H.adjust_skillrank(/datum/skill/combat/rifles, 4, TRUE) // this is so they can actually aim with the carbine if they want because it is technically a rifle
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
