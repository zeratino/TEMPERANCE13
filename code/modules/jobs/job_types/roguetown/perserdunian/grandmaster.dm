/datum/job/roguetown/grandmaster
	title = "Grandmaster"
	flag = GRANDMASTER
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_CONSCRIPT
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	selection_color = JCOLOR_PERSERDUN

	tutorial = "You are the highest ranking Perserdunian officer in the regiment, akin to a Captain. \
				Your main purpose is the subjugation of the local duchy, and the repelling of the Risvon Empire. \
				You are aware that there is a WAR MACHINE buried underneath the ground. Your superiors expect you to claim it for the Glorious Empire." 

	outfit = /datum/outfit/job/roguetown/grandmaster
	display_order = JDO_GRANDMASTER
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_grandmaster.ogg'

/datum/job/roguetown/grandmaster/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/perserdun))
			var/obj/item/roguekey/perserdun/S = H.wear_ring
			S.set_soldier_name(H)

/datum/outfit/job/roguetown/grandmaster/pre_equip(mob/living/carbon/human/H)
	H.verbs += /mob/living/carbon/human/proc/grandmaster_raid
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	armor = /obj/item/clothing/suit/roguetown/armor/leather/grandmaster
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	head = /obj/item/clothing/head/roguetown/helmet/leather/grandmaster
	mask = /obj/item/clothing/mask/rogue/gasmask/grandmask
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/gun/ballistic/revolver/grandmaster
	wrists = /obj/item/scomstone/perlead
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	cloak = /obj/item/clothing/cloak/perserduntabard
	l_hand = /obj/item/rogueweapon/sword/rapier/grandmaster
	r_hand = /obj/item/rogueweapon/scabbard/sheath/grandmaster
	id = /obj/item/roguekey/perserdun
	backr = /obj/item/storage/backpack/rogue/backpack/perserdun
	backpack_contents = list(
		/obj/item/ammo_box/speedloader/magnum = 6,
		/obj/item/storage/belt/rogue/pouch/coins/rich,
		/obj/item/rogueweapon/whip,
	)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/revolvers, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/holdingweak)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/aimweak)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/chargeweak)
	H.change_stat("intelligence", 3)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

GLOBAL_VAR_INIT(grandmaster_raid_cooldown, -50000) // Antispam

/mob/living/carbon/human/proc/grandmaster_raid()
	set name = "DECLARE RAID"
	set category = "GRANDMASTER"
	if(stat)
		return
	var/announcementinput = input("DECLARE YOUR TARGET", "FORMALIZE RAID") as text|null
	if(announcementinput)
		if(!src.can_speak_vocal())
			to_chat(src,span_warning("I can't speak!"))
			return FALSE
		if(world.time < GLOB.grandmaster_raid_cooldown + 3600 SECONDS)
			to_chat(src, span_warning("You must wait [round((GLOB.grandmaster_raid_cooldown + 3600 SECONDS - world.time)/600, 0.1)] minutes before declaring another raid!"))
			return FALSE
		visible_message(span_warning("[src] takes a deep breath, reaching into a hidden radio.."))
		if(do_after(src, 15 SECONDS, target = src))
			say(announcementinput)
			priority_announce("[announcementinput]", "PERSERDUNIAN DECLARATION OF WAR", 'sound/misc/perserdun_raid.ogg', sender = src)
			GLOB.grandmaster_raid_cooldown = world.time
		else
			to_chat(src, span_warning("Your announcement was interrupted!"))
			return FALSE
