/datum/job/roguetown/vagrantrebel
	title = "Rebel Vagrant"
	flag = VAGRANTREBEL
	department_flag = REBELS
	faction = "Station"
	total_positions = 12
	spawn_positions = 12
	selection_color = JCOLOR_PEASANT
	display_order = JDO_VAGRANTREBEL
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	cmode_music = 'sound/music/combat_jester.ogg'
	agevet_req = FALSE

	tutorial = "You were a vagrant, wandering the streets and alleys of the town, eking out a living as best you could. This rebellion is a perfect opportunity for some upward mobility - not that you really have any other choice."

	outfit = /datum/outfit/job/roguetown/vagrantrebel
	give_bank_account = 17
	min_pq = -10
	max_pq = null

/datum/outfit/job/roguetown/vagrantrebel/pre_equip(mob/living/carbon/human/H)
	..()
	if(should_wear_femme_clothes(H))
		armor = /obj/item/clothing/suit/roguetown/shirt/rags
	else if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/tights/vagrant/l
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
		if(prob(50))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l

	if(prob(33))
		cloak = /obj/item/clothing/cloak/half/brown
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
	
	if(prob(10))
		r_hand = /obj/item/gun/ballistic/rifle/repeater/auto8 //HOBO WITH A SHOTGUN.

	if (H.mind)
		H.adjust_skillrank(/datum/skill/misc/sneaking, rand(1,5), TRUE)
		H.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, rand(1,5), TRUE)
		H.adjust_skillrank(/datum/skill/misc/lockpicking, pick (1,2,3,4,5), TRUE)
		H.STALUC = rand(5, 15)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", -4)
		H.change_stat("constitution", -3)
		H.change_stat("endurance", -3)
		H.grant_language(/datum/language/thievescant)
		ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NASTY_EATER, TRAIT_GENERIC)
