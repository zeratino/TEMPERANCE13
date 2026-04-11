/obj/item/storage/belt/rogue
	name = ""
	desc = ""
	icon = 'icons/roguetown/clothing/belts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/belts.dmi'
	icon_state = ""
	item_state = ""
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("whips", "lashes")
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	content_overlays = FALSE
	bloody_icon_state = "bodyblood"
	experimental_inhand = FALSE
	component_type = /datum/component/storage/concrete/roguetown/belt
	grid_width = 64
	grid_height = 64

/obj/item/storage/belt/rogue/attack_right(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	if(CP)
		CP.rmb_show(user)
		return TRUE
	..()

/obj/item/storage/belt/rogue/leather
	name = "belt"
	desc = "A fine leather strap notched with holes for a buckle to secure itself."
	icon_state = "leather"
	item_state = "leather"
	equip_sound = 'sound/blank.ogg'
	sewrepair = TRUE
	sellprice = 10
	resistance_flags = FIRE_PROOF

/obj/item/storage/belt/rogue/leather/plaquegold
	name = "plaque belt"
	icon_state = "goldplaque"
	sellprice = 50
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/storage/belt/rogue/leather/shalal
	name = "shalal belt"
	icon_state = "shalal"
	sellprice = 5

/obj/item/storage/belt/rogue/leather/black
	name = "black belt"
	icon_state = "blackbelt"
	item_state = "blackbelt"
	sellprice = 10

/obj/item/storage/belt/rogue/leather/black/soldier
	populate_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel,
		/obj/item/reagent_containers/glass/bottle/rogue/healthpotnew,
	)

/obj/item/storage/belt/rogue/leather/plaquesilver
	name = "plaque belt"
	icon_state = "silverplaque"
	sellprice = 30
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/storage/belt/rogue/leather/steel
	name = "steel belt"
	icon_state = "steelplaque"
	sellprice = 30
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/storage/belt/rogue/leather/steel/tasset
	name = "tasseted belt"
	icon_state = "steeltasset"
	sellprice = 35
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/storage/belt/rogue/leather/rope
	name = "rope belt"
	desc = "A length of strong rope repurposed into a belt. Better than nothing."
	icon_state = "rope"
	item_state = "rope"
	color = "#b9a286"
	component_type = /datum/component/storage/concrete/roguetown/belt/cloth

/obj/item/storage/belt/rogue/leather/cloth
	name = "cloth sash"
	desc = "A strip of cloth tied together at the ends into a makeshift belt. It's better than nothing."
	icon_state = "cloth"
	component_type = /datum/component/storage/concrete/roguetown/belt/cloth

/obj/item/storage/belt/rogue/leather/cloth/lady
	color = "#575160"

/obj/item/storage/belt/rogue/leather/cloth/bandit
	color = "#ff0000"
	component_type = /datum/component/storage/concrete/roguetown/belt

/obj/item/storage/belt/rogue/leather/sash
	name = "fine sash"		//Like the cloth sash but with better storage. More expensive.
	desc = "A pliable sash made of wool meant to wrap tightly around the waist, especially popular with travellers who wear loose shirts."
	icon_state = "clothsash"
	item_state = "clothsash"

/obj/item/storage/belt/rogue/pouch
	name = "pouch"
	desc = "A small sack with a drawstring that allows it to be worn around the neck. Or at the hips, provided you have a belt."
	icon = 'icons/roguetown/clothing/storage.dmi'
	mob_overlay_icon = null
	icon_state = "pouch"
	item_state = "pouch"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("whips", "lashes")
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	content_overlays = FALSE
	bloody_icon_state = "bodyblood"
	sewrepair = TRUE
	resistance_flags = FIRE_PROOF
	grid_height = 64
	grid_width = 32
	component_type = /datum/component/storage/concrete/roguetown/coin_pouch

/obj/item/storage/belt/rogue/pouch/coins

/obj/item/storage/belt/rogue/pouch/coins/mid/Initialize()
	. = ..()
	var/obj/item/roguecoin/silver/pile/H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)
	var/obj/item/roguecoin/copper/pile/C = new(loc)
	if(istype(C))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, C, null, TRUE, TRUE))
			qdel(C)

/obj/item/storage/belt/rogue/pouch/coins/poor/Initialize()
	. = ..()
	var/obj/item/roguecoin/copper/pile/H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)
	if(prob(50))
		H = new(loc)
		if(istype(H))
			if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
				qdel(H)

/obj/item/storage/belt/rogue/pouch/coins/rich/Initialize()
	. = ..()
	var/obj/item/roguecoin/silver/pile/H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)
	H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)
	if(prob(50))
		H = new(loc)
		if(istype(H))
			if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
				qdel(H)

