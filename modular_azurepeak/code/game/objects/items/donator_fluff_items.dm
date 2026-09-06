//Lazily shoving all donator fluff items in here for now. Feel free to make this a sub-folder or something, I think it's just easier to keep a list here and just modify as needed.

//Plexiant's donator item - rapier
/obj/item/rogueweapon/sword/rapier/aliseo
	name = "\"Espada de La Rosa\""
	desc = "Are you with me, bandits?"
	icon_state = "plex"
	icon = 'modular_azurepeak/icons/obj/items/donor_weapons_64.dmi'

//Ryebread's donator item - estoc
/obj/item/rogueweapon/estoc/worttrager
	name = "Wortträger"
	desc = "An imported Grenzelhoftian panzerstecher, a superbly crafted implement devoid of armory marks- merely bearing a maker's mark and the Zenitstadt seal. This one has a grip of walnut wood, and a pale saffira set within the crossguard. The ricasso is engraved with Ravoxian scripture."
	icon_state = "mansa"
	icon = 'modular_azurepeak/icons/obj/items/donor_weapons_64.dmi'

//Srusu's donator item - dress
/obj/item/clothing/suit/roguetown/shirt/dress/emerald
	name = "emerald dress"
	desc = "A silky smooth emerald-green dress, only for the finest of ladies."
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR	//Goes either slot, no armor on it after all.
	icon_state = "laciedress"
	sleevetype = "laciedress"
	icon = 'modular_azurepeak/icons/clothing/donor_clothes.dmi'
	mob_overlay_icon = 'modular_azurepeak/icons/clothing/onmob/donor_clothes.dmi'
	sleeved = 'modular_azurepeak/icons/clothing/onmob/donor_sleeves_armor.dmi'

//Strudles donator item - mage vest (same as robes)
/obj/item/clothing/suit/roguetown/shirt/robe/sofiavest
	name = "grenzelhoftian mages vest"
	desc = "A vest often worn by those of the Grenzelhoftian mages college."
	icon_state = "sofiavest"
	item_state = "sofiavest"
	sleevetype = "sofiavest"
	icon = 'modular_azurepeak/icons/clothing/donor_clothes.dmi'
	mob_overlay_icon = 'modular_azurepeak/icons/clothing/onmob/donor_clothes.dmi'
	sleeved = 'modular_azurepeak/icons/clothing/onmob/donor_sleeves_armor.dmi'
	flags_inv = HIDEBOOB
	color = null
	nodismemsleeves = TRUE // prevents sleeves from being torn

//Bat's donator item - custom harp sprite
/obj/item/rogue/instrument/harp/handcarved
	name = "handcrafted harp"
	desc = "A handcrafted harp."
	icon_state = "batharp"
	icon = 'modular_azurepeak/icons/obj/items/donor_objects.dmi'

//Rebel0's donator item - visored sallet with a hood on under it. (Same as normal sallet)
/obj/item/clothing/head/roguetown/helmet/sallet/visored/gilded
	name = "gilded visored sallet"
	desc = "A steel helmet with gilded trim which protects the ears, nose, and eyes."
	icon_state = "gildedsallet_visor"
	item_state = "gildedsallet_visor"
	icon = 'modular_azurepeak/icons/clothing/donor_clothes.dmi'
	mob_overlay_icon = 'modular_azurepeak/icons/clothing/onmob/donor_clothes.dmi'

//Zydras donator item - merchant dress
/obj/item/clothing/suit/roguetown/shirt/dress/silkydress/zydrasdress //Recolored silky dress
	name = "Gold-Black silky dress"
	desc = "A gorgeous black and gold dress. It seems the padding was removed."
	icon_state = "zydrasdress"
	item_state = "zydrasdress"
	sleevetype = "zydrasdress"
	icon = 'modular_azurepeak/icons/clothing/donor_clothes.dmi'
	mob_overlay_icon = 'modular_azurepeak/icons/clothing/onmob/donor_clothes.dmi'
	sleeved = 'modular_azurepeak/icons/clothing/onmob/donor_sleeves_armor.dmi' //No sleeves
