//ripped from forcewall.dm, modified to have a stronger timer & more health
//primarily used for vos arderla, ill be changing it 
/obj/structure/timed_blocker
	desc = "A wall of thick, unyielding blood."
	name = "bloodied wall"
	icon = 'modular_temperance/icons/bloodwall.dmi'
	icon_state = "bloodwall"
	break_sound = 'sound/combat/vite.ogg'
	attacked_sound = list('sound/gore/flesh_eat_05.ogg', 'sound/gore/flesh_eat_06.ogg', 'sound/gore/flesh_eat_02.ogg')
	opacity = 0
	density = TRUE
	max_integrity = 10
	CanAtmosPass = ATMOS_PASS_DENSITY
	var/timeleft = 15 MINUTES
	pixel_x = -8
	base_pixel_x = -8
	pixel_y = -8
	base_pixel_y = -8

/obj/structure/timed_blocker/Initialize()
	. = ..()
	if(timeleft)
		QDEL_IN(src, timeleft) //delete after it runs out

/obj/structure/timed_blocker/twenty
	timeleft = 20 MINUTES

/obj/structure/timed_blocker/twentyfive
	timeleft = 25 MINUTES

/obj/structure/timed_blocker/thirty
	timeleft = 30 MINUTES

/obj/structure/timed_blocker/thirtyfive
	timeleft = 35 MINUTES


