/obj/item/clothing/under/roguetown/platelegs/blacksteel/modern/bulwark
	name = "machined plate chausses"
	desc = "This thing can shrug off most bullets."
	icon_state = "ibulwark"
	item_state = "ibulwark"
	icon = 'icons/roguetown/clothing/pants.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/pants.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_pants.dmi'

/obj/item/clothing/under/roguetown/heavy_leather_pants/flamer
	name = "burnt pants"
	desc = "It's from the War Machine."
	gender = PLURAL
	icon_state = "flamer"
	item_state = "flamer"
	sewrepair = TRUE
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST, BCLASS_BURN)
	armor = list("blunt" = 100, "slash" = 70, "stab" = 50, "piercing" = 50, "fire" = 90, "acid" = 0)
	max_integrity = ARMOR_INT_LEG_HARDLEATHER
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	resistance_flags = FIRE_PROOF
	armor_class = ARMOR_CLASS_LIGHT

/obj/item/clothing/under/roguetown/tights/manor
	name = "black pants"
	desc = "The stitching's almost seamless."
	icon_state = "butlerpants"
	item_state = "butlerpants"
	icon = 'icons/roguetown/clothing/special/housekeeper.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/housekeeper.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/housekeeper.dmi'

/obj/item/clothing/under/roguetown/tights/riot
	name = "protectorate field-pants"
	desc = "Dyed in the menacing blue of the PCP. Offers a modest amount of protection from the elements."
	icon_state = "riotpants"
	item_state = "riotpants"
	icon = 'icons/roguetown/clothing/pants.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/pants.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_pants.dmi'
	armor_class = ARMOR_CLASS_LIGHT
	max_integrity = ARMOR_INT_LEG_HARDLEATHER
	armor = ARMOR_LEATHER_GOOD
