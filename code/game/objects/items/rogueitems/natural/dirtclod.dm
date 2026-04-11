/obj/item/natural/dirtclod
	name = "clod"
	desc = "A handful of earth."
	icon_state = "clod1"
	dropshrink = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY

/obj/item/natural/dirtclod/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/rogueweapon/shovel))
		var/obj/item/rogueweapon/shovel/S = W
		if(!S.heldclod && user.used_intent.type == /datum/intent/shovelscoop)
			playsound(loc,'sound/items/dig_shovel.ogg', 100, TRUE)
			src.forceMove(S)
			S.heldclod = src
			W.update_icon()
			return
	..()

/obj/item/natural/dirtclod/Moved(oldLoc, dir)
	..()
	if(isturf(loc))
		var/turf/T = loc
		for(var/obj/structure/fluff/clodpile/C in T)
			C.dirtamt = min(C.dirtamt+1, 5)
			qdel(src)
			return
		var/dirtcount = 1
		var/list/dirts = list()
		for(var/obj/item/natural/dirtclod/D in T)
			dirtcount++
			dirts += D
		if(dirtcount >=5)
			for(var/obj/item/I in dirts)
				qdel(I)
			qdel(src)
			new /obj/structure/fluff/clodpile(T)

/obj/item/natural/dirtclod/attack_self(mob/living/user)
	user.visible_message(span_warning("[user] scatters [src]."))
	qdel(src)

/obj/item/natural/dirtclod/Initialize()
	icon_state = "clod[rand(1,2)]"
	..()
	var/static/list/slapcraft_recipe_list = list(
		/datum/crafting_recipe/roguetown/survival/wickercloak,
		)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
		)

/obj/item/natural/dirtclod/attackby(obj/item/rogueweapon/W as obj, mob/user as mob)
	if(istype(W,/obj/item/rogueweapon/shovel))
		var/obj/item/rogueweapon/shovel/C = W
		if(C.heldclod)
			if(C.working)
				return
			if((
				locate(/obj/structure/barricade/brustwehr) || \
				locate(/obj/structure/fluff/railing/sandbag)) in src.loc.contents \
				)
				to_chat(user, "\red There is no more space.")
				return 0
			if(istype(src, /turf/open/water))
				to_chat(user, "\red You can't dig brustwehrs on water.")
				return 0
			C.working = 1
			playsound(src, 'sound/items/empty_shovel.ogg', 100, 1)
			to_chat(user, "You begin to dig a brustwehr.")
			if(!C.ground >= 2)
				to_chat(user, "You need more sand on your shovel.")
				C.working = 0
				return 0
			if(!do_after(user, 20,src))
				C.working = 0
				return
			new /obj/structure/barricade/brustwehrincomplete(src.loc)
			C.ground = 0
			C.working = 0
			var/obj/item/I = C.heldclod
			C.heldclod = null
			qdel(I) //delete the clod on the shovel
			C.update_icon() 
			qdel(src) //delete the clod on the ground

	else
		return ..()

/obj/structure/fluff/clodpile
	name = "dirt pile"
	desc = "A pile of dirt."
	icon_state = "clodpile"
	var/dirtamt = 5
	icon = 'icons/roguetown/items/natural.dmi'
	climbable = FALSE
	density = FALSE
	climb_offset = 10

/obj/structure/fluff/clodpile/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/rogueweapon/shovel))
		var/obj/item/rogueweapon/shovel/S = W
		if(user.used_intent.type == /datum/intent/shovelscoop)
			if(!S.heldclod)
				playsound(loc,'sound/items/dig_shovel.ogg', 100, TRUE)
				var/obj/item/J = new /obj/item/natural/dirtclod(S)
				S.heldclod = J
				W.update_icon()
				dirtamt--
				if(dirtamt <= 0)
					qdel(src)
				return
			else
				playsound(loc,'sound/items/empty_shovel.ogg', 100, TRUE)
				var/obj/item/I = S.heldclod
				S.heldclod = null
				qdel(I)
				W.update_icon()
				dirtamt++
				if(dirtamt > 5)
					dirtamt = 5
				return
	..()

/obj/structure/fluff/clodpile/Initialize()
	dir = pick(GLOB.cardinals)
	..()
