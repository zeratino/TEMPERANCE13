/*
			< ATTENTION >
	If you need to add more map_adjustment, check 'map_adjustment_include.dm'
	These 'map_adjustment.dm' files shouldn't be included in 'dme'
*/

/datum/map_adjustment/jrsbar
	map_file_name = "jrsbar.dmm"
	realm_name = "Juniors Bar"
	slot_adjust = list(
		/datum/job/roguetown/huntmaster = 1,
		/datum/job/roguetown/hedgeborn = 1,
		/datum/job/roguetown/huntsteward = 2,
		/datum/job/roguetown/mountebank = 3,
		/datum/job/roguetown/huntsman = 10,
		/datum/job/roguetown/deadite = 100
	)
	title_adjust = list(
		/datum/job/roguetown/barkeep = list(display_title = "Tavern Keeper")
	)
	tutorial_adjust = list(
		/datum/job/roguetown/barkeep = "A band of hunters strolled in at dusk, and now they've brought hoards of undead with them! Fuck!"
	)
	blacklist = list(
		/datum/job/roguetown/adventurer,
		/datum/job/roguetown/pilgrim,
		/datum/job/roguetown/hierarch,
		/datum/job/roguetown/merchant,
		/datum/job/roguetown/bulwark,
		/datum/job/roguetown/displacedhier,
		/datum/job/roguetown/housekeeper,
		/datum/job/roguetown/manorservant,
		/datum/job/roguetown/provisioner,
		/datum/job/roguetown/mortician,
		/datum/job/roguetown/ammosquire,
		/datum/job/roguetown/armsman,
		/datum/job/roguetown/auxiliarist,
		/datum/job/roguetown/blackguard,
		/datum/job/roguetown/chirurgeon,
		/datum/job/roguetown/envoy,
		/datum/job/roguetown/grandknight,
		/datum/job/roguetown/grandmaster,
		/datum/job/roguetown/knightcommander,
		/datum/job/roguetown/partisan,
		/datum/job/roguetown/rook,
		/datum/job/roguetown/voltigeur,
		/datum/job/roguetown/warpriest,
		/datum/job/roguetown/campfollower,
		/datum/job/roguetown/commandant,
		/datum/job/roguetown/dottore,
		/datum/job/roguetown/magister,
		/datum/job/roguetown/consulo,
		/datum/job/roguetown/curacisto,
		/datum/job/roguetown/kaspafisto,
		/datum/job/roguetown/mulo,
		/datum/job/roguetown/oficiro,
		/datum/job/roguetown/pafanto,
		/datum/job/roguetown/servisto,
		/datum/job/roguetown/soldato,
		/datum/job/roguetown/tuoro,
		/datum/job/roguetown/veterano,
		/datum/job/roguetown/risvonconscript,
		/datum/job/roguetown/perserconscript
	)