/obj/item/storage/belt/rogue/pouch/coins/virtuepouch/Initialize()
	. = ..()
	var/obj/item/roguecoin/gold/virtuepile/H = new(loc)
	if(istype(H))
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, H, null, TRUE, TRUE))
			qdel(H)

/obj/item/storage/belt/rogue/pouch/food/PopulateContents()
	new /obj/item/reagent_containers/food/snacks/rogue/crackerscooked(src)

/obj/item/storage/backpack/rogue/satchel
	name = "satchel"
	desc = "Modest, easy on the shoulders, and holds a respectable amount."
	icon_state = "satchel"
	item_state = "satchel"
	icon = 'icons/roguetown/clothing/storage.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = FIRE_PROOF
	max_integrity = 300
	sellprice = 10
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	alternate_worn_layer = UNDER_CLOAK_LAYER
	sewrepair = TRUE
	component_type = /datum/component/storage/concrete/roguetown/satchel

/obj/item/storage/backpack/rogue/satchel/heartfelt
	populate_contents = list(
		/obj/item/natural/feather,
		/obj/item/paper,
	)

/obj/item/storage/backpack/rogue/satchel/mule/PopulateContents()
	for(var/i in 1 to 3)
		switch(rand(1,4))
			if(1)
				new /obj/item/reagent_containers/powder/moondust_purest(src)
			if(2)
				new /obj/item/reagent_containers/powder/moondust_purest(src)
			if(3)
				new /obj/item/reagent_containers/powder/ozium(src)
			if(4)
				new /obj/item/reagent_containers/powder/spice(src)

/obj/item/storage/backpack/rogue/satchel/black
	color = CLOTHING_BLACK

/obj/item/storage/backpack/rogue/attack_right(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	if(CP)
		CP.rmb_show(user)
		return TRUE

/obj/item/storage/backpack/rogue/satchel/short
	name = "short satchel"
	desc = "A leather satchel that's meant to  clip to a belt or to a pair of pants, freeing the shoulders from any weight."
	icon_state = "satchelshort"
	item_state = "satchelshort"

/obj/item/storage/backpack/rogue/backpack
	name = "backpack"
	desc = "One of the best ways to carry many things while keeping your hands free."
	icon_state = "backpack"
	item_state = "backpack"
	icon = 'icons/roguetown/clothing/storage.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = FIRE_PROOF
	max_integrity = 300
	sellprice = 15
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	sewrepair = TRUE
	component_type = /datum/component/storage/concrete/roguetown/backpack

/obj/item/storage/backpack/rogue/artibackpack
	name = "Cooling backpack"
	desc = "A leather backpack with complex pipework coursing through it. It hums and vibrates constantly."
	icon_state = "artibackpack"
	item_state = "artibackpack" 
	icon = 'icons/roguetown/clothing/storage.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK_L
	resistance_flags = FIRE_PROOF
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	sewrepair = FALSE
	component_type = /datum/component/storage/concrete/roguetown/backpack

/obj/item/storage/backpack/rogue/backpack/bagpack
	name = "rucksack"
	desc = "A sack tied with some rope. Can be flung over your shoulders, if it's tied shut."
	icon_state = "rucksack_untied"
	item_state = "rucksack"
	component_type = /datum/component/storage/concrete/roguetown/sack/bag
	max_integrity = 100
	sewrepair = TRUE
	var/tied = FALSE

/obj/item/storage/backpack/rogue/backpack/bagpack/attack_right(mob/user)
	tied = !tied
	to_chat(user, span_info("I [tied ? "tighten" : "loosen"] the rucksack."))
	playsound(src, 'sound/foley/equip/rummaging-01.ogg', 100)
	update_icon()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(tied)
		STR.click_gather = FALSE
		STR.allow_quick_gather = FALSE
		STR.allow_quick_empty = FALSE
	else
		STR.click_gather = TRUE
		STR.allow_quick_gather = TRUE
		STR.allow_quick_empty = TRUE

/obj/item/storage/backpack/rogue/backpack/bagpack/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!tied && (slot == SLOT_BACK_L || slot == SLOT_BACK_R))
		var/datum/component/storage/STR = GetComponent(/datum/component/storage)
		var/list/things = STR.contents()
		if(length(things))
			visible_message(span_warning("The loose bag empties as it is swung around [user]'s shoulder!"))
			STR.quick_empty(user)

/obj/item/storage/backpack/rogue/backpack/bagpack/update_icon()
	. = ..()
	if(tied)
		icon_state = "rucksack_tied_sling"
	else
		icon_state = "rucksack_untied"

