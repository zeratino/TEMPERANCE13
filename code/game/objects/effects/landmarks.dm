/obj/effect/landmark
	name = "landmark"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x2"
	anchored = TRUE
	layer = MID_LANDMARK_LAYER
	invisibility = INVISIBILITY_ABSTRACT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

// Please stop bombing the Observer-Start landmark.
/obj/effect/landmark/ex_act()
	return

INITIALIZE_IMMEDIATE(/obj/effect/landmark)

/obj/effect/landmark/Initialize()
	. = ..()
	GLOB.landmarks_list += src

/obj/effect/landmark/Destroy()
	GLOB.landmarks_list -= src
	return ..()

/obj/effect/landmark/start
	name = "start"
	icon = 'icons/mob/landmarks.dmi'
	icon_state = "x"
	anchored = TRUE
	layer = MOB_LAYER
	var/list/jobspawn_override = list()
	var/delete_after_roundstart = TRUE
	var/used = FALSE

/obj/effect/landmark/start/proc/after_round_start()
	if(delete_after_roundstart)
		qdel(src)

/obj/effect/landmark/start/Initialize()
	GLOB.start_landmarks_list += src
	if(jobspawn_override.len)
		for(var/X in jobspawn_override)
			if(!GLOB.jobspawn_overrides[X])
				GLOB.jobspawn_overrides[X] = list()
			GLOB.jobspawn_overrides[X] += src
	. = ..()
	if(name != "start")
		tag = "start*[name]"

/obj/effect/landmark/start/Destroy()
	GLOB.start_landmarks_list -= src
	for(var/X in jobspawn_override)
		GLOB.jobspawn_overrides[X] -= src
	return ..()

/obj/effect/landmark/events/haunts
	name = "hauntz"
	icon_state = "generic_event"

/obj/effect/landmark/events/haunts/Initialize(mapload)
	. = ..()
	GLOB.hauntstart += src
	icon_state = ""


/obj/effect/landmark/events/testportal
	name = "testserverportal"
	icon_state = "x4"
	var/aportalloc = "a"

/obj/effect/landmark/events/testportal/Initialize(mapload)
	. = ..()
//	GLOB.hauntstart += loc
#ifdef TESTSERVER
	var/obj/structure/fluff/testportal/T = new /obj/structure/fluff/testportal(loc)
	T.aportalloc = aportalloc
	GLOB.testportals += T
#endif
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/start/adventurerlate
	name = "Adventurerlate"
	icon_state = "arrow"
	jobspawn_override = list("Skeleton", "Pioneer", "Adventurer", "Foreigner")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/banditlate
	name = "Bandit"
	icon_state = "arrow"
	jobspawn_override = list("Bandit")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/bogguardlate
	name = "Bogguardlate"
	icon_state = "arrow"
	jobspawn_override = list("Bog Master", "Bog Guard", "Warden")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/vagrantlate
	name = "Beggarlate"
	icon_state = "arrow"
	jobspawn_override = list("Beggar")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/orphanlate
	name = "Vagabondlate"
	icon_state = "arrow"
	jobspawn_override = list("Vagabond")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/desertriderlate
	name = "DesertRiderlate"
	icon_state = "arrow"
	jobspawn_override = list("Desert Rider Mercenary")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/grenzelhoftlate
	name = "Grenzelhoftlate"
	icon_state = "arrow"
	jobspawn_override = list("Grenzelhoft Mercenary")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/mercenarylate
	name = "Mercenarylate"
	icon_state = "arrow"
	jobspawn_override = list("Mercenary")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/lord
	name = "Grand Duke"
	icon_state = "arrow"

/obj/effect/landmark/start/knight
	name = "Knight"
	icon_state = "arrow"

/obj/effect/landmark/start/sheriff
	name = "Town Sheriff"
	icon_state = "arrow"

/obj/effect/landmark/start/guard_captain
	name = "Knight Captain"
	icon_state = "arrow"

/obj/effect/landmark/start/barkeep
	name = "Barkeep"
	icon_state = "arrow"

/obj/effect/landmark/start/barkeeplate
	name = "Barkeep"
	icon_state = "arrow"
	jobspawn_override = list("Barkeep")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/cook
	name = "Cook"
	icon_state = "arrow"

