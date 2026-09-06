//rifles

/obj/item/ammo_casing/a762
	name = "7.62mmR lead bullet casing"
	desc = "A 7.62 FMJ bullet."
	icon_state = "spent-casing_QT_rifle"
	caliber = "a762"
	projectile_type = /obj/projectile/bullet/a762
	bullet_type = RIFLECASING
	sellprice = 2

/obj/item/ammo_casing/a577
	name = ".577 blackout bullet piece"
	desc = "A .577 casing used for blowing heads off."
	icon_state = "spent-casing_QT_rifle"
	caliber = "a577"
	projectile_type = /obj/projectile/bullet/a577
	bullet_type = RIFLECASING
	sellprice = 3

/obj/item/ammo_casing/a50
	name = ".50 caliber bullet"
	desc = "An ugly bullet that breaks hearts."
	icon_state = "amrcasing-spent"
	caliber = "a50"
	projectile_type = /obj/projectile/bullet/a50
	bullet_type = RIFLECASING
	sellprice = 4

// handguns

/obj/item/ammo_casing/a9mm
	name = "9mm bullet casing"
	desc = "A 9mm lead ball, stuffed into a bullet case."
	icon_state = "spent-casing_QT_pistol"
	caliber = "a9mm"
	projectile_type = /obj/projectile/bullet/a9mm
	bullet_type = RIFLECASING
	sellprice = 1

/obj/item/ammo_casing/a44
	name = ".44 bullet casing"
	desc = "A freakishly lethal .44 bullet-piece."
	icon_state = "spent-casing_QT_pistol"
	caliber = "a44"
	projectile_type = /obj/projectile/bullet/a44
	bullet_type = RIFLECASING
	sellprice = 1

/obj/item/ammo_casing/a22lr
	name = ".22LR bullet casing"
	desc = "A tiny .22LR bullet-piece."
	icon_state = "spent-casing_QT_pistol"
	caliber = "a22lr"
	projectile_type = /obj/projectile/bullet/a22lr
	bullet_type = RIFLECASING
	sellprice = 1

/obj/item/ammo_casing/a45acp
	name = ".45 ACP bullet casing"
	desc = "A .45 ACP bullet-piece."
	icon_state = "spent-casing_QT_pistol"
	caliber = "a45acp"
	projectile_type = /obj/projectile/bullet/a45acp
	bullet_type = RIFLECASING
	sellprice = 1

/obj/item/ammo_casing/a380
    name = ".380 ACP bullet casing"
    desc = "A .380 ACP bullet-piece."
    icon_state = "spent-casing_QT_pistol"
    caliber = "a380"
    projectile_type = /obj/projectile/bullet/a380
    bullet_type = RIFLECASING
    sellprice = 1

/obj/item/ammo_casing/a45lc
	name = ".45 Long Colt bullet casing"
	desc = "A .45 Long Colt bullet-piece."
	icon_state = "spent-casing_QT_pistol"
	caliber = "a45lc"
	projectile_type = /obj/projectile/bullet/a45lc
	bullet_type = RIFLECASING
	sellprice = 1

/obj/item/ammo_casing/a30
	name = ".30 light bullet casing"
	desc = "A .30 light bullet-piece."
	icon_state = "spent-casing_QT_pistol"
	caliber = "a30"
	projectile_type = /obj/projectile/bullet/a30
	bullet_type = RIFLECASING
	sellprice = 1

/obj/item/ammo_casing/a762lp
	name = "LP 7.62mm bullet casing"
	desc = "A low powder 7.62mm bullet piece."
	icon_state = "spent-casing_QT_rifle"
	caliber = "a762lp"
	projectile_type = /obj/projectile/bullet/a762lp
	bullet_type = RIFLECASING
	sellprice = 1

//shotguns

/obj/item/ammo_casing/shotgun
	name = "shotgun slug"
	desc = "An evil slug."
	icon_state = "spent-casing_QT_shotgun"
	caliber = "shotgun"
	projectile_type = /obj/projectile/bullet/shotgun_slug
	bullet_type = SHOTGUNCASING
	sellprice = 2

/obj/item/ammo_casing/shotgun/buckshot
	name = "buckshot shell"
	desc = "A plastic piece that shoots buckshot."
	icon_state = "spent-casing_shotgun"
	caliber = "shotgun"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot
	pellets = 6
	variance = 18
	bullet_type = SHOTGUNCASING
	sellprice = 2

//grenade launchers

/obj/item/ammo_casing/a40mm
	name ="FUUUUUUUUCK" //this is a root item do NOT spawn this
	desc = "one of the 'mins or devs fucked up go tell someone"
	icon_state = "40mmincen-handful-1"
	caliber = "40mm"
	bullet_type = SHOTGUNCASING //these aren't shotguns but the shotgun sound is fine
	dropshrink = 0.3


/obj/item/ammo_casing/a40mm/flare
	name = "\improper FG-1 flare"
	desc = "A low intensity 40mm flare. These came from the LOVE MACHINE along with the flare gun, but the Dictate and Empire can both make these on their own nowadays."
	icon_state = "flare-handful-1"
	projectile_type = /obj/projectile/bullet/flare
	sellprice = 4


/obj/item/ammo_casing/a40mm/flareh
	name = "\improper FG-2 flare"
	desc = "A high intensity 40mm flare. These came from the LOVE MACHINE along with the flare gun, and burn brighter than any flares made today by either side. For some reason, they can't be ignited unless high in the air."
	icon_state = "flareh-handful-1"
	projectile_type = /obj/projectile/bullet/flare //we shouldn't be using this projectile so it can stay as-is
	sellprice = 10


/obj/item/ammo_casing/a40mm/he
	name = "\improper 40mm HE grenade"
	desc = "A 40mm HE grenade. These are a rare gift of the WAR MACHINE- albeit some have been saying Perserdun's researchers are figuring out how to reverse-engineer the explosives inside it."
	icon_state = "40mmhe-handful-1"
	projectile_type = /obj/projectile/bullet/a40mmhe 
	sellprice = 12


/obj/item/ammo_casing/a40mm/smoke
	name = "\improper 40mm smoke grenade"
	desc = "A 40mm smoke grenade. Strangely more common than other types of 40mm grenades, so Perserdun tends to issue them to their Voltigeurs."
	icon_state = "40mmsmoke-handful-1"
	projectile_type = /obj/projectile/bullet/a40mmsmoke
	sellprice = 5

/obj/item/ammo_casing/a40mm/gas
	name = "\improper 40mm gas grenade"
	desc = "A 40mm gas grenade. Uncommon compared to other types of 40mm grenades - usually reserved for specialists, such as the Protectorate's chemical units."
	icon_state = "40mmgas-handful-1"
	projectile_type = /obj/projectile/bullet/a40mmgas
	sellprice = 5

/obj/item/ammo_casing/a40mm/frag
	name = "\improper 40mm frag grenade"
	desc = "A 40mm frag grenade. Found in the WAR MACHINE, but some limited prototypes are hand-produced- albeit, they're very inconsistent. Fortunately, these seem to be actual WAR MACHINE grenades."
	icon_state = "40mmfrag-handful-1"
	projectile_type = /obj/projectile/bullet/a40mmfrag
	sellprice = 7

//other

/obj/item/ammo_casing/flamer
	name = "flame pellet"
	desc = "A fuel pellet used by a flamethrower."
	icon_state = null
	caliber = "flamer"
	projectile_type = /obj/projectile/bullet/flamer
	bullet_type = FLAMECASING


