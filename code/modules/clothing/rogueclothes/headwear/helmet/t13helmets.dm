

//heavy helmets

/obj/item/clothing/head/roguetown/helmet/heavy/ebhelmet
	name = "manufactured kettle helmet"
	desc = "A helmet made by a foreign WAR MACHINE. Exposes the face."
	body_parts_covered = HEAD|HAIR|EARS
	armor = ARMOR_GRUDGEBEARER
	prevent_crits = list(BCLASS_TWIST)
	allowed_race = ALL_RACES_TYPES
	icon = 'icons/roguetown/clothing/head.dmi'
	icon_state = "EB_helm"
	item_state = "EB_helm"
	block2add = FOV_DEFAULT
	bloody_icon = 'icons/effects/blood64.dmi'
	smeltresult = /obj/item/ingot/steel
	max_integrity = 1000
	experimental_inhand = TRUE
	experimental_onhip = TRUE

/obj/item/clothing/head/roguetown/helmet/heavy/ebhelmet/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/layeredarmor/ebarmor) //defined in t13armor.dm

/obj/item/clothing/head/roguetown/helmet/heavy/ebhelmet/visored
	name = "armored kettle helmet"
	desc = "A helmet made by a foreign WAR MACHINE. This one's been modified to have a visor."
	icon_state = "EB_helm_armored"
	item_state = "EB_helm_armored"
	body_parts_covered = FULL_HEAD
	flags_inv = HIDEFACE

/obj/item/clothing/suit/roguetown/helmet/heavy/ebhelmet/visored/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/layeredarmor/ebarmor)

/obj/item/clothing/head/roguetown/helmet/heavy/barbute/visor/hedge
	name = "iron roundface helmet"
	desc = "An iron helmet of an obscure shape. Supposedly smithed after the visage of beasts of old."
	icon_state = "iroundface"
	item_state = "iroundface"
	max_integrity = ARMOR_INT_HELMET_HEAVY_IRON

// medium helmets
/obj/item/clothing/head/roguetown/helmet/kettle/iron/soldato
	name = "iron kettle helmet"
	desc = "A kettle helmet made of iron. It protects the top and sides of the head."
	adjustable = CAN_CADJUST
	flags_inv = HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES
	body_parts_covered = HEAD|EARS|NOSE|EYES
	block2add = FOV_BEHIND
	icon_state = "ikettle_visor"
	smeltresult = /obj/item/ingot/iron
	max_integrity = ARMOR_INT_HELMET_IRON

/obj/item/clothing/head/roguetown/helmet/kettle/iron/soldato/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (HEAD|EARS), null, null, 'sound/items/visor.ogg', null, UPD_HEAD)

/obj/item/clothing/head/roguetown/helmet/kettle/iron/visored
	name = "decorated kettle helmet"
	desc = "A kettle helmet. It has the visor of a stolen Knight Commander's helmet welded onto it."
	flags_inv = HIDEFACE|HIDESNOUT|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES
	block2add = FOV_BEHIND
	icon_state = "ikettlevisor"
	item_state = "ikettlevisor"

/obj/item/clothing/head/roguetown/helmet/kettle/iron/oficiro
	name = "iron risvonian helmet"
	desc = "A metal helmet. It kinda looks like a sallet."
	icon_state = "oficiro"
	item_state = "oficiro"

/obj/item/clothing/head/roguetown/helmet/kettle/iron/commandant
	name = "iron risvonian helmet"
	desc = "A metal helmet. Custom made. For the Divegat!"
	icon_state = "commandant"
	item_state = "commandant"

/obj/item/clothing/head/roguetown/helmet/blacksteel/modern/armet/bulwark
	name = "machined armet"
	desc = "Make them pay."
	icon_state = "ibulwark"
	item_state = "ibulwark"
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi'
	flags_inv = HIDE_HEADTOP