/obj/effect/landmark/start/steward
	name = "Steward"
	icon_state = "arrow"

/obj/effect/landmark/start/clerk
	name = "Clerk"
	icon_state = "arrow"

/obj/effect/landmark/start/magician
	name = "Court Magician"
	icon_state = "arrow"

/obj/effect/landmark/start/physician
	name = "Court Physician"
	icon_state = "arrow"

/obj/effect/landmark/start/guardsman
	name = "Watchman"
	icon_state = "arrow"

/obj/effect/landmark/start/manorguardsman
	name = "Man at Arms"
	icon_state = "arrow"

/obj/effect/landmark/start/bogmaster
	name = "Bog Master"
	icon_state = "arrow"

/obj/effect/landmark/start/bogguardsman
	name = "Bog Guard"
	icon_state = "arrow"

/obj/effect/landmark/start/marshal
	name = "Marshal"
	icon_state = "arrow"

/obj/effect/landmark/start/councillor
	name = "Councillor"
	icon_state = "arrow"

/obj/effect/landmark/start/veteran
	name = "Veteran"
	icon_state = "arrow"

/obj/effect/landmark/start/dungeoneer
	name = "Dungeoneer"
	icon_state = "arrow"

/obj/effect/landmark/start/watchman
	name = "Gatemaster"
	icon_state = "arrow"

/obj/effect/landmark/start/woodsman
	name = "Town Elder"
	icon_state = "arrow"

/obj/effect/landmark/start/priest
	name = "Priest"
	icon_state = "arrow"

/obj/effect/landmark/start/cleric
	name = "Cleric"
	icon_state = "arrow"

/obj/effect/landmark/start/monk
	name = "Acolyte"
	icon_state = "arrow"

/obj/effect/landmark/start/druid
	name = "Druid"
	icon_state = "arrow"

/obj/effect/landmark/start/templar
	name = "Templar"
	icon_state = "arrow"

/obj/effect/landmark/start/martyr
	name = "Martyr"
	icon_state = "arrow"

/obj/effect/landmark/start/puritan
	name = "Inquisitor"
	icon_state = "arrow"

/obj/effect/landmark/start/orthodoxist
	name = "Orthodoxist"
	icon_state = "arrow"

/obj/effect/landmark/start/sergeant
	name = "Sergeant"
	icon_state = "arrow"

/obj/effect/landmark/start/nightman
	name = "Bathmaster"
	icon_state = "arrow"

/obj/effect/landmark/start/nightmaiden
	name = "Bathhouse Attendant"
	icon_state = "arrow"

/obj/effect/landmark/start/merchant
	name = "Merchant"
	icon_state = "arrow"

/obj/effect/landmark/start/shophand
	name = "Shophand"
	icon_state = "arrow"

/obj/effect/landmark/start/grabber
	name = "Grabber"
	icon_state = "arrow"


/obj/effect/landmark/start/innkeep
	name = "Innkeep"
	icon_state = "arrow"

/obj/effect/landmark/start/archivist
	name = "Archivist"
	icon_state = "arrow"

/obj/effect/landmark/start/guildsman
	name = "Guildsman"
	icon_state = "arrow"

/obj/effect/landmark/start/guildmaster
	name = "Guildmaster"
	icon_state = "arrow"

/obj/effect/landmark/start/tailor
	name = "Tailor"
	icon_state = "arrow"

/obj/effect/landmark/start/alchemist
	name = "Alchemist"
	icon_state = "arrow"

/obj/effect/landmark/start/scribe
	name = "Scribe"
	icon_state = "arrow"

/obj/effect/landmark/start/farmer
	name = "Soilson"
	icon_state = "arrow"

/obj/effect/landmark/start/beastmonger
	name = "Butcher"
	icon_state = "arrow"

/obj/effect/landmark/start/cook
	name = "Cook"
	icon_state = "arrow"

/obj/effect/landmark/start/knavewench
	name = "Tapster"
	icon_state = "arrow"

/obj/effect/landmark/start/gravedigger
	name = "Mortician"
	icon_state = "arrow"

/obj/effect/landmark/start/mercenary
	name = "Mercenary"
	icon_state = "arrow"

/obj/effect/landmark/start/vagrant
	name = "Beggar"
	icon_state = "arrow"

