/datum/advclass/explorer

	name = "Explorer"
	tutorial = "You're an individual contracted by the town to delve into production sites, and produce valuables for the town as a whole.' \
	You generally work underneath the Provisioner, but may be demanded by the Hierarch to defend the town - if the need arises."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = ALL_RACES_TYPES
	outfit = /datum/outfit/job/roguetown/adventurer/explorer
	cmode_music = 'sound/music/combat_metalface.ogg'
	maximum_possible_slots = 4

	category_tags = list(CTAG_TOWNER)

/datum/outfit/job/roguetown/adventurer/explorer/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/revolvers, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/gun/ballistic/revolver/pace
	head = /obj/item/clothing/head/roguetown/helmet/heavy/ebhelmet
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/rogueweapon/stoneaxe/woodcut/steel/woodcutter
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	cloak = /obj/item/clothing/cloak/eastcloak2
	mask = /obj/item/clothing/mask/rogue/gasmask/eb_gasmask
	backpack_contents = list(
						/obj/item/flint = 1,
						/obj/item/flashlight/flare/torch/lantern = 1,
						/obj/item/rogueweapon/huntingknife = 1,
						/obj/item/ammo_box/speedloader/magnum = 3,
						/obj/item/rogueweapon/scabbard/sheath = 1
						)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 3)
	H.change_stat("speed", 1)
