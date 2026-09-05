/datum/job/roguetown/consulo
	title = "Consulo"
	flag = CONSULO
	department_flag = RISVON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_TEMPERANCE_NONCOMBATANT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You're a diplomat to the local Caprito. \
				Decked out in expensive, fancy clothing - you typically spend most of your time drafting up letters, while trying to convince the local populace to let your Great Dictate take over. \
				Rank-wise, you're just below the Commandant, but hold zero authority during combat.\
				You also oversee the local camp, and ensure things are running relatively smoothly." 

	outfit = /datum/outfit/job/roguetown/consulo
	display_order = JDO_CURACISTO
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_backliner.ogg'

/datum/job/roguetown/consulo/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/risvon))
			var/obj/item/roguekey/risvon/S = H.wear_ring
			S.set_soldier_name(H)

/datum/outfit/job/roguetown/consulo/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	armor = /obj/item/clothing/suit/roguetown/armor/leather/consulo2
	cloak = /obj/item/clothing/cloak/templar/malumite
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	wrists = /obj/item/scomstone
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	id = /obj/item/roguekey/risvon
	backr = /obj/item/storage/backpack/rogue/satchel/risvon
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/pistols, 1, TRUE)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 2)
	H.change_stat("perception", 2)
	H.change_stat("intelligence", 2)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