/obj/effect/landmark/start/suitor
	name = "Suitor"
	icon_state = "arrow"

/obj/effect/landmark/start/lady
	name = "Consort"
	icon_state = "arrow"

/obj/effect/landmark/start/prince
	name = "Prince"
	icon_state = "arrow"

/obj/effect/landmark/start/prisonerr
	name = "Prisoner (Azure Keep)"
	icon_state = "arrow"

/obj/effect/landmark/start/prisonerb
	name = "Prisoner (Bog)"
	icon_state = "arrow"

/obj/effect/landmark/start/hostage
	name = "Hostage"
	icon_state = "arrow"

/obj/effect/landmark/start/jester
	name = "Jester"
	icon_state = "arrow"

/obj/effect/landmark/start/hand
	name = "Hand"
	icon_state = "arrow"

/obj/effect/landmark/start/hunter
	name = "Hunter"
	icon_state = "arrow"

/obj/effect/landmark/start/fisher
	name = "Fisher"
	icon_state = "arrow"

/obj/effect/landmark/start/lumberjack
	name = "Lumberjack"
	icon_state = "arrow"

/obj/effect/landmark/start/butler
	name = "Seneschal"
	icon_state = "arrow"

/obj/effect/landmark/start/barkeeper
	name = "Vineyard Keeper"
	icon_state = "arrow"

/obj/effect/landmark/start/barkeeperlate
	name = "Vineyard Keeper"
	icon_state = "arrow"
	jobspawn_override = list("Vineyard Keeper")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/adventurer
	name = "Adventurer"
	icon_state = "arrow"

/obj/effect/landmark/start/courtagent
	name = "Court Agent"
	icon_state = "arrow"

/obj/effect/landmark/start/lunatic
	name = "Lunatic"
	icon_state = "arrow"

//yrf

/obj/effect/landmark/start/squire
	name = "Squire"
	icon_state = "arrow"

/obj/effect/landmark/start/wapprentice
	name = "Magicians Associate"
	icon_state = "arrow"

/obj/effect/landmark/start/apothecary
	name = "Apothecary"
	icon_state = "arrow"

/obj/effect/landmark/start/servant
	name = "Servant"
	icon_state = "arrow"

/obj/effect/landmark/start/churchling
	name = "Churchling"
	icon_state = "arrow"

/obj/effect/landmark/start/orphan
	name = "Vagabond"
	icon_state = "arrow"

/obj/effect/landmark/start/sapprentice
	name = "Smithy Apprentice"
	icon_state = "arrow"

//goblin

/obj/effect/landmark/start/goblinking
	name = "Goblin King"
	icon_state = "arrow"

/obj/effect/landmark/start/goblincook
	name = "Goblin Cook"
	icon_state = "arrow"

/obj/effect/landmark/start/goblinguard
	name = "Goblin Guard"
	icon_state = "arrow"

/obj/effect/landmark/start/goblinsmith
	name = "Goblin Smith"
	icon_state = "arrow"

// t13 spawns

/obj/effect/landmark/start/grandmaster
	name = "Grandmaster"
	icon_state = "arrow"

/obj/effect/landmark/start/grandmasterlate
	name = "Grandmaster"
	icon_state = "arrow"
	jobspawn_override = list("Grandmaster")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/grandknight
	name = "Grand Knight"
	icon_state = "arrow"

/obj/effect/landmark/start/grandknightlate
	name = "Grand Knight"
	icon_state = "arrow"
	jobspawn_override = list("Grand Knight")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/warpriest
	name = "Field Bishop"
	icon_state = "arrow"

/obj/effect/landmark/start/warpriestlate
	name = "Field Bishop"
	icon_state = "arrow"
	jobspawn_override = list("Field Bishop")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/knightcommander
	name = "Knight Commander"
	icon_state = "arrow"

/obj/effect/landmark/start/knightcommanderlate
	name = "Knight Commander"
	icon_state = "arrow"
	jobspawn_override = list("Knight Commander")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/armsman
	name = "Armsman"
	icon_state = "arrow"

/obj/effect/landmark/start/armsmanlate
	name = "Armsman"
	icon_state = "arrow"
	jobspawn_override = list("Armsman")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/jaeger
	name = "Blackguard"
	icon_state = "arrow"

