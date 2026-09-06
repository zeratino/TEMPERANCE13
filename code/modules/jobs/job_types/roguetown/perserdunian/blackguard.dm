/datum/job/roguetown/blackguard
	title = "Blackguard"
	flag = BLACKGUARD
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You are a volunteer armsman, dedicated to close-range, independent skirmishes. \
				Your main goal is to map enemy defenses, and break the enemy's morale with your guerilla tactics.\
				Your roles may involve launching surprise attacks on isolated outposts or sentries - often using grenades and hand-to-hand combat. \
				This role is a voluntary position due to the high mortality rate of most trench raiders - this may invoke respect amongst your armsman peers. \
				You're armed with your revolver, grenades, and your trusty trench club - infiltrate them, and cripple their ranks in the name of the Empire." 

	outfit = /datum/outfit/job/roguetown/blackguard
	display_order = JDO_BLACKGUARD
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_sterilizer.ogg'

/datum/job/roguetown/blackguard/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/perserdun))
			var/obj/item/roguekey/perserdun/S = H.wear_ring
			S.set_soldier_name(H)


/datum/outfit/job/roguetown/blackguard/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	beltl = /obj/item/flashlight/flare/torch/lantern
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	cloak = /obj/item/clothing/cloak/blackguard
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	head = /obj/item/clothing/head/roguetown/roguehood/pontifex/black
	mask = /obj/item/clothing/mask/rogue/gasmask/eb_gasmask //Not standard-issue, but it looks scarier. 
	neck = /obj/item/clothing/neck/roguetown/chaincoif/full
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/gun/ballistic/revolver/webley
	backl = /obj/item/rogueweapon/mace/cudgel/blackguard
	wrists = /obj/item/scomstone/garrison
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	id = /obj/item/roguekey/perserdun
	backr = /obj/item/storage/backpack/rogue/backpack/perserdun
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/mid,
		/obj/item/grenade/gas/smoke = 2,
		/obj/item/ammo_box/speedloader/magnum = 3,
		/obj/item/bomb/dynamite = 3,
		/obj/item/bomb/molotov = 2,
		/obj/item/rogueweapon/huntingknife/combat/blackguard,
		)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE) 
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE) //Same tier as Veteranos
	H.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/revolvers, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.change_stat("strength", 1)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 1)
	H.change_stat("perception", 3)
	H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LIGHT_STEP, TRAIT_GENERIC)
