/datum/advclass/gunslinger
	name = "Gunslinger"
	tutorial = "Embracers of the modern day. Relies on guns, skills, and some armor, sometimes none."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_CONSCRIPT
	outfit = /datum/outfit/job/roguetown/adventurer/gunslinger
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	classes = list("Private Investigator" = "Sent here by someone lookin' for something or just passin' buy for a job, really anything that can get you by for another day whatever it may be, your best pal in all of this is your revolver, and that inquisitive mind of yours. The folks in need of your services are usually the ones who have no one else to turn to, so try not to let them down.",
					"Debt Collector" = "Here to collect someone's debt or make sure someone's gonna be owin' ya, you've got the dosh to lend and the muscle to retrieve. Try not to make too many enemies though, if anything, it's a safe bet to work with the Provisioner, after all, they've got the most coin in this shitty town anyways.",
					"Old-Boy" = "Maybe you inherited your old man's hunting rifle, or bought your own. Maybe you just wanna go out there and shoot something, be a hunter, or maybe you wanna be a mercenary for hire, whatever it is, try to make a name for yourself out there.")

/datum/outfit/job/roguetown/adventurer/gunslinger/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Private Investigator","Debt Collector","Old-Boy")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Private Investigator")
			to_chat(H, span_warning("Sent here by someone lookin' for something or just passin' buy for a job, really anything that can get you by for another day whatever it may be, your best pal in all of this is your revolver, and that inquisitive mind of yours. The folks in need of your services are usually the ones who have no one else to turn to, so try not to let them down."))
			armor = /obj/item/clothing/suit/roguetown/armor/leather
			backl = /obj/item/storage/backpack/rogue/satchel
			shoes = /obj/item/clothing/shoes/roguetown/boots
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltr = /obj/item/gun/ballistic/revolver/webley
			belt = /obj/item/storage/belt/rogue/leather/knifebelt/iron
			gloves = /obj/item/clothing/gloves/roguetown/fingerless
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/artificer
			cloak = /obj/item/clothing/suit/roguetown/armor/longcoat
			head = /obj/item/clothing/head/roguetown/fedora
			backpack_contents = list(
				/obj/item/flashlight/flare/torch = 1,
				/obj/item/lockpick = 1, 
				/obj/item/rogueweapon/mace/cudgel = 1, // it's a shame I can't get billy clubs in here, but this is the next best thing
				/obj/item/lockpickring/mundane = 1,
				/obj/item/ammo_box/speedloader/magnum = 3,
				)
			H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/revolvers, 3, TRUE)
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
			ADD_TRAIT(H, TRAIT_NIGHT_OWL, TRAIT_GENERIC) 
			H.change_stat("intelligence", 2)
			H.change_stat("perception", 2)
			H.change_stat("speed", 3)
			H.grant_language(/datum/language/thievescant)
			H.set_blindness(0)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_private.ogg'

		if("Debt Collector")
			
			to_chat(H, span_warning("Here to collect someone's debt or make sure someone's gonna be owin' ya, you've got the dosh to lend and the muscle to retrieve. Try not to make too many enemies though, if anything, it's a safe bet to work with the Provisioner, after all, they've got the most coin in this shitty town anyways."))
			armor = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
			cloak = /obj/item/clothing/suit/roguetown/armor/longcoat
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			pants = /obj/item/clothing/under/roguetown/trou/leather
			beltl = /obj/item/gun/ballistic/rifle/repeater/fury
			beltr = /obj/item/rogueweapon/knuckles
			shoes = /obj/item/clothing/shoes/roguetown/boots
			neck = /obj/item/clothing/neck/roguetown/gorget
			gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
			backl = /obj/item/storage/backpack/rogue/satchel
			belt = /obj/item/storage/belt/rogue/leather
			head = /obj/item/clothing/head/roguetown/puritan
			backpack_contents = list(
				/obj/item/lockpick = 1, 
				/obj/item/rogueweapon/huntingknife = 1, 
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1,
				/obj/item/ammo_box/magazine/fury = 3,
				/obj/item/flashlight/flare/torch = 1,
				/obj/item/storage/belt/rogue/pouch/coins/rich = 1,
				/obj/item/storage/belt/rogue/pouch/coins/poor = 1,
				)
			H.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/pistols, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
			H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			H.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
			ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)
			H.change_stat("strength", 2)
			H.change_stat("intelligence", -1)
			H.change_stat("perception", 1)
			H.change_stat("endurance", 2)
			H.change_stat("speed", 1)
			H.set_blindness(0)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_debt.ogg'

		if("Old-Boy")
			
			to_chat(H, span_warning("Maybe you inherited your old man's hunting rifle, or bought your own. Maybe you just wanna go out there and shoot something, be a hunter, or maybe you wanna be a mercenary for hire, whatever it is, try to make a name for yourself out there."))
			armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/jacket
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			pants = /obj/item/clothing/under/roguetown/trou
			beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
			shoes = /obj/item/clothing/shoes/roguetown/boots
			gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
			backl = /obj/item/storage/backpack/rogue/satchel
			backr = /obj/item/gun/ballistic/rifle/repeater/mondragon
			belt = /obj/item/storage/belt/rogue/leather
			backpack_contents = list(
				/obj/item/lockpick = 1, 
				/obj/item/rogueweapon/huntingknife = 1, 
				/obj/item/recipe_book/survival = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1,
				/obj/item/ammo_box/handfuls/rifle = 2,
				/obj/item/flashlight/flare/torch = 1,
				)
			H.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
			H.adjust_skillrank(/datum/skill/combat/rifles, 3, TRUE)
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
			H.change_stat("perception", 2)
			H.change_stat("endurance", 1)
			H.change_stat("speed", 3)
			H.set_blindness(0)
			H.cmode_music = 'sound/music/cmode/adventurer/combat_gunman.ogg'