/obj/effect/landmark/start/jaegerlate
	name = "Blackguard"
	icon_state = "arrow"
	jobspawn_override = list("Blackguard")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/rook
	name = "Rook"
	icon_state = "arrow"

/obj/effect/landmark/start/rooklate
	name = "Rook"
	icon_state = "arrow"
	jobspawn_override = list("Rook", "Blackguard")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/ammosquire
	name = "Ammo Squire"
	icon_state = "arrow"

/obj/effect/landmark/start/ammosquirelate
	name = "Ammo Squire"
	icon_state = "arrow"
	jobspawn_override = list("Ammo Squire")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/voltigeur
	name = "Voltigeur"
	icon_state = "arrow"

/obj/effect/landmark/start/voltigeurlate
	name = "Voltigeur"
	icon_state = "arrow"
	jobspawn_override = list("Voltigeur")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/auxiliarist
	name = "Auxiliarist"
	icon_state = "arrow"

/obj/effect/landmark/start/auxiliaristlate
	name = "Auxiliarist"
	icon_state = "arrow"
	jobspawn_override = list("Auxiliarist")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/chirurgeon
	name = "Chirurgeon"
	icon_state = "arrow"

/obj/effect/landmark/start/chirurgeonlate
	name = "Chirurgeon"
	icon_state = "arrow"
	jobspawn_override = list("Chirurgeon", "Magister Enginseer")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/partisan
	name = "Partisan"
	icon_state = "arrow"

/obj/effect/landmark/start/partisanlate
	name = "Partisan"
	icon_state = "arrow"
	jobspawn_override = list("Partisan")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/envoy
	name = "Envoy"
	icon_state = "arrow"

/obj/effect/landmark/start/envoylate
	name = "Envoy"
	icon_state = "arrow"
	jobspawn_override = list("Envoy")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/commandant
	name = "Commandant"
	icon_state = "arrow"

/obj/effect/landmark/start/commandantlate
	name = "Commandant"
	icon_state = "arrow"
	jobspawn_override = list("Commandant")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/oficiro
	name = "Oficiro"
	icon_state = "arrow"

/obj/effect/landmark/start/oficirolate
	name = "Oficiro"
	icon_state = "arrow"
	jobspawn_override = list("Oficiro")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/veterano
	name = "Veterano"
	icon_state = "arrow"

/obj/effect/landmark/start/veteranolate
	name = "Veterano"
	icon_state = "arrow"
	jobspawn_override = list("Veterano")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/soldato
	name = "Soldato"
	icon_state = "arrow"

/obj/effect/landmark/start/soldatolate
	name = "Soldato"
	icon_state = "arrow"
	jobspawn_override = list("Soldato")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/pafanto
	name = "pafanto"
	icon_state = "arrow"

/obj/effect/landmark/start/pafantolate
	name = "Pafanto"
	icon_state = "arrow"
	jobspawn_override = list("Pafanto")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/mulo
	name = "Mulo"
	icon_state = "arrow"

/obj/effect/landmark/start/mulolate
	name = "Mulo"
	icon_state = "arrow"
	jobspawn_override = list("Mulo")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/bastiono
	name = "Bastiono"
	icon_state = "arrow"

/obj/effect/landmark/start/bastionolate
	name = "Bastiono"
	icon_state = "arrow"
	jobspawn_override = list("Bastiono")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/servisto
	name = "Magiisto"
	icon_state = "arrow"

/obj/effect/landmark/start/servistolate
	name = "Magiisto"
	icon_state = "arrow"
	jobspawn_override = list("Magiisto")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/curacisto
	name = "Curacisto"
	icon_state = "arrow"

/obj/effect/landmark/start/curacistolate
	name = "Curacisto"
	icon_state = "arrow"

/obj/effect/landmark/start/curacistolate
	name = "Curacisto"
	icon_state = "arrow"
	jobspawn_override = list("Curacisto", "Dottore Enginseer")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/campfollower
	name = "Camp Follower"
	icon_state = "arrow"

/obj/effect/landmark/start/campfollowerlate
	name = "Camp Follower"
	icon_state = "arrow"
	jobspawn_override = list("Camp Follower")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/consulo
	name = "Consulo"
	icon_state = "arrow"