/obj/item/clothing/head/roguetown/helmet/kettle/iron/magiisto
	name = "risvonian mage helmet"
	desc = "Traditional wizard garb had to adapt when the MACHINES appeared. A chainmail veil and kettle helm underneath did well enough to last."
	flags_inv = HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES
	body_parts_covered = HEAD|EARS|NOSE|EYES
	block2add = FOV_BEHIND
	icon_state = "magiisto"
	smeltresult = /obj/item/ingot/iron
	max_integrity = ARMOR_INT_HELMET_IRON
	worn_x_dimension = 64
	worn_y_dimension = 64
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	bloody_icon = 'icons/effects/blood64.dmi'

/obj/item/clothing/head/roguetown/roguehood/shalal/heavyhood/cmo
	name = "archomachine-weaved hood"
	desc = "A heavy, reinforced hood. The cloth is laced with intricate formulas, hinting at an Enginseer's ability to weave their art into even the simplest fabric."
	block2add = FOV_DEFAULT
	color = CLOTHING_RED
	armor = ARMOR_HEAD_HELMET_VISOR

// light helmets

/obj/item/clothing/head/roguetown/helmet/leather/grandmaster
	name = "master's cap"
	desc = "A handcrafted cap, following the fashion style produced by the LOVE MACHINE. Has a metal plate on the front."
	body_parts_covered = HEAD
	icon_state = "grandhat"
	item_state = "grandhat"
	experimental_inhand = FALSE
	experimental_onhip = FALSE
	flags_inv = null

/obj/item/clothing/head/roguetown/helmet/leather/envoy
	name = "envoy's cap"
	desc = "A handcrafted cap, in line with Perserdunian diplomatic standards. Padded."
	icon_state = "envoy"
	item_state = "envoy"
	experimental_inhand = FALSE
	experimental_onhip = FALSE
	sellprice = 200
	flags_inv = HIDE_HEADTOP

/obj/item/clothing/head/roguetown/helmet/leather/leech
	name = "leech's softcap"
	desc = "A softcap with a badge denoting the wearer as a leech of the Perserdunian forces, it slightly droops on the head."
	icon_state = "leechcap"
	item_state = "leechcap"
	experimental_inhand = FALSE
	experimental_onhip = FALSE
	flags_inv = HIDE_HEADTOP

/obj/item/clothing/head/roguetown/veil
	name = "veil"
	desc = "For the Divegat."
	icon_state = "veil"
	item_state = "veil"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	dynamic_hair_suffix = ""
	sewrepair = TRUE
	//dropshrink = 0.75

/obj/item/clothing/head/roguetown/helmet/leather/flamer
	slot_flags = ITEM_SLOT_HEAD
	name = "scorched hood"
	desc = "A plastic-rubber combination. Comes with a funny face, with respiratory features."
	body_parts_covered = HEAD|HAIR|EARS|NOSE|FACE
	icon_state = "flamer"
	armor = list("blunt" = 100, "slash" = 70, "stab" = 50, "piercing" = 50, "fire" = 90, "acid" = 0)
	sellprice = 10
	prevent_crits = list(BCLASS_BLUNT, BCLASS_TWIST, BCLASS_BURN)
	sewrepair = TRUE
	blocksound = SOFTHIT
	max_integrity = ARMOR_INT_HELMET_LEATHER

/obj/item/clothing/head/roguetown/maid
	name = "maid headdress"
	desc = "Servant's mark."
	icon_state = "maidhead"
	item_state = "maidhead"
	icon = 'icons/roguetown/clothing/special/maids.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/maids.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/maids.dmi'

/obj/item/clothing/head/roguetown/helmet/riot
	name = "protectorate pot-helm"
	desc = "A MACHINED helmet with a chin-strap to ensure stability. Exposes the face."
	body_parts_covered = HEAD|HAIR|EARS
	flags_inv = HIDEEARS|HIDEHAIR
	armor = ARMOR_HEAD_HELMET
	prevent_crits = list(BCLASS_TWIST)
	allowed_race = ALL_RACES_TYPES
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi'
	icon_state = "riothelm"
	item_state = "riothelm"
	block2add = FOV_DEFAULT
	bloody_icon = 'icons/effects/blood64.dmi'
	smeltresult = /obj/item/ingot/steel
	max_integrity = 300
