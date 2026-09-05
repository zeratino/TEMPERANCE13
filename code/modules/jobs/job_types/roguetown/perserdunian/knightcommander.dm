/datum/job/roguetown/knightcommander
	title = "Knight Commander"
	flag = KNIGHTCOMMANDER
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You're a low-ranking officer, gifted with your own squad of Armsmen. \
				Your main goal is to keep your Armsmen together and alive, while also killing the enemy. \
				Typically, Commanders are promoted after they graduate a certain type of training. Some are promoted Armsmen."

	outfit = /datum/outfit/job/roguetown/knightcommander
	display_order = JDO_KNIGHTCOMMANDER
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_knightcommander.ogg'

/datum/job/roguetown/knightcommander/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/perserdun))
			var/obj/item/roguekey/perserdun/S = H.wear_ring
			S.set_soldier_name(H)

/datum/outfit/job/roguetown/knightcommander/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	beltl = /obj/item/flashlight/flare/torch/lantern
	armor = /obj/item/clothing/suit/roguetown/armor/plate/hauberk
	cloak = /obj/item/clothing/cloak/perserduntabard
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	head = /obj/item/clothing/head/roguetown/helmet/heavy/barbute/visor
	mask = /obj/item/clothing/mask/rogue/gasmask/perserdunmask
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/belt/rogue/pouch/ammobag
	backl = /obj/item/gun/ballistic/rifle/repeater/rattlesnake
	wrists = /obj/item/scomstone/garrison
	id = /obj/item/roguekey/perserdun
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	backr = /obj/item/storage/backpack/rogue/backpack/perserdun
	backpack_contents = list(
		/obj/item/ammo_box/handfuls/rattlesnake = 6,
		/obj/item/storage/belt/rogue/pouch/coins/mid,
		/obj/item/grenade/gas/poison,
		/obj/item/grenade/gas/smoke,
		/obj/item/rogueweapon/sword/short/messer/knightcommander,
		/obj/item/bomb/dynamite = 2,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/rifles, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/holdingweak)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/aimweak)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/chargeweak)
	H.change_stat("strength", 1)
	H.change_stat("constitution", 2)
	H.change_stat("endurance", 2)
	H.change_stat("perception", 2)
	H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