/obj/effect/landmark/start/consulolate
	name = "Consulo"
	icon_state = "arrow"
	jobspawn_override = list("Consulo")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/kaspafisto
	name = "Kaspafisto"
	icon_state = "arrow"

/obj/effect/landmark/start/kaspafistolate
	name = "Kaspafisto"
	icon_state = "arrow"
	jobspawn_override = list("Kaspafisto")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/hierarch
	name = "Hierarch"
	icon_state = "arrow"

/obj/effect/landmark/start/hierarchlate
	name = "Hierarch"
	icon_state = "arrow"
	jobspawn_override = list("Hierarch")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/bulwark
	name = "Bulwark"
	icon_state = "arrow"

/obj/effect/landmark/start/bulwarklate
	name = "Bulwark"
	icon_state = "arrow"
	jobspawn_override = list("Bulwark")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/provisioner
	name = "Chamberlain"
	icon_state = "arrow"

/obj/effect/landmark/start/provisionerlate
	name = "Chamberlain"
	icon_state = "arrow"
	jobspawn_override = list("Chamberlain")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/mortician
	name = "Mortician"
	icon_state = "arrow"

/obj/effect/landmark/start/morticianlate
	name = "Mortician"
	icon_state = "arrow"
	jobspawn_override = list("Mortician")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/displaced
	name = "Displaced Inheritor"
	icon_state = "arrow"

/obj/effect/landmark/start/displacedlate
	name = "Displaced Inheritor"
	icon_state = "arrow"
	jobspawn_override = list("Displaced Inheritor")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/villager
	name = "Towner"
	icon_state = "arrow"

/obj/effect/landmark/start/villagerlate
	name = "Townerlate"
	icon_state = "arrow"
	jobspawn_override = list("Towner")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/maid
	name = "Manor Servant"
	icon_state = "arrow"

/obj/effect/landmark/start/maidlate
	name = "Manor Servant"
	icon_state = "arrow"
	jobspawn_override = list("Manor Servant")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/headhouse
	name = "Head Housekeeper"
	icon_state = "arrow"

/obj/effect/landmark/start/headhouselate
	name = "Head Housekeeper"
	icon_state = "arrow"
	jobspawn_override = list("Head Housekeeper")
	delete_after_roundstart = FALSE

//Shocktroop spawns

/obj/effect/landmark/start/flamsoldato
	name = "Flamsoldato"
	icon_state = "arrow"

/obj/effect/landmark/start/flamsoldatolate
	name = "Flamsoldato"
	icon_state = "arrow"
	jobspawn_override = list("Flamsoldato")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/radiotrooper
	name = "Radio Officer"
	icon_state = "arrow"

/obj/effect/landmark/start/radiotrooperlate
	name = "Radio Officer"
	icon_state = "arrow"
	jobspawn_override = list("Radio Officer")
	delete_after_roundstart = FALSE

//Hunter Spawns

/obj/effect/landmark/start/huntmaster
	name = "Huntmaster"
	icon_state = "arrow"

/obj/effect/landmark/start/huntmasterlate
	name = "Huntmaster"
	icon_state = "arrow"
	jobspawn_override = list("Huntmaster")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/hedgeborn
	name = "Hedgeborn"
	icon_state = "arrow"

/obj/effect/landmark/start/hedgebornlate
	name = "Hedgeborn"
	icon_state = "arrow"
	jobspawn_override = list("Hedgeborn")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/huntsteward
	name = "Huntsteward"
	icon_state = "arrow"

/obj/effect/landmark/start/huntstewardlate
	name = "Huntsteward"
	icon_state = "arrow"
	jobspawn_override = list("Huntsteward")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/mountebank
	name = "Mountebank"
	icon_state = "arrow"

/obj/effect/landmark/start/mountebanklate
	name = "Mountebank"
	icon_state = "arrow"
	jobspawn_override = list("Mountebank")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/huntsman
	name = "Huntsman"
	icon_state = "arrow"

/obj/effect/landmark/start/huntsmanlate
	name = "Huntsman"
	icon_state = "arrow"
	jobspawn_override = list("Huntsman")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/perconscript
	name = "Perserdunian Conscript"
	icon_state = "arrow"

