
//this shit is mad broken and slated to be deleted. oops!


/obj/item/clothing/suit/roguetown/armor/plate/full/ebarmor
	name = "manufactured armor plate"
	desc = "A standard, manufactured armor plate produced by the WAR MACHINE."
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	icon_state = "EB_armor"
	item_state = "EB_armor"
	armor = ARMOR_GRUDGEBEARER
	allowed_race = ALL_RACES_TYPES
	prevent_crits = list(BCLASS_TWIST)
	body_parts_covered = CHEST|GROIN|VITALS
	equip_delay_self = 5 SECONDS
	unequip_delay_self = 5 SECONDS
	equip_delay_other = 1 SECONDS
	strip_delay = STRIP_DELAY_NORMAL
	smelt_bar_num = 4
	max_integrity = 1000
	sleeved = null

/obj/item/clothing/suit/roguetown/armor/plate/full/ebarmor/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/layeredarmor/ebarmor)

/datum/component/layeredarmor/ebarmor/
	hits_to_shred = list(
		"blunt" = 10,
		"slash" = 10,
		"stab" = 10,
		"piercing" = 10,
	)

	layer_max = list(
		"blunt" = 40,
		"slash" = 100,
		"stab" = 100,
		"piercing" = 90,
	)

	hits_per_layer = list(
		"100"	= 10,
		"70" 	= 10,
		"40" 	= 10,
		"10" 	= 10,
	)

	damtype_shred_ratio = list(
		"blunt" = 5,
		"slash" = 1,
		"stab" = 1,
		"piercing" = 5,
	)

	shred_amt = 30
	layer_repair = 3
	shred_sound = 'sound/combat/armorblock.ogg'

/obj/item/clothing/suit/roguetown/armor/plate/full/ebarmor/pauldrons
	name = "pauldroned armor plate"
	desc = "A human-modified, manufactured armor plate. MACHINE-made, with pauldrons slapped on."
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	icon_state = "EB_armor_pauldrons"
	item_state = "EB_armor_pauldrons"
	body_parts_covered = CHEST|GROIN|VITALS|ARMS
	sleeved = null

/obj/item/clothing/suit/roguetown/armor/plate/full/ebarmor/pauldrons/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/layeredarmor/ebarmor)


/obj/item/clothing/suit/roguetown/armor/plate/full/iron //moved from plate.dm
	name = "iron plate armor"
	icon_state = "grandknight"
	desc = "Full iron plate armor. Slow to don and doff without the aid of an Armsman."
	smeltresult = /obj/item/ingot/iron
	armor = ARMOR_PLATE_GOOD
	allowed_race = ALL_RACES_TYPES
	prevent_crits = list(BCLASS_TWIST)
	equip_delay_self = 5 SECONDS
	unequip_delay_self = 5 SECONDS
	equip_delay_other = 1 SECONDS
	strip_delay = STRIP_DELAY_NORMAL
	smelt_bar_num = 4
	max_integrity = ARMOR_INT_CHEST_PLATE_PSYDON
	body_parts_covered = CHEST | GROIN | VITALS | LEGS | ARMS | NECK

//light armor

/obj/item/clothing/suit/roguetown/armor/leather/grandmaster
	name = "master's cloak"
	desc = "A full-body suit, stolen from a WAR MACHINE. Rather expensive. Comes with a decorative tin shoulder."
	icon_state = "grandmaster"
	item_state = "grandmaster"
	body_parts_covered = CHEST | GROIN | VITALS | LEGS | ARMS | NECK
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	sleevetype = "grandmaster"

/obj/item/clothing/suit/roguetown/armor/leather/consulo
	name = "consulo's coat"
	desc = "One of the few trench coats you'll actually see. Very, very expensive."
	icon_state = "consulo"
	item_state = "consulo"
	body_parts_covered = COVERAGE_FULL
	sellprice = 800 //kill the enemy's diplomat for insane amounts of money

/obj/item/clothing/suit/roguetown/armor/leather/consulo2
	name = "consulo's silk coat"
	desc = "A stylish, padded coat, made of fine silk and leather. With luck, it'll only be stained with ink, not blood."
	icon_state = "noblecoat"
	item_state = "noblecoat"
	sleevetype = "noblecoat"
	detail_tag = "_detail"
	detail_color = "#4A310E"
	color = "#681818"
	boobed = TRUE
	body_parts_covered = COVERAGE_FULL
	sellprice = 400

/obj/item/clothing/suit/roguetown/armor/leather/envoy
	name = "envoy's coat"
	desc = "A stylish piece, meant to showcase Perserdun's strong economy."
	icon_state = "envoy"
	item_state = "envoy"
	body_parts_covered = COVERAGE_FULL
	sellprice = 400