/obj/item/storage/belt/rogue/leather/plaquegold/steward
	name = "fancy gold belt"
	desc = "A dark belt with real gold making up the buckle and highlights. How bougie."
	icon_state = "stewardbelt"
	item_state = "stewardbelt"

//Knifeblade belts, act as quivers mixed with belts. Lower storage size of a belt, but holds knives without taking space.
/obj/item/storage/belt/rogue/leather/knifebelt
	name = "tossblade belt"
	desc = "A five-slotted belt meant for tossblades. Little room left over."
	icon_state = "knife"
	item_state = "knife"
	strip_delay = 20
	var/max_storage = 5			//Javelin bag is 4 and they can't hold items. So, more fair having it like this since these are pretty decent weapons.
	var/list/knives = list()
	sewrepair = TRUE
	component_type = /datum/component/storage/concrete/roguetown/belt/knife_belt

/obj/item/storage/belt/rogue/leather/knifebelt/attack_turf(turf/T, mob/living/user)
	if(knives.len >= max_storage)
		to_chat(user, span_warning("Your [src.name] is full!"))
		return
	to_chat(user, span_notice("You begin to gather the ammunition..."))
	for(var/obj/item/rogueweapon/huntingknife/throwingknife/K in T.contents)
		if(do_after(user, 5))
			if(!eatknife(K))
				break

/obj/item/storage/belt/rogue/leather/knifebelt/proc/eatknife(obj/A)
	if(A.type in typesof(/obj/item/rogueweapon/huntingknife/throwingknife))
		if(knives.len < max_storage)
			A.forceMove(src)
			knives += A
			update_icon()
			return TRUE
		else
			return FALSE

/obj/item/storage/belt/rogue/leather/knifebelt/attackby(obj/A, loc, params)
	if(A.type in typesof(/obj/item/rogueweapon/huntingknife/throwingknife))
		if(knives.len < max_storage)
			if(ismob(loc))
				var/mob/M = loc
				M.doUnEquip(A, TRUE, src, TRUE, silent = TRUE)
			else
				A.forceMove(src)
			knives += A
			update_icon()
			to_chat(usr, span_notice("I discreetly slip [A] into [src]."))
		else
			to_chat(loc, span_warning("Full!"))
		return
	..()

/obj/item/storage/belt/rogue/leather/knifebelt/attack_right(mob/user)
	if(knives.len)
		var/obj/O = knives[knives.len]
		knives -= O
		O.forceMove(user.loc)
		user.put_in_hands(O)
		update_icon()
		return TRUE

/obj/item/storage/belt/rogue/leather/knifebelt/examine(mob/user)
	. = ..()
	if(knives.len)
		. += span_notice("[knives.len] inside.")

/obj/item/storage/belt/rogue/leather/knifebelt/iron/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/K = new()
		knives += K
	update_icon()

/obj/item/storage/belt/rogue/leather/knifebelt/black
	icon_state = "blackknife"
	item_state = "blackknife"

/obj/item/storage/belt/rogue/leather/knifebelt/black/iron/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/K = new()
		knives += K
	update_icon()

/obj/item/storage/belt/rogue/leather/knifebelt/black/steel/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/steel/K = new()
		knives += K
	update_icon()

/obj/item/storage/belt/rogue/leather/knifebelt/black/psydon/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/psydon/K = new()
		knives += K
	update_icon()

/obj/item/storage/belt/rogue/leather/knifebelt/black/kazengun/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/rogueweapon/huntingknife/throwingknife/kazengun/K = new()
		knives += K
	update_icon()

/obj/item/storage/belt/rogue/leather/exoticsilkbelt
	name = "exotic silk belt"
	desc = "A gold adorned belt with the softest of silks barely concealing one's bits."
	icon_state = "exoticsilkbelt"
	var/max_storage = 5
	sewrepair = TRUE

///////////////////////////////////////////////

/obj/item/storage/hip/headhook
	name = "head hook"
	desc = "an iron hook for storing 6 heads"
	icon = 'icons/roguetown/clothing/belts.dmi'
	//mob_overlay_icon = 'icons/roguetown/clothing/onmob/belts.dmi' //N/A uncomment when a mob_overlay icon is made and added
	icon_state = "ironheadhook"
	item_state = "ironheadhook"
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_NORMAL
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	//content_overlays = FALSE
	bloody_icon_state = "bodyblood"
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/iron
	component_type = /datum/component/storage/concrete/grid/headhook

/obj/item/storage/hip/headhook/bronze
	name = "bronze head hook"
	desc = "a bronze hook for storing 12 heads"
	icon = 'icons/roguetown/clothing/belts.dmi'
	//mob_overlay_icon = 'icons/roguetown/clothing/onmob/belts.dmi'
	icon_state = "bronzeheadhook"
	item_state = "bronzeheadhook"
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_NORMAL
	max_integrity = 400
	equip_sound = 'sound/blank.ogg'
	//content_overlays = FALSE
	bloody_icon_state = "bodyblood"
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/bronze
	component_type = /datum/component/storage/concrete/grid/headhook/bronze