/obj/effect/landmark/start/perconscriptlate
	name = "Perserdunian Conscript"
	icon_state = "arrow"
	jobspawn_override = list("Perserdunian Conscript")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/risconscript
	name = "Risvonian Conscript"
	icon_state = "arrow"

/obj/effect/landmark/start/risconscriptlate
	name = "Risvonian Conscript"
	icon_state = "arrow"
	jobspawn_override = list("Risvonian Conscript")
	delete_after_roundstart = FALSE

//Vos Arderla Spawns

/obj/effect/landmark/start/rebelleader
	name = "Rebel Leader"
	icon_state = "arrow"

/obj/effect/landmark/start/rebelleaderlate
	name = "Rebel Leader"
	icon_state = "arrow"
	jobspawn_override = list("Rebel Leader")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/farmerrebel
	name = "Rebel Farmer"
	icon_state = "arrow"

/obj/effect/landmark/start/farmerrebellate
	name = "Rebel Farmer"
	icon_state = "arrow"
	jobspawn_override = list("Rebel Farmer")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/smithyrebel
	name = "Rebel Smithy"
	icon_state = "arrow"

/obj/effect/landmark/start/smithyrebellate
	name = "Rebel Smithy"
	icon_state = "arrow"
	jobspawn_override = list("Rebel Smithy")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/lumberjackrebel
	name = "Rebel Lumberjack"
	icon_state = "arrow"

/obj/effect/landmark/start/lumberjackrebellate
	name = "Rebel Lumberjack"
	icon_state = "arrow"
	jobspawn_override = list("Rebel Lumberjack")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/veterinarianrebel
	name = "Rebel Veterinarian"
	icon_state = "arrow"

/obj/effect/landmark/start/veterinarianrebellate
	name = "Rebel Veterinarian"
	icon_state = "arrow"
	jobspawn_override = list("Rebel Veterinarian")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/officerrebel
	name = "Rebel Office Worker"
	icon_state = "arrow"

/obj/effect/landmark/start/officerrebellate
	name = "Rebel Office Worker"
	icon_state = "arrow"
	jobspawn_override = list("Rebel Office Worker")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/tailorrebel
	name = "Rebel Tailor"
	icon_state = "arrow"

/obj/effect/landmark/start/tailorrebellate
	name = "Rebel Tailor"
	icon_state = "arrow"
	jobspawn_override = list("Rebel Tailor")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/cookrebel
	name = "Rebel Cook"
	icon_state = "arrow"

/obj/effect/landmark/start/cookrebellate
	name = "Rebel Cook"
	icon_state = "arrow"
	jobspawn_override = list("Rebel Cook")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/hunterrebel
	name = "Rebel Hunter"
	icon_state = "arrow"

/obj/effect/landmark/start/hunterrebellate
	name = "Rebel Hunter"
	icon_state = "arrow"
	jobspawn_override = list("Rebel Hunter")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/minerrebel
	name = "Rebel Miner"
	icon_state = "arrow"

/obj/effect/landmark/start/minerrebellate
	name = "Rebel Miner"
	icon_state = "arrow"
	jobspawn_override = list("Rebel Miner")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/butcherrebel
	name = "Rebel Butcher"
	icon_state = "arrow"

/obj/effect/landmark/start/butcherrebellate
	name = "Rebel Butcher"
	icon_state = "arrow"
	jobspawn_override = list("Rebel Butcher")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/vagrantrebel
	name = "Rebel Vagrant"
	icon_state = "arrow"

/obj/effect/landmark/start/vagrantrebellate
	name = "Rebel Vagrant"
	icon_state = "arrow"
	jobspawn_override = list("Rebel Vagrant")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/veteranrebel
	name = "Rebel Veteran"
	icon_state = "arrow"

/obj/effect/landmark/start/veteranrebellate
	name = "Rebel Veteran"
	icon_state = "arrow"
	jobspawn_override = list("Rebel Veteran")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/protectorate
	name = "Protectorate Guardsman"
	icon_state = "arrow"

/obj/effect/landmark/start/protectoralate
	name = "Protectorate Guardsman"
	icon_state = "arrow"
	jobspawn_override = list("Protectorate Guardsman")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/suppressionist
	name = "Protectorate Triumverate"
	icon_state = "arrow"