/obj/item/clothing/suit/roguetown/armor/leather/mortician
	name = "mortici's robes"
	desc = "A set of clothing that's meant to protect from scalpel nicks."
	icon_state = "mortician"
	item_state = "mortician"
	body_parts_covered = COVERAGE_FULL

/obj/item/clothing/suit/roguetown/armor/leather/heavy/radio
	name = "imperial coat"
	desc = "Semi-formal wear, standard issue for radio officers."
	icon_state = "northprotector"
	item_state = "northprotector"
	body_parts_covered = COVERAGE_FULL
	max_integrity = ARMOR_INT_CHEST_LIGHT_MASTER
	equip_delay_self = 40
	armor = list("blunt" = 100, "slash" = 50, "stab" = 80, "piercing" = 80, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/roguetown/armor/leather/heavy/hierarch
	name = "leader's guard"
	desc = "Silks and cloth, with some padded leather."
	icon_state = "officerguard"
	item_state = "officerguard"
	body_parts_covered = COVERAGE_FULL
	max_integrity = ARMOR_INT_CHEST_LIGHT_MEDIUM
	equip_delay_self = 40

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/bulwark
	name = "YKT-34 'Heart'"
	desc = "It's a padded uniform."
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi' // sorry for this shit code, i just cant be fucked
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_shirts.dmi'
	icon_state = "bulwark"
	item_state = "bulwark"

/obj/item/clothing/suit/roguetown/armor/plate/modern/blacksteel_full_plate/bulwark
	name = "machined armor"
	desc = "Raw strips of metal from the Outlet's walls, heated and formed for personal protection."
	icon_state = "ibulwark"
	item_state = "ibulwark"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'

/obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/flamer
	name = "fire suit"
	desc = "A fire-retardant coat stripped from the War Machine."
	icon_state = "flamercoat"
	item_state = "flamercoat"
	body_parts_covered = COVERAGE_FULL
	armor = list("blunt" = 100, "slash" = 70, "stab" = 50, "piercing" = 50, "fire" = 100, "acid" = 0)

/obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/displaced
	name = "tattered coat"
	desc = "A coat worn by the Displaced Heir. It's seen better days."
	icon = 'icons/roguetown/clothing/special/displaced.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/displaced.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/displaced.dmi'
	icon_state = "handgambeson"
	item_state = "handgambeson"
	body_parts_covered = COVERAGE_FULL

/obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/butler
	name = "buttoned coat"
	desc = "It's been a while."
	icon_state = "butlercoat"
	item_state = "butlercoat"
	body_parts_covered = COVERAGE_FULL
	icon = 'icons/roguetown/clothing/special/housekeeper.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/housekeeper.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/housekeeper.dmi'

/obj/item/clothing/suit/roguetown/armor/leather/heavy/coat/nelly
	name = "sewn dress"
	desc = "..For fear of losing the small power I still retained."
	icon_state = "maiddressfancy"
	item_state = "maiddressfancy"
	body_parts_covered = COVERAGE_FULL
	icon = 'icons/roguetown/clothing/special/housekeeper.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/housekeeper.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/housekeeper.dmi'


/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/maid
	name = "sweet dress"
	desc = "I really thought them not vindictive, I was deceived completely."
	slot_flags = ITEM_SLOT_SHIRT
	icon_state = "maiddress"
	item_state = "maiddress"
	icon = 'icons/roguetown/clothing/special/maids.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/maids.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/maids.dmi'
	color = null

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/butler
	name = "sleek waistcoat"
	desc = "I implore you not to touch a single thing, even furniture, in this manor without my explicit permission."
	slot_flags = ITEM_SLOT_SHIRT
	icon_state = "artishirt"
	item_state = "artishirt"
	icon = 'icons/roguetown/clothing/shirts.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/shirts.dmi'
	color = null

/obj/item/clothing/suit/roguetown/armor/plate/hauberk
	name = "plated hauberk"
	icon_state = "cuirasshauberk"
	desc = "A thick iron breastplate over a sturdy hauberk. Difficult to take off."
	smeltresult = /obj/item/ingot/iron
	armor = ARMOR_CUIRASS
	allowed_race = ALL_RACES_TYPES
	prevent_crits = list(BCLASS_TWIST)
	equip_delay_self = 2.5 SECONDS
	unequip_delay_self = 2.5 SECONDS
	equip_delay_other = 0.5 SECONDS
	strip_delay = STRIP_DELAY_NORMAL
	smelt_bar_num = 2
	max_integrity = ARMOR_INT_CHEST_PLATE_IRON
	body_parts_covered = CHEST | GROIN | VITALS | LEGS | ARMS | NECK

// Mechanically no different, this just uses the iron hauberk sprite from Azure, so it looks different

/obj/item/clothing/suit/roguetown/armor/plate/hauberk/alt
	desc = "A thick iron breastplate over a sturdy hauberk. This one has seen a plethora of use."
	icon_state = "icuirasshauberk"
