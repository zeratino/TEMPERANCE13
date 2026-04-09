/datum/job/roguetown/servisto
	title = "Magiisto"
	flag = SERVISTO
	department_flag = RISVON
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)

	tutorial = "You are a magician within the Dictate's forces. \
				You're attached to each Cadre, acting as both a means to increase Soldato strength and basic first aid. \
				The healing magic you know comes from Marionettes & teachings found within the WAR and LOVE Machines." 

	outfit = /datum/outfit/job/roguetown/servisto
	display_order = JDO_SERVISTO
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_servisto.ogg'

/datum/job/roguetown/servisto/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
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
    
/datum/outfit/job/roguetown/servisto/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron/ziggurate
	cloak = /obj/item/clothing/cloak/templar/malumite
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	head = /obj/item/clothing/head/roguetown/helmet/kettle/iron
	mask = /obj/item/clothing/mask/rogue/gasmask/risvonmask
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/belt/rogue/pouch/stim
	wrists = /obj/item/scomstone
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	id = /obj/item/roguekey/risvon
	backr = /obj/item/storage/backpack/rogue/backpack/risvon
	backpack_contents = list(
		/obj/item/ammo_box/clip/pistol = 4,
		/obj/item/gun/ballistic/rifle/repeater/pistol,
		/obj/item/storage/belt/rogue/pouch/coins/poor,
		/obj/item/smokegrenade = 2,
		/obj/item/rogueweapon/stoneaxe/woodcut/risvon,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/pistols, 4, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/regression)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/convergence)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/stasis)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/fortitude)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/haste)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/stoneskin)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCYNE_T3, TRAIT_GENERIC)
