GLOBAL_DATUM_INIT(ssd_indicator, /mutable_appearance, mutable_appearance('icons/mob/ssd_indicator.dmi', "default0", FLY_LAYER))

/mob/living/proc/set_ssd_indicator(state)
	if(!state || stat == DEAD)
		cut_overlay(GLOB.ssd_indicator)
		return
	for(var/client/C in GLOB.clients)
		if(C.current_aghost_body == src)
			return
	add_overlay(GLOB.ssd_indicator)
