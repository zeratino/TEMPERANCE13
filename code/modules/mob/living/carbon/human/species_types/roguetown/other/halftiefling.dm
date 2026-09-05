/mob/living/carbon/human/species/hualian
	race = /datum/species/hualian

/datum/species/hualian
	name = "Hualian"
	id = "hualian"
	desc = "<b>Hualian</b><br>\
		Hualians are hybrid mutants created when Type-W Yuanite geneseed from lab-mutated Tiletians infects a humen. \
		The process is highly selective, with only the disabled and dying known to survive it, making Hualians difficult to produce in any meaningful number. \
		The original humen is lost, leaving behind a new creature marked by horns, a tail, and strange black crystals growing across their body. \
		They hunger for blood and flesh to maintain their sanity, growing stronger as they lose it, making them fearsome weapons of war when properly managed.<br> \
		(+1 Intelligence, +1 Speed | Steelhearted, Inhuman Digestion, Choice: Bloodfiend or Wyverntouched)"

	skin_tone_wording = "Ancestry"

	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP, TRAIT_STEELHEARTED, TRAIT_NASTY_EATER, TRAIT_YUANITE)
	default_features = MANDATORY_FEATURE_LIST
	use_skintones = 1
	disliked_food = NONE
	liked_food = NONE
	possible_ages = ALL_AGES_LIST
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT

	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mt.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'

	soundpack_m = /datum/voicepack/male
	soundpack_f = /datum/voicepack/female

	offset_features = list(
		OFFSET_ID = list(0,1), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1),
		OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1),
		OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,1),
		OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,1), OFFSET_PANTS = list(0,1),
		OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_HANDS = list(0,1), OFFSET_UNDIES = list(0,1),
		OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0),
		OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1),
		OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,0), OFFSET_BACK_F = list(0,-1),
		OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0),
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,-1),
	)

	race_bonus = list(STAT_INTELLIGENCE = 1, STAT_SPEED = 1)
	enflamed_icon = "widefire"

	bodypart_features = list(
		/datum/bodypart_feature/hair/head,
		/datum/bodypart_feature/hair/facial,
	)

	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/bodypart_feature/underwear,
		/datum/customizer/organ/horns/anthro/halftiefling, // mandatory horns, you freak of nature
		/datum/customizer/organ/tail/halftiefling, // optional tail, you coward
		/datum/customizer/organ/testicles/anthro,
		/datum/customizer/organ/penis/anthro,
		/datum/customizer/organ/breasts/human, // we can pretend this is DD+ minimum
		/datum/customizer/organ/vagina/human_anthro,
	)

	body_marking_sets = list(
		/datum/body_marking_set/none,
		/datum/body_marking_set/belly,
		/datum/body_marking_set/bellysocks,
		/datum/body_marking_set/tiger,
		/datum/body_marking_set/tiger_dark,
		/datum/body_marking_set/gradient,
	)

	body_markings = list(
		/datum/body_marking/flushed_cheeks,
		/datum/body_marking/eyeliner,
		/datum/body_marking/tonage,
		/datum/body_marking/nose,
		/datum/body_marking/bangs,
		/datum/body_marking/bun,
		/datum/body_marking/facepaint
	)

	languages = list(
		/datum/language/common
	)

	stress_examine = TRUE
	stress_desc = span_red("Alchemical-infected freak!")

/datum/species/hualian/after_creation(mob/living/carbon/C)
	..()
	addtimer(CALLBACK(C, TYPE_PROC_REF(/mob/living/carbon/human, choose_yuanite_mutation)), 5)

/mob/living/carbon/human/proc/choose_yuanite_mutation()
	var/mob/living/carbon/human/C = src
	var/choice = alert(C, "The Yuanite within me has settled into...", "Yuanite String Mutation", "Bloodfiend (Vampirism)", "Wyverntouched (Toxicity)")

	switch(choice)
		if("Bloodfiend (Vampirism)")
			ADD_TRAIT(C, TRAIT_BLOODFIEND, TRAIT_GENERIC)
			ADD_TRAIT(C, TRAIT_STRONGBITE, TRAIT_GENERIC)
			var/obj/item/organ/tail/halftiefling/T = C.getorganslot(ORGAN_SLOT_TAIL)
			if(T && C.mind)
				C.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/tail_stab/drain)

		if("Wyverntouched (Toxicity)")
			ADD_TRAIT(C, TRAIT_WYVERNTOUCHED, TRAIT_GENERIC)
			ADD_TRAIT(C, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
			var/obj/item/organ/tail/halftiefling/T = C.getorganslot(ORGAN_SLOT_TAIL)
			if(T && C.mind)
				C.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/tail_stab/tox)
	
	if(C.mind)
		C.mind.AddSpell(new /obj/effect/proc_holder/spell/self/feast)
		C.mind.AddSpell(new /obj/effect/proc_holder/spell/self/devil_trigger)

/datum/species/hualian/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/hualian/check_roundstart_eligible()
	return TRUE

/datum/species/hualian/get_skin_list()
	return list(
		"Norden" = SKIN_COLOR_GRENZELHOFT,
		"Perserdun" = SKIN_COLOR_ETRUSCA,
		"Yun" = SKIN_COLOR_GRONN,
		"King's Row" = SKIN_COLOR_GIZA,
		"Kalarian Commoner" = SKIN_COLOR_SHALVISTINE,
		"Kalarian Export" = SKIN_COLOR_LALVESTINE,
		"Risvonian Commoner" = SKIN_COLOR_NALEDI,
		"Risvonian Conscript" = SKIN_COLOR_NALEDI_LIGHT,
	)

/datum/species/hualian/get_hairc_list()
	return sortList(list(
		"blond - pale" = "9d8d6e",
		"blond - dirty" = "88754f",
		"blond - drywheat" = "d5ba7b",
		"blond - strawberry" = "c69b71",

		"brown - mud" = "362e25",
		"brown - oats" = "584a3b",
		"brown - grain" = "58433b",
		"brown - soil" = "48322a",

		"black - oil" = "181a1d",
		"black - cave" = "201616",
		"black - rogue" = "2b201b",
		"black - midnight" = "1d1b2b",

		"red - berry" = "48322a",
		"red - wine" = "82534c",
		"red - sunset" = "82462b",
		"red - blood" = "822b2b"
	))
