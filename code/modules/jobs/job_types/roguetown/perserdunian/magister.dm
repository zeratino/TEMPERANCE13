/datum/job/roguetown/magister
	title = "Magister Enginseer"
	flag = MAGISTER
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_TEMPERANCE_BATTLEMEDICS
	allowed_sexes = list(MALE, FEMALE)
	tutorial = "Enginseers are \"enlightened\" researchers of the MACHINE, changed by a sudden flood of impossible knowledge after a prolonged exposure to it. You remember only tampering with it before voices, ideas, and motions beyond your time filled your mind. As the Empire's Magister, you seek to understand this knowledge and use it for the good of your people. There is much you could learn from the MACHINE, but you hope its secrets might bring an end to this war and spare countless lives."
	outfit = /datum/outfit/job/roguetown/magister
	display_order = JDO_MAGISTER
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null
	cmode_music = 'sound/music/combat_servisto.ogg'


/datum/job/roguetown/magister/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/perserdun))
			var/obj/item/roguekey/perserdun/S = H.wear_ring
			S.set_soldier_name(H)

/datum/outfit/job/roguetown/magister/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	armor = /obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/enginseer
	cloak = /obj/item/clothing/cloak/perserduntabard
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/belt/rogue/pouch/stim
	mask = /obj/item/clothing/mask/rogue/gasmask/perserdunmask
	head = /obj/item/clothing/head/roguetown/roguehood/shalal/heavyhood/cmo
	wrists = /obj/item/scomstone/garrison
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	id = /obj/item/roguekey/perserdun
	backr = /obj/item/storage/backpack/rogue/satchel

	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/poor,
		/obj/item/rogueweapon/surgery/scalpel,
		/obj/item/rogueweapon/surgery/saw,
		/obj/item/rogueweapon/surgery/hemostat,
		/obj/item/rogueweapon/surgery/retractor,
		/obj/item/needle/pestra,
	)

	H.adjust_skillrank(/datum/skill/craft/crafting, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/masonry, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/blacksmithing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/engineering, 6, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)

	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/pistols, 3, TRUE)

	H.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

	H.change_stat("intelligence", 6)
	H.change_stat("constitution", -4)
	H.change_stat("endurance", -2)
	H.change_stat("speed", 2)

	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/conjure_beholder_magi)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/conjure_astrarium)

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCYNE_T4, TRAIT_GENERIC)
