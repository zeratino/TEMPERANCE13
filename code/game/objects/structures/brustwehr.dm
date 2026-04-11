//port from escal, this is horrific shitcode bye
/obj/structure/barricade/brustwehrincomplete
	name = "incomplete brustwehr"
	icon = 'icons/obj/structures.dmi'
	icon_state = "brustwehr_isntready"
	density = 1
	anchored = 1
	max_integrity = 10
	climbable = FALSE
	pass_flags_self = PASSTABLE
	var/digstage = 0

/obj/structure/barricade/brustwehrincomplete/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/rogueweapon/shovel))
		var/obj/item/rogueweapon/shovel/C = W
		if(user.used_intent.type == /datum/intent/shovelscoop)
			if(C.heldclod)
				if(C.working)
					return
				C.working = 1
				if(!C.ground > 0)
					C.working = 0
					return
				playsound(src, 'sound/items/empty_shovel.ogg', 100, 1)
				if(!do_after(user, 10,src))
					to_chat(user, "Hold still to do this.")
					C.working = 0
					return
				C.ground--
				digstage++
				C.working = 0
				to_chat(user, "You put some ground onto the [src].")
				if(digstage <= 2)
					to_chat(user, "<span class='warning'>You need [3 - digstage] more piles.</span>")
				update_stage()
				var/obj/item/I = C.heldclod
				C.heldclod = null
				qdel(I)
				C.update_icon()

		else
			return ..()

/obj/structure/barricade/brustwehrincomplete/proc/update_stage()
	if(digstage >= 3)
		new /obj/structure/barricade/brustwehr(src.loc)
		qdel(src)

/obj/structure/barricade/brustwehr
	name = "brustwehr"
	desc = "Land structure to cover your ass!"
	icon = 'icons/obj/sandbags.dmi'
	icon_state = "brustwehr_0"
	density = 1
	anchored = 1
	max_integrity = 4000
	smooth = TRUE
	climbable = TRUE
	var/health = 100

/obj/structure/barricade/brustwehr/New()
	..()
	update_nearby_icons()

/obj/structure/barricade/brustwehr/Destroy()
	..()
	update_nearby_icons()

	//Explosion Act MANNY: this is shitcode and can be done better, but is functional and idc
/obj/structure/barricade/brustwehr/ex_act(severity)
	switch(severity)
		if(1.0)
			visible_message("\red <B>[src] is blown apart!</B>")
			src.update_nearby_icons()
			qdel(src)
			return
		if(2.0)
			src.health -= rand(30,60)
			if (src.health <= 0)
				visible_message("\red <B>[src] is blown apart!</B>")
				src.update_nearby_icons()
				qdel(src)
			return
		if(3.0)
			src.health -= rand(10,30)
			if (src.health <= 0)
				visible_message("\red <B>[src] is blown apart!</B>")
				src.update_nearby_icons()
				qdel(src)
			return

	//Update Sides
/obj/structure/barricade/brustwehr/proc/update_nearby_icons()
	update_icon()
	for(var/direction in GLOB.cardinals)
		for(var/obj/structure/barricade/brustwehr/B in get_step(src,direction))
			B.update_icon()

	//Update Icons
/obj/structure/barricade/brustwehr/update_icon()
	spawn(2)
		if(!src)
			return
		var/junction = 0 //will be used to determine from which side the barricade is connected to other barricades
		for(var/obj/structure/barricade/brustwehr/B in orange(src,1))
			if(abs(x-B.x)-abs(y-B.y) ) 		//doesn't count barricades, placed diagonally to src
				junction |= get_dir(src,B)

		icon_state = "brustwehr_[junction]"
		return


/*
/obj/item/weapon/ore/glass/attack_self(mob/user as mob)
	if(!isturf(user.loc))
		to_chat(user, "\red Haha. Nice try.")
		return

	if(!check4struct(user))
		return

	var/obj/structure/brustwehr/B = new(user.loc)
	B.set_dir(user.dir)
	user.drop_item()
	qdel(src)
*/
