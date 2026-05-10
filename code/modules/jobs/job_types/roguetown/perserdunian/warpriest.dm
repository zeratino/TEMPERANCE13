/datum/job/roguetown/warpriest
	title = "Field Bishop"
	flag = WARPRIEST
	department_flag = PERSERDUN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_CONSCRIPT
	allowed_patrons = list(/datum/patron/godless/perserdun)
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)

	tutorial = "You are a Field Bishop, a preacher of Rab's will and a warrior of the faith. \
				You've learned how to manipulate blood as both a weapon and a tool, being taught the practice at a young age by a noble house. \
				The training of Field Bishops is rigorous and extensive, leading to your body being weakened as a result. This is the extent you are allowed to share, however. \
				Field Bishops are an extremely valuable asset to the Perserdun force, though are few in numbers due to the extremely selective process. \
				Your role is to exercise Rab's practices, preachings, and support allies with your unique skillset." 

	outfit = /datum/outfit/job/roguetown/warpriest
	display_order = JDO_WARPRIEST
	give_bank_account = TRUE
	min_pq = 0
	max_pq = null

	cmode_music = 'sound/music/combat_warpriest.ogg' // kensuke ushio - Smells Blood

/datum/job/roguetown/warpriest/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.wear_ring, /obj/item/roguekey/perserdun))
			var/obj/item/clothing/S = H.wear_ring
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = " [index]'s dogtag"

/datum/outfit/job/roguetown/warpriest
	allowed_patrons = list(/datum/patron/godless/perserdun)

/datum/outfit/job/roguetown/warpriest/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/priest/warpriest
	shoes = /obj/item/clothing/shoes/roguetown/boots
	beltl = /obj/item/gun/ballistic/revolver/mercy
	beltr = /obj/item/flashlight/flare/torch/lantern
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/warpriest
	cloak = /obj/item/clothing/cloak/perserduntabard
	pants = /obj/item/clothing/under/roguetown/trou/artipants
	// neck = /obj/item/clothing/neck/roguetown/psicross/astrata	i'm hoping we get a religious symbol for rab at some point
	belt = /obj/item/storage/belt/rogue/leather/black/soldier
	wrists = /obj/item/scomstone/garrison
	gloves = /obj/item/clothing/wrists/roguetown/wrappings/perserdun
	id = /obj/item/roguekey/perserdun
	backr = /obj/item/storage/backpack/rogue/satchel/perserdun/warpriest
	
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/mid,
		/obj/item/ammo_box/handfuls/mercy,
		/obj/item/ammo_box/handfuls/mercy,
		/obj/item/clothing/mask/rogue/gasmask/perserdunmask, // they start with it in their backpack so they don't look dumb in the lobby lol
	)

	H.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
	H.adjust_skillrank(/datum/skill/magic/blood, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE) // cutting yourself and doing freaky blood shit would probably get you pretty good at wielding knives
	H.adjust_skillrank(/datum/skill/combat/revolvers, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	H.change_stat("strength", -2)
	H.change_stat("constitution", 3)
	H.change_stat("endurance", 3)
	H.change_stat("perception", 2)
	H.change_stat("intelligence", 4)
	H.change_stat("speed", -1)

	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/blood)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/blood_heal)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/bloodneedle)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/blood_link)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/piercing_blood)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodsiphon)
		// H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/bloodcrawl)
	ADD_TRAIT(H, TRAIT_RABCHOSEN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_RITUALIST, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC) // felt fitting but can be removed at request