/obj/effect/landmark/start/suppressionistlate
	name = "Protectorate Triumverate"
	icon_state = "arrow"
	jobspawn_override = list("Protectorate Triumverate")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/sterilizer
	name = "Protectorate Sterilizer"
	icon_state = "arrow"

/obj/effect/landmark/start/sterilizerlate
	name = "Protectorate Sterilizer"
	icon_state = "arrow"
	jobspawn_override = list("Protectorate Sterilizer")
	delete_after_roundstart = FALSE

//Antagonist spawns

/obj/effect/landmark/start/wizard
	name = "wizard"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "wiznerd_spawn"

/obj/effect/landmark/start/wizard/Initialize()
	. = ..()
	GLOB.wizardstart += loc

/obj/effect/landmark/start/nukeop
	name = "nukeop"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "snukeop_spawn"

/obj/effect/landmark/start/nukeop/Initialize()
	. = ..()
	GLOB.nukeop_start += loc

/obj/effect/landmark/start/bandit
	name = "bandit"
	icon = 'icons/mob/landmarks.dmi'
	icon_state = "arrow"
	jobspawn_override = list("Bandit")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/bandit/Initialize()
	. = ..()
	GLOB.bandit_starts += loc


/obj/effect/landmark/start/delf
	name = "delf"
	icon = 'icons/mob/landmarks.dmi'
	icon_state = "arrow"

/obj/effect/landmark/start/delf/Initialize()
	. = ..()
	GLOB.delf_starts += loc

/obj/effect/landmark/start/wretch
	name = "wretch"
	icon_state = "arrow"
	jobspawn_override = list("Wretch")

/obj/effect/landmark/start/wretchlate
	name = "wretch"
	icon_state = "arrow"
	delete_after_roundstart = FALSE
	jobspawn_override = list("Wretch")

/obj/effect/landmark/start/nukeop_leader
	name = "nukeop leader"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "snukeop_leader_spawn"

/obj/effect/landmark/start/nukeop_leader/Initialize()
	. = ..()
	GLOB.nukeop_leader_start += loc

// Must be immediate because players will
// join before SSatom initializes everything.
INITIALIZE_IMMEDIATE(/obj/effect/landmark/start/new_player)

/obj/effect/landmark/start/new_player
	name = "New Player"

/obj/effect/landmark/start/new_player/Initialize()
	. = ..()
	GLOB.newplayer_start += loc

/obj/effect/landmark/latejoin
	name = "JoinLate"

/obj/effect/landmark/latejoin/Initialize(mapload)
	..()
	SSjob.latejoin_trackers += loc
	return INITIALIZE_HINT_QDEL

//space carps, magicarps, lone ops, slaughter demons, possibly revenants spawn here
/obj/effect/landmark/carpspawn
	name = "carpspawn"
	icon_state = "carp_spawn"

//observer start
/obj/effect/landmark/observer_start
	name = "Observer-Start"
	icon_state = "x"

//objects with the stationloving component (nuke disk) respawn here.
//also blobs that have their spawn forcemoved (running out of time when picking their spawn spot), santa and respawning devils
/obj/effect/landmark/blobstart
	name = "blobstart"
	icon_state = "blob_start"

/obj/effect/landmark/blobstart/Initialize(mapload)
	..()
	GLOB.blobstart += loc
	return INITIALIZE_HINT_QDEL

//spawns sec equipment lockers depending on the number of sec officers
/obj/effect/landmark/secequipment
	name = "secequipment"
	icon_state = "secequipment"

/obj/effect/landmark/secequipment/Initialize(mapload)
	..()
	GLOB.secequipment += loc
	return INITIALIZE_HINT_QDEL

//players that get put in admin jail show up here
/obj/effect/landmark/prisonwarp
	name = "prisonwarp"
	icon_state = "prisonwarp"

/obj/effect/landmark/prisonwarp/Initialize(mapload)
	..()
	GLOB.prisonwarp += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/ert_spawn
	name = "Emergencyresponseteam"
	icon_state = "ert_spawn"

/obj/effect/landmark/ert_spawn/Initialize(mapload)
	..()
	GLOB.emergencyresponseteamspawn += loc
	return INITIALIZE_HINT_QDEL

//ninja energy nets teleport victims here
/obj/effect/landmark/holding_facility
	name = "Holding Facility"
	icon_state = "holding_facility"

