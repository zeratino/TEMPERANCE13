/datum/job/roguetown/oficiro
	title = "Oficiro"
	flag = OFICIRO
	department_flag = RISVON
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You're a Risvonian military officer. \
				You enforce the will of the Commandant. \
				You are aware of your nation's ideology as a tool to manipulate lesser-minded people. \
				You also realize that it has its benefits, sometimes. Oficiros are generally selected through trial by combat." 

	outfit = /datum/outfit/job/roguetown/oficiro
	display_order = JDO_OFICIRO
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_oficiro.ogg'

/datum/job/roguetown/oficiro/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
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

/datum/outfit/job/roguetown/oficiro/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron/ziggurate/pauldrons
	cloak = /obj/item/clothing/cloak/templar/malumite
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	head = /obj/item/clothing/head/roguetown/helmet/kettle/iron/oficiro
	mask = /obj/item/clothing/mask/rogue/gasmask/risvonmask
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/gun/ballistic/rifle/repeater/offiseroluger
	beltr = /obj/item/storage/belt/rogue/pouch/ammobag
	wrists = /obj/item/scomstone
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	id = /obj/item/roguekey/risvon
	backl = /obj/item/gun/ballistic/rifle/repeater/rattlesnake
	backr = /obj/item/storage/backpack/rogue/backpack/risvon
	backpack_contents = list(
		/obj/item/ammo_box/handfuls/rattlesnake = 4,
		/obj/item/storage/belt/rogue/pouch/coins/mid,
		/obj/item/smokegrenade = 2,
		/obj/item/ammo_box/magazine/luger = 3,
		/obj/item/grenade,
		/obj/item/rogueweapon/stoneaxe/woodcut/risvon,
		/obj/item/flashlight/flare/torch/lantern,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/rifles, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/pistols, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
