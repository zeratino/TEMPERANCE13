/datum/job/roguetown/commandant
	title = "Commandant"
	flag = COMMANDANT
	department_flag = RISVON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	selection_color = JCOLOR_RISVON

	tutorial = "You are the commanding officer of the local Risvon Capitro. Or Chapter, if you're a scrub. \
				You are aware of the discovery of a new WAR MACHINE in the local area. \
				Your main goal is to claim the entire production site for the Dictate, while also beating off any foreign intruders. \
				You're on the same intelligence level as an Oficiro, in terms of raw knowledge about the state. You were handpicked by higher ranks for your performance."

	outfit = /datum/outfit/job/roguetown/commandant
	display_order = JDO_COMMANDANT
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_commandant.ogg'

/datum/job/roguetown/commandant/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
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


/datum/outfit/job/roguetown/commandant/pre_equip(mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/commandant_raid
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half/iron/ziggurate/pauldrons
	cloak = /obj/item/clothing/cloak/templar/malumite
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	head = /obj/item/clothing/head/roguetown/helmet/kettle/iron/commandant
	mask = /obj/item/clothing/mask/rogue/gasmask/risvonmask/commandant
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/belt/rogue/pouch/ammobag
	wrists = /obj/item/scomstone
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	backl = /obj/item/gun/ballistic/rifle/repeater/commandant
	backr = /obj/item/storage/backpack/rogue/backpack/risvon
	id = /obj/item/roguekey/risvon
	backpack_contents = list(
		/obj/item/ammo_box/clip/pistol = 6,
		/obj/item/storage/belt/rogue/pouch/coins/rich,
		/obj/item/bomb/dynamite = 2,
		/obj/item/rogueweapon/stoneaxe/woodcut/risvon,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shotguns, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/pistols, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.change_stat("intelligence", 2)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)


GLOBAL_VAR_INIT(commandant_raid_cooldown, -50000) // Inits variable for later

/mob/living/carbon/human/proc/commandant_raid()
	set name = "DECLARE RAID"
	set category = "COMMANDANT"
	if(stat)
		return
	var/announcementinput = input("DECLARE YOUR TARGET", "FORMALIZE RAID") as text|null
	if(announcementinput)
		if(!src.can_speak_vocal())
			to_chat(src,span_warning("I can't speak!"))
			return FALSE
		if(world.time < GLOB.commandant_raid_cooldown + 3600 SECONDS)
			to_chat(src, span_warning("You must wait [round((GLOB.commandant_raid_cooldown + 3600 SECONDS - world.time)/600, 0.1)] minutes before declaring another raid!"))
			return FALSE
		visible_message(span_warning("[src] takes a deep breath, reaching into a hidden radio.."))
		if(do_after(src, 15 SECONDS, target = src))
			say(announcementinput)
			priority_announce("[announcementinput]", "RISVONIAN DECLARATION OF WAR", 'sound/misc/risvon_raid.ogg', sender = src)
			GLOB.commandant_raid_cooldown = world.time
		else
			to_chat(src, span_warning("Your announcement was interrupted!"))
			return FALSE