/obj/effect/landmark/holding_facility/Initialize(mapload)
	..()
	GLOB.holdingfacility += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/thunderdome/observe
	name = "tdomeobserve"
	icon_state = "tdome_observer"

/obj/effect/landmark/thunderdome/observe/Initialize(mapload)
	..()
	GLOB.tdomeobserve += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/thunderdome/one
	name = "tdome1"
	icon_state = "tdome_t1"

/obj/effect/landmark/thunderdome/one/Initialize(mapload)
	..()
	GLOB.tdome1	+= loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/thunderdome/two
	name = "tdome2"
	icon_state = "tdome_t2"

/obj/effect/landmark/thunderdome/two/Initialize(mapload)
	..()
	GLOB.tdome2 += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/thunderdome/admin
	name = "tdomeadmin"
	icon_state = "tdome_admin"

/obj/effect/landmark/thunderdome/admin/Initialize(mapload)
	..()
	GLOB.tdomeadmin += loc
	return INITIALIZE_HINT_QDEL

//generic event spawns
/obj/effect/landmark/event_spawn
	name = "generic event spawn"
	icon_state = "generic_event"
	layer = HIGH_LANDMARK_LAYER


/obj/effect/landmark/event_spawn/New()
	..()
	GLOB.generic_event_spawns += src

/obj/effect/landmark/event_spawn/Destroy()
	GLOB.generic_event_spawns -= src
	return ..()

/obj/effect/landmark/ruin
	var/datum/map_template/ruin/ruin_template

/obj/effect/landmark/ruin/New(loc, my_ruin_template)
	name = "ruin_[GLOB.ruin_landmarks.len + 1]"
	..(loc)
	ruin_template = my_ruin_template
	GLOB.ruin_landmarks |= src

/obj/effect/landmark/ruin/Destroy()
	GLOB.ruin_landmarks -= src
	ruin_template = null
	. = ..()

/// Marks the bottom left of the testing zone.
/// In landmarks.dm and not unit_test.dm so it is always active in the mapping tools.
/obj/effect/landmark/unit_test_bottom_left
	name = "unit test zone bottom left"

/// Marks the top right of the testing zone.
/// In landmarks.dm and not unit_test.dm so it is always active in the mapping tools.
/obj/effect/landmark/unit_test_top_right
	name = "unit test zone top right"

//Underworld landmark

/obj/effect/landmark/underworld
	name = "underworld spawn"

/obj/effect/landmark/underworldcoin
	name = "ferryman coin"

/obj/effect/landmark/underworldsafe
	name = "safe zone"

GLOBAL_LIST_EMPTY(travel_tile_locations)

/obj/effect/landmark/travel_tile_location
	name = "travel tile location"

/obj/effect/landmark/travel_tile_location/Initialize()
	. = ..()
	GLOB.travel_tile_locations += src

/obj/effect/landmark/travel_tile_location/Destroy()
	GLOB.travel_tile_locations -= src
	. = ..()

GLOBAL_LIST_EMPTY(travel_spawn_points)

/obj/effect/landmark/travel_spawn_point
	name = "travel spawn point"
	icon_state = "generic_event"
	var/taken = FALSE

/obj/effect/landmark/travel_spawn_point/Initialize()
	. = ..()
	GLOB.travel_spawn_points += src

/obj/effect/landmark/travel_spawn_point/Destroy()
	GLOB.travel_spawn_points -= src
	. = ..()

/proc/get_free_travel_spawn_point()
	var/list/shuffled = shuffle(GLOB.travel_spawn_points)
	for(var/obj/effect/landmark/travel_spawn_point/point as anything in shuffled)
		if(point.taken)
			continue
		point.taken = TRUE
		return point.loc
	return null

/proc/create_travel_tiles(var/atom/location, travel_id, travel_goes_to_id, required_trait)
	for(var/obj/effect/landmark/travel_tile_location/landmark as anything in GLOB.travel_tile_locations)
		if(get_dist(location, landmark) > 5)
			continue
		// Create travel tile here
		var/obj/structure/fluff/traveltile/tile = new /obj/structure/fluff/traveltile(landmark.loc)
		tile.aportalid = travel_id
		tile.aportalgoesto = travel_goes_to_id
		tile.required_trait = required_trait