// 													!!!	TEMPERANCE 13 !!!

/obj/item/storage/belt/rogue/pouch/stim
	name = "carebag"
	desc = "A leather carebag that's meant to clip to a belt or to a pair of pants, freeing the shoulders from any weight."
	icon_state = "medsatchel"
	item_state = "medsatchel"
	component_type = /datum/component/storage/concrete/grid/stimbag
	populate_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/healthpotnew = 2,
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 2,
	)

/obj/item/storage/belt/rogue/pouch/ammobag
	name = "ammobox"
	desc = "A tin ammobox that clips to someone's belt."
	icon_state = "ammobox"
	item_state = "satchelshort"
	component_type = /datum/component/storage/concrete/grid/ammobag
	slot_flags = ITEM_SLOT_HIP

/obj/item/storage/belt/rogue/pouch/ammobag/rifle
	populate_contents = list( 
		/obj/item/ammo_box/handfuls/rifle, 
		/obj/item/ammo_box/handfuls/rifle, 
		/obj/item/ammo_box/handfuls/rifle, 
		/obj/item/ammo_box/handfuls/rifle, 
		/obj/item/ammo_box/handfuls/rifle, 
		/obj/item/ammo_box/handfuls/rifle, 
	)

/obj/item/storage/belt/rogue/pouch/ammobag/pistol 
	populate_contents = list(
		/obj/item/ammo_box/clip/pistol,
		/obj/item/ammo_box/clip/pistol,
		/obj/item/ammo_box/clip/pistol,
		/obj/item/ammo_box/clip/pistol,
		/obj/item/ammo_box/clip/pistol,
		/obj/item/ammo_box/clip/pistol,
	)

/obj/item/storage/belt/rogue/pouch/ammobag/amr
	name = "ammo sack"
	desc = "A leather satchel meant to carry boxes of .50 caliber rounds."
	icon_state = "warfare_satchel"
	item_state = "warfare_satchel"
	component_type = /datum/component/storage/concrete/grid/amr


/obj/item/storage/backpack/rogue/backpack/perserdun
	name = "ruckbag"
	desc = "Product of the Empire's vast industry."
	icon_state = "WU_backpack"
	item_state = "WU_backpack"

/obj/item/storage/backpack/rogue/backpack/risvon
	name = "bagsack"
	desc = "Product of the Dictate's national WAR MACHINE."
	icon_state = "EB_backpack"
	item_state = "EB_backpack"

/obj/item/storage/backpack/rogue/backpack/mg
	name = "bigbag"
	desc = "A hulking cloth bag lined with metal rods, attached to a harness, to assist in carrying loads of ammo."
	icon_state = "warfare_backpack"
	item_state = "warfare_backpack"
	component_type = /datum/component/storage/concrete/grid/hmg

/obj/item/storage/backpack/rogue/satchel/chestrig
	name = "chest rig"
	desc = "A WAR machine produced piece of clothing designed specifically to hold machine gun strip clips."
	icon_state = "chestrig"
	item_state = "chestrig"
	component_type = /datum/component/storage/concrete/grid/hmg

/obj/item/storage/belt/rogue/pouch/pillbottle
	name = "pill bottle"
	desc = "Plastic is a relatively rare and novel material, only being found on guns and other MACHINE-related items."
	icon_state = "pillcanister"
	item_state = "pillcanister"
	component_type = /datum/component/storage/concrete/grid/pillbottle
	populate_contents = list(
		/obj/item/reagent_containers/pill/painkiller,
		/obj/item/reagent_containers/pill/painkiller,
		/obj/item/reagent_containers/pill/health,
		/obj/item/reagent_containers/pill/health,
		/obj/item/reagent_containers/pill/health,
	)

/obj/item/storage/backpack/rogue/satchel/risvon
	name = "hardbag"
	desc = "A durable, machine-produced nylon satchel bag."
	icon_state = "blue_satchel"
	item_state = "blue_satchel"

/obj/item/storage/backpack/rogue/satchel/perserdun
	name = "backsack"
	desc = "A durable, hand-made cloth sack."
	icon_state = "redsatchelalt"
	item_state = "redsatchelalt"

/obj/item/storage/backpack/rogue/satchel/surgeon
	name = "medbag"
	desc = "A clean, compartmentalized satchel for holding advanced medical supplies. Product of the LIFE machine."
	icon_state = "medic_satchel_blue"
	item_state = "medic_satchel_blue"
