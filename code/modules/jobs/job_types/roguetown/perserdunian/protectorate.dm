/datum/job/roguetown/protectorate
	title = "Protectorate Guardsman"
	flag = PROTECTORATE
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 12
	spawn_positions = 12
	agevet_req = FALSE
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "CIVIL UNREST HAS ESCALATED INTO A REBELLION. \
				YOU ARE THE FIRST AND FINAL LINE OF DEFENSE AGAINST THE HEATHENOUS REBELS OF VOS ARDERLA. \
				YOU HAVE BEEN PROVIDED WITH A RIOT MACE AND FIREARMS. \
				YOU HAVE BEEN PROVIDED WITH THE FINEST MACHINE-MADE COMPOSITE ARMOR. \
				YOU ARE HAND-PICKED FROM THE IMPERIAL FORCES, TAILORED FOR VIOLENT DE-ESCALATION. \
				YOU ARE AUTHORIZED TO KILL."

	outfit = /datum/outfit/job/roguetown/protectorate
	display_order = JDO_PROTECTORATE
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_protectorate.ogg'

/datum/job/roguetown/protectorate/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
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

/datum/outfit/job/roguetown/protectorate/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/freifechter
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/riot
	pants = /obj/item/clothing/under/roguetown/tights/riot
	head = /obj/item/clothing/head/roguetown/helmet/riot
	mask = /obj/item/clothing/mask/rogue/gasmask/protectorate
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/rogueweapon/mace/cudgel/protectorate
	backl = /obj/item/rogueweapon/shield/tower/metal/ballistic
	wrists = /obj/item/scomstone/garrison
	gloves = /obj/item/clothing/gloves/roguetown/angle
	backr = /obj/item/storage/backpack/rogue/backpack/perserdun
	id = /obj/item/roguekey/perserdun
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/poor,
		/obj/item/grenade/gas/poison = 3,
		/obj/item/grenade/gas/smoke = 3,
		/obj/item/ammo_box/handfuls/judge = 3,
		/obj/item/gun/ballistic/revolver/judge,
		/obj/item/rope/chain,
		/obj/item/storage/belt/rogue/pouch/ammobag/judge,
		/obj/item/needle,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/revolvers, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/rifles, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.change_stat("strength", 2)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 3)
	H.change_stat("perception", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
