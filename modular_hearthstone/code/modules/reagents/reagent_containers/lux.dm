/obj/item/reagent_containers/lux
	name = "REVIVER"
	desc = "This ugly little thing latches onto someone's heart, and produces life."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "voice_of_god"
	item_state = "voice_of_god"
	possible_transfer_amounts = list()
	volume = 15
	list_reagents = list(/datum/reagent/vitae = 5)
	grind_results = list(/datum/reagent/vitae = 5)
	sellprice = 3

/datum/reagent/vitae
	name = "Vitae"
	description = "The extracted and processed essence of life."
	color = "#7d8e98" // rgb: 96, 165, 132
	overdose_threshold = 10
	metabolization_rate = 0.1

/datum/reagent/vitae/overdose_process(mob/living/M)
	M.adjustOrganLoss(ORGAN_SLOT_HEART, 0.25*REM)
	M.adjustFireLoss(0.25*REM, 0)
	..()
	. = 1

/datum/reagent/vitae/on_mob_life(mob/living/carbon/M)
	if(M.has_flaw(/datum/charflaw/addiction/junkie))
		M.sate_addiction()
	M.apply_status_effect(/datum/status_effect/buff/vitae)
	..()
