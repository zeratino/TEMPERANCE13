/datum/job/roguetown/sterilizer
	title = "Protectorate Sterilizer"
	flag = STERILIZER
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	agevet_req = FALSE
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "CIVIL UNREST HAS ESCALATED INTO A REBELLION. \
				YOU ARE AN ATTACHED SPECIALIST WITHIN THE PROTECTORATE GUARDSMEN. \
				YOU SPECIALIZE IN CONTAINMENT AND STERILIZATION - PRIMARILY THROUGH POISON AND GAS. \
				YOU HAVE BEEN PROVIDED WITH THE BEST ABILITIES THE LOGISTICIAN MAGES COULD OFFER. \
				YOU ARE HAND-PICKED FROM GUARDSMEN WHO EXCEL IN SHOWING LITTLE EMPATHY FOR OTHERS. \
				YOU ARE AUTHORIZED TO CLEANSE."

	outfit = /datum/outfit/job/roguetown/sterilizer
	display_order = JDO_STERILIZER
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_sterilizer.ogg'

/datum/job/roguetown/sterilizer/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
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

/datum/outfit/job/roguetown/sterilizer/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/freifechter
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full/riot
	pants = /obj/item/clothing/under/roguetown/tights/riot
	head = /obj/item/clothing/head/roguetown/helmet/riot
	mask = /obj/item/clothing/mask/rogue/gasmask/sterilizer
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/rogueweapon/mace/cudgel/protectorate
	backl = /obj/item/gun/ballistic/revolver/purifier
	wrists = /obj/item/scomstone/garrison
	gloves = /obj/item/clothing/gloves/roguetown/leather/latex
	backr = /obj/item/storage/backpack/rogue/backpack/perserdun
	id = /obj/item/roguekey/perserdun
	backpack_contents = list(
		/obj/item/ammo_box/handfuls/a40mm/gas = 6,
		/obj/item/grenade/gas/poison = 6,
		/obj/item/ammo_box/handfuls/a40mm/he = 3,
		/obj/item/ammo_box/handfuls/a40mm/frag = 2,
		/obj/item/ammo_box/handfuls/a40mm/smoke = 6,
		/obj/item/storage/belt/rogue/pouch/ammobag/gas,
		/obj/item/needle,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/revolvers, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/rifles, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 5, TRUE)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/acidsplash)
	H.change_stat("intelligence", 2)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 3)
	H.change_stat("perception", 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
