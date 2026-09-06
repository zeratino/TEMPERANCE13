/*
			< ATTENTION >
	If you need to add more map_adjustment, check 'map_adjustment_include.dm'
	These 'map_adjustment.dm' files shouldn't be included in 'dme'
*/

/datum/map_adjustment/vosarderla
	map_file_name = "vosarderla.dmm"
	realm_name = "Vos Arderla"
	slot_adjust = list(
		/datum/job/roguetown/armsman = 20,
		/datum/job/roguetown/soldato = 20,
		/datum/job/roguetown/commandant = 1,
		/datum/job/roguetown/grandmaster = 1
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
		/datum/job/roguetown/auxiliarist,
		/datum/job/roguetown/blackguard,
		/datum/job/roguetown/chirurgeon,
		/datum/job/roguetown/envoy,
		/datum/job/roguetown/grandknight,
		/datum/job/roguetown/knightcommander,
		/datum/job/roguetown/partisan,
		/datum/job/roguetown/rook,
		/datum/job/roguetown/voltigeur,
		/datum/job/roguetown/warpriest,
		/datum/job/roguetown/campfollower,
		/datum/job/roguetown/dottore,
		/datum/job/roguetown/magister,
		/datum/job/roguetown/consulo,
		/datum/job/roguetown/curacisto,
		/datum/job/roguetown/kaspafisto,
		/datum/job/roguetown/mulo,
		/datum/job/roguetown/oficiro,
		/datum/job/roguetown/pafanto,
		/datum/job/roguetown/servisto,
		/datum/job/roguetown/tuoro,
		/datum/job/roguetown/veterano,
		/datum/job/roguetown/huntmaster,
		/datum/job/roguetown/hedgeborn,
		/datum/job/roguetown/huntsteward,
		/datum/job/roguetown/mountebank,
		/datum/job/roguetown/huntsman,
		/datum/job/roguetown/deadite,
		/datum/job/roguetown/barkeep
	)
