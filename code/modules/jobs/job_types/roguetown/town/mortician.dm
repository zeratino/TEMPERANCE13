/datum/job/roguetown/mortician
	title = "Mortician"
	flag = MORTICIAN
	department_flag = KINGSROW
	faction = "Station"
	total_positions = 3
	spawn_positions = 3

	allowed_races = RACES_TEMPERANCE_NONCOMBATANT
	allowed_sexes = list(MALE, FEMALE)
	tutorial = "You're one of the few intelligent enough to understand the new gifts of medicine provided by the MACHINES. \
				Your job is to handle the dead and wounded of your town - or whoever happens to pay for your services."

	outfit = /datum/outfit/job/roguetown/mortician
	display_order = JDO_MORTICIAN
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_physician.ogg'

/datum/outfit/job/roguetown/mortician

/datum/outfit/job/roguetown/mortician/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	mask = /obj/item/clothing/mask/rogue/sterilemask
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/belt/rogue/surgery_bag/full/physician
	beltr = /obj/item/storage/keyring/physician
	backl = /obj/item/storage/backpack/rogue/satchel
	wrists = /obj/item/scomstone/kingsrow
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 2,
		/obj/item/natural/worms/leech/cheele = 1,
		/obj/item/reagent_containers/glass/bottle/waterskin = 1,
		/obj/item/recipe_book/alchemy = 1,
		/obj/item/flashlight/flare/torch/lantern = 1,
	)
	H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 6, TRUE)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
	H.change_stat("strength", -1)
	H.change_stat("constitution", -1)
	H.change_stat("intelligence", 4)
	H.change_stat("fortune", 1)
	H.change_stat("endurance", 1)
	if(should_wear_masc_clothes(H))
		cloak = /obj/item/clothing/cloak/apron
		gloves = /obj/item/clothing/gloves/roguetown/leather/latex
		armor = /obj/item/clothing/suit/roguetown/armor/leather/mortician
		shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/black
		pants = /obj/item/clothing/under/roguetown/trou/leather/mourning
	else if(should_wear_femme_clothes(H)) // skirt (black), low cut tunic - no gloves
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut
		shoes = /obj/item/clothing/shoes/roguetown/armor/rumaclan
		pants = /obj/item/clothing/under/roguetown/skirt/darkgrey
