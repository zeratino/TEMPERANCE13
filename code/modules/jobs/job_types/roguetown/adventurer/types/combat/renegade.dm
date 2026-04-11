/datum/advclass/renegade
	name = "Renegade Gunslinger"
	tutorial = "Convicts, criminals, and outcasts. Whatever it may be, you're on the run, and you've got a gun."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_CONSCRIPT
	outfit = /datum/outfit/job/roguetown/adventurer/renegade
	maximum_possible_slots = 5
	traits_applied = list(TRAIT_OUTLANDER)
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	classes = list("Perpretrator" = "In all honesty, you're probably a criminal. You have a double-barreled shotgun.",
					"Desperado" = "You might just be a bandit, or a cowboy lover. You carry a mass-produced revolver.",
					"Gangster" = "You're probably from a gang. Or, you happened to kill whoever held the pistol before you. Make some money, grab some guns. Try not to die.",)

/datum/outfit/job/roguetown/adventurer/renegade/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Perpretrator","Desperado","Gangster")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Perpretrator")
			to_chat(H, span_warning("In all honesty, you're probably a criminal. You have a double-barreled shotgun."))
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			pants = /obj/item/clothing/under/roguetown/trou
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			backr = /obj/item/gun/ballistic/revolver/doublebarrel
			shoes = /obj/item/clothing/shoes/roguetown/boots
			gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
			backl = /obj/item/storage/backpack/rogue/satchel
			belt = /obj/item/storage/belt/rogue/leather
			backpack_contents = list(
				/obj/item/lockpick = 1, 
				/obj/item/rogueweapon/huntingknife = 1, 
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1,
				/obj/item/ammo_box/handfuls/shotgun/buckshot = 2,
				/obj/item/flashlight/flare/torch = 1,
				)
			H.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/shotguns, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.change_stat("strength", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 3)
			H.set_blindness(0)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_gunman.ogg'

		if("Desperado")
			to_chat(H, span_warning("You might just be a bandit, or a cowboy lover. You carry a mass-produced revolver."))
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			backl = /obj/item/storage/backpack/rogue/satchel
			shoes = /obj/item/clothing/shoes/roguetown/boots
			head = /obj/item/clothing/head/roguetown/brimmed
			neck = /obj/item/clothing/neck/roguetown/gorget
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/gun/ballistic/revolver/pace
			belt = /obj/item/storage/belt/rogue/leather/knifebelt/iron
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			cloak = /obj/item/clothing/cloak/half/red
			backpack_contents = list(
				/obj/item/flashlight/flare/torch = 1,
				/obj/item/rogueweapon/huntingknife/idagger/steel = 1,
				/obj/item/lockpickring/mundane = 1,
				/obj/item/ammo_box/speedloader/magnum = 2,
				/obj/item/rogueweapon/scabbard/sheath = 1,
				)
			H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/revolvers, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/craft/traps, 4, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.change_stat("strength", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 3)
			H.grant_language(/datum/language/thievescant)
			H.set_blindness(0)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_gunman.ogg'

		if("Gangster")
			
			to_chat(H, span_warning("You're probably from a gang. Or, you happened to kill whoever held the pistol before you. Make some money, grab some guns. Try not to die."))
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/artificer
			pants = /obj/item/clothing/under/roguetown/trou/leather
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/gun/ballistic/rifle/repeater/jackal
			shoes = /obj/item/clothing/shoes/roguetown/boots
			gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
			backl = /obj/item/storage/backpack/rogue/satchel
			belt = /obj/item/storage/belt/rogue/leather
			backpack_contents = list(
				/obj/item/lockpick = 1, 
				/obj/item/rogueweapon/huntingknife = 1, 
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/knuckles = 1,
				/obj/item/ammo_box/magazine/jackal = 3,
				/obj/item/flashlight/flare/torch = 1,
				)
			H.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/pistols, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.change_stat("strength", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 3)
			H.set_blindness(0)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_gunman.ogg'

