/datum/astrarium_quest/kill/wolf
	name = "ANOMALOUS WOLF PURGE"
	description = "A hostile wolf anomaly has been detected within the operational perimeter. Locate the anomaly and eliminate it."
/datum/astrarium_quest/kill/wolf/New(obj/structure/machine/astrarium/A)
	..(A)
	target_type = /mob/living/simple_animal/hostile/retaliate/rogue/wolf

/datum/astrarium_quest/kill/robot
	name = "STRANGER PURGE"
	description = "A hostile machine anomaly has been detected within the operational perimeter. Locate the anomaly and eliminate it."
/datum/astrarium_quest/kill/robot/New(obj/structure/machine/astrarium/A)
	..(A)
	target_type = /mob/living/simple_animal/hostile/rogue/robot/gunner/rifle

/datum/astrarium_quest/kill/orc
	name = "GREENPLAGUE ENTITY PURGE"
	description = "A hostile greenskin anomaly has been detected within the operational perimeter. Locate the anomaly and eliminate it."
/datum/astrarium_quest/kill/orc/New(obj/structure/machine/astrarium/A)
	..(A)
	target_type = /mob/living/carbon/human/species/orc/npc/marauder

/datum/astrarium_quest/kill/goblin
	name = "GRETCHKIN ENTITY PURGE"
	description = "A hostile gretchkin anomaly has been detected within the operational perimeter. Locate the anomaly and eliminate it."
/datum/astrarium_quest/kill/goblin/New(obj/structure/machine/astrarium/A)
	..(A)
	target_type = /mob/living/carbon/human/species/goblin/npc/ambush/cave

/datum/astrarium_quest/raid/wolf
	name = "ANOMALOUS WOLF RAID"
	description = "A pack of hostile wolf anomalies has been detected within the operational perimeter. Locate the anomaly pack and eliminate the entire force."
/datum/astrarium_quest/raid/wolf/New(obj/structure/machine/astrarium/A)
	..(A)
	target_type = /mob/living/simple_animal/hostile/retaliate/rogue/wolf

/datum/astrarium_quest/raid/robot
	name = "STRANGER RAID"
	description = "A hostile machine force has been detected within the operational perimeter. Locate the anomaly and eliminate the entire force."
/datum/astrarium_quest/raid/robot/New(obj/structure/machine/astrarium/A)
	..(A)
	target_type = /mob/living/simple_animal/hostile/rogue/robot/gunner/rifle

/datum/astrarium_quest/raid/orc
	name = "GREENPLAGUE RAID"
	description = "A hostile greenskin force has been detected within the operational perimeter. Locate the anomaly and eliminate the entire force."
/datum/astrarium_quest/raid/orc/New(obj/structure/machine/astrarium/A)
	..(A)
	target_type = /mob/living/carbon/human/species/orc/npc/marauder

/datum/astrarium_quest/raid/goblin
	name = "GRETCHKIN RAID"
	description = "A hostile gretchkin force has been detected within the operational perimeter. Locate the anomaly and eliminate the entire force."
/datum/astrarium_quest/raid/goblin/New(obj/structure/machine/astrarium/A)
	..(A)
	target_type = /mob/living/carbon/human/species/goblin/npc/ambush/cave
