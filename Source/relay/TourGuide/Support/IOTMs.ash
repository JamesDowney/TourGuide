import "relay/TourGuide/Support/Campground.ash"

boolean [item] __iotms_usable;

void replicaCheck(string iotmName) {
    // helper function for checking ownership of either the item or the 
    //   legacy of loathing replica of said item

    amountItem = lookupItem(iotmName).available_amount();
    amountReplica = lookupItem("replica "+iotmName).available_amount();

    if (amountItem + amountReplica) > 0:
        __iotms_usable[lookupItem(iotmName)] = true;
    else: 
        __iotms_usable[lookupItem(iotmName)] = false;
}

void initialiseIOTMsUsable()
{
    foreach key in __iotms_usable
        remove __iotms_usable[key];

    if (in_bad_moon())
        return;
    
    // ... for futureproofing, we should probably just make a thing in the library that explicitly denotes no-campground paths
    //   and incorporate them here. Not really sure why ezan didn't, it's possible mafia tracking is just uniquely wrong in ed?

    if (my_path().id != PATH_ACTUALLY_ED_THE_UNDYING)
    {
        //Campground items:
        foreach it in $items[source terminal, haunted doghouse, Witchess Set, potted tea tree, portable mayo clinic, Little Geneticist DNA-Splicing Lab, cornucopia]
        {
            if (__campground[it] > 0)
                __iotms_usable[it] = true;
        }
        // Workshed
        if (__campground[lookupItem("Asdon Martin keyfob")] > 0)
            __iotms_usable[lookupItem("Asdon Martin keyfob")] = true;
        if (__campground[lookupItem("diabolic pizza cube")] > 0)
            __iotms_usable[lookupItem("diabolic pizza cube")] = true;
        if (__campground[lookupItem("cold medicine cabinet")] > 0)
            __iotms_usable[lookupItem("cold medicine cabinet")] = true;
        if (__campground[lookupItem("model train set")] > 0)
            __iotms_usable[lookupItem("model train set")] = true;

        // __iotms_usable for gardens tracks whether the user has the garden installed.
        // Gardens start returning 0 instead of 1 when the items are picked, so checking
        // presence of the key is more useful than checking the value.
        foreach garden in $items[packet of mushroom spores, packet of rock seeds]
        {
            if (__campground contains garden)
                __iotms_usable[garden] = true;
        }
    }
    if (florist_available() && $item[hand turkey outline].is_unrestricted()) //May 2013
        //Order of the Green Thumb Order Form is not marked as out of standard.
        __iotms_usable[$item[Order of the Green Thumb Order Form]] = true; 
    if (get_property_boolean("sleazeAirportAlways") || get_property_boolean("_sleazeAirportToday")) //May 2014
        __iotms_usable[$item[airplane charter: Spring Break Beach]] = true;
    if (get_property_boolean("spookyAirportAlways") || get_property_boolean("_spookyAirportToday")) //Oct 2014
        __iotms_usable[$item[airplane charter: Conspiracy Island]] = true;
    if (get_property_boolean("chateauAvailable")) //Jan 2015
        __iotms_usable[$item[Chateau Mantegna room key]] = true;
    if (get_property_boolean("lovebugsUnlocked") && $item[hand turkey outline].is_unrestricted()) //Feb 2015
        __iotms_usable[$item[bottle of lovebug pheromones]] = true;
    if (get_property_boolean("stenchAirportAlways") || get_property_boolean("_stenchAirportToday")) //Apr 2015
        __iotms_usable[$item[airplane charter: Dinseylandfill]] = true;
    // if (lookupItem("Deck of Every Card").available_amount() > 0) //Jul 2015
    //     __iotms_usable[$item[Deck of Every Card]] = true;
    if (get_property_boolean("hotAirportAlways") || get_property_boolean("_hotAirportToday")) //Aug 2015
        __iotms_usable[$item[Airplane charter: That 70s Volcano]] = true;
    if (get_property_boolean("barrelShrineUnlocked")) //Sep 2015
        __iotms_usable[$item[shrine to the Barrel god]] = true;
    if (get_property_boolean("coldAirportAlways") || get_property_boolean("_coldAirportToday")) //Nov 2015
        __iotms_usable[$item[Airplane charter: The Glaciest]] = true;
    if (get_property_boolean("snojoAvailable")) //Jan 2016
        __iotms_usable[$item[X-32-F snowman crate]] = true;
    if (get_property_boolean("telegraphOfficeAvailable")) //Feb 2016
        __iotms_usable[$item[LT&T telegraph office deed]] = true;
    if (get_property_boolean("hasDetectiveSchool")) //Jul 2016
        __iotms_usable[$item[detective school application]] = true;
    if (lookupItem("protonic accelerator pack").available_amount() > 0) //Aug 2016
        __iotms_usable[lookupItem("protonic accelerator pack")] = true;   
    if (lookupItem("Time-Spinner").available_amount() > 0) //Sep 2016
        __iotms_usable[lookupItem("Time-Spinner")] = true;        
    if (get_property_boolean("gingerbreadCityAvailable") || get_property_boolean("_gingerbreadCityToday")) //Dec 2016
        __iotms_usable[$item[Build-a-City Gingerbread kit]] = true;
    if (get_property_boolean("loveTunnelAvailable")) //Feb 2017
        __iotms_usable[lookupItem("heart-shaped crate")] = true;
    if (get_property_boolean("spacegateAlways") || get_property_boolean("_spacegateToday")) //Apr 2017
        __iotms_usable[lookupItem("Spacegate access badge")] = true;
    if (lookupItem("kremlin's greatest briefcase").available_amount() > 0) //Jun 2017
        __iotms_usable[lookupItem("kremlin's greatest briefcase")] = true;
    if (get_property_boolean("horseryAvailable")) //Aug 2017-18
        __iotms_usable[lookupItem("Horsery contract")] = true;
    // if (lookupItem("genie bottle").available_amount() > 0) //Sep 2017
    //     __iotms_usable[lookupItem("genie bottle")] = true;
    if (lookupItem("portable pantogram").available_amount() > 0) //Nov 2017
        __iotms_usable[lookupItem("portable pantogram")] = true;
    // if (lookupItem("January's Garbage Tote").available_amount() > 0) //Jan 2018
    //     __iotms_usable[lookupItem("January's Garbage Tote")] = true;
    if (get_property_boolean("_frToday") || get_property_boolean("frAlways")) //Apr 2018
        __iotms_usable[lookupItem("FantasyRealm membership packet")] = true;
    if (get_property_boolean("_neverendingPartyToday") || get_property_boolean("neverendingPartyAlways")) //Sep 2018
        __iotms_usable[lookupItem("Neverending Party invitation envelope")] = true;
    if (lookupItem("latte lovers member's mug").available_amount() > 0) //Oct 2018
        __iotms_usable[lookupItem("latte lovers member's mug")] = true;
    if (get_property_boolean("_voteToday") || get_property_boolean("voteAlways") || lookupItem("&quot;I Voted!&quot; sticker").available_amount() > 0) //Nov 2018
        __iotms_usable[lookupItem("voter registration form")] = true;
    if (get_property_boolean("daycareOpen")) //Dec 2018
        __iotms_usable[lookupItem("Boxing Day care package")] = true;
    if (lookupItem("vampyric cloake").available_amount() > 0) //Mar 2019
        __iotms_usable[lookupItem("vampyric cloake")] = true;
    // if (lookupItem("Fourth of May Cosplay Saber").available_amount() > 0) //May 2019
    //     __iotms_usable[lookupItem("Fourth of May Cosplay Saber")] = true;    
    // if (lookupItem("hewn moon-rune spoon").available_amount() > 0) //Jun 2019
    //     __iotms_usable[lookupItem("hewn moon-rune spoon")] = true; 
    if (get_property_boolean("getawayCampsiteUnlocked")) //Aug 2019
        __iotms_usable[lookupItem("Distant Woods Getaway Brochure")] = true;
    if (lookupItem("Eight Days a Week Pill Keeper").available_amount() > 0) //Oct 2019
        __iotms_usable[lookupItem("Eight Days a Week Pill Keeper")] = true;
    if (lookupItem("Bird-a-Day calendar").available_amount() > 0) //Jan 2020
        __iotms_usable[lookupItem("Bird-a-Day calendar")] = true;
    if (lookupItem("unwrapped knock-off retro superhero cape").available_amount() > 0) //Nov 2020
        __iotms_usable[lookupItem("unwrapped knock-off retro superhero cape")] = true;
    if (lookupItem("Potted power plant").available_amount() > 0) //Mar 2021
        __iotms_usable[lookupItem("Potted power plant")] = true;
    if (lookupItem("cosmic bowling ball").available_amount() > 0 || get_property_int("_cosmicBowlingSkillsUsed") > 0) //Jan 2022
        // change to use tracking property if/when mafia adds one from coolitems.php
        __iotms_usable[lookupItem("cosmic bowling ball")] = true;
    if (lookupItem("unbreakable umbrella").available_amount() > 0) //Mar 2021
        __iotms_usable[lookupItem("unbreakable umbrella")] = true;
    if ($item[Clan VIP Lounge key].item_amount() > 0)
    {
    	//FIXME all
        __iotms_usable[lookupItem("Clan Carnival Game")] = true;
        __iotms_usable[$item[clan floundry]] = true;
    }
    //Can't use many things in G-Lover
    if (my_path().id == PATH_G_LOVER) //Path 33
    {
        __iotms_usable[lookupItem("Bird-a-Day calendar")] = false;
        __iotms_usable[lookupItem("Deck of Every Card")] = false;
        __iotms_usable[lookupItem("Fourth of May Cosplay Saber")] = false;
        __iotms_usable[lookupItem("hewn moon-rune spoon")] = false;
        __iotms_usable[lookupItem("Potted power plant")] = false;
        __iotms_usable[lookupItem("protonic accelerator pack")] = false;        
        __iotms_usable[lookupItem("Time-Spinner")] = false;
        __iotms_usable[lookupItem("unbreakable umbrella")] = false;
        __iotms_usable[lookupItem("Underground Fireworks Shop")] = false; //can't use any items here
        __iotms_usable[lookupItem("unwrapped knock-off retro superhero cape")] = false;        
        __iotms_usable[lookupItem("vampyric cloake")] = false;
    }
    if (my_path().id == PATH_EXPLOSIONS) //Path 37
    {
        __iotms_usable[lookupItem("Spacegate access badge")] = false;
    }

    // Legacy of Loathing introduced a whole host of replica IOTMs. In order 
    //   to properly support LoL, it was decided that the easiest way to work
    //   this is to reinstitute __iotms_usable for the last few years of IOTMs 
    //   and make it so that ownership of the replica flags as ownership of the
    //   real deal. Alternative would've been to make every item check a boolean
    //   that checks ownership of either/or, and this feels... less bad, to me.

    // One note -- familiars are the same as the real deal, so they don't need 
    //   checks (I don't think?). This only applies for items explicitly formatted
    //   as "replica [itemname]". Another note -- we did not add a path check here,
    //   mostly owing to the fact that the replicaCheck function also works for 
    //   the real iotms, which means it'll properly populate __iotms_usable...
    //   even outside of LoL. 

    // 2005
    replicaCheck("miniature gravy-covered maypole");
    replicaCheck("wax lips");

    // 2006 
    replicaCheck("Tome of Snowcone Summoning");
    replicaCheck("jewel-eyed wizard hat");
    replicaCheck("plastic pumpkin bucket");

    // 2007
    replicaCheck("V for Vivala mask");
    replicaCheck("navel ring of navel gazing");
    replicaCheck("bottle-rocket crossbow");

    // 2008
    replicaCheck("little box of fireworks");
    replicaCheck("haiku katana");

    // 2009
    replicaCheck("Elvish Sunglasses");

    // 2010
    replicaCheck("Juju Mojo Mask");
    replicaCheck("Greatest American Pants");

    // 2011
    replicaCheck("Operation Patriot Shield");
    replicaCheck("plastic vampire fangs");

    // 2012
    replicaCheck("Libram of Resolutions");
    replicaCheck("Camp Scout backpack");

    // 2013
    replicaCheck("over-the-shoulder Folder Holder");
    replicaCheck("Smith's Tome");

    // 2014
    replicaCheck("Little Geneticist DNA-Splicing Lab");

    // 2015
    if (get_property_boolean("replicaChateauAvailable")):
        __iotms_usable[$item[Chateau Mantegna room key]] = true;
    replicaCheck("Deck of Every Card");

    // 2016
    if (get_property_boolean("replicaWitchessSetAvailable")):
        __iotms_usable[$item[Witchess Set]] = true;
    replicaCheck("Source terminal");

    // 2017
    replicaCheck("genie bottle");

    // 2018
    replicaCheck("January's Garbage Tote");
    if (get_property_boolean("replicaNeverendingPartyAlways")):
        __iotms_usable[$item[Neverending Party invitation envelope]] = true;

    // 2019
    replicaCheck("Kramco Sausage-o-Matic");
    replicaCheck("Fourth of May Cosplay Saber");
    replicaCheck("hewn moon-rune spoon");

    // 2020
    replicaCheck("Powerful Glove");
    replicaCheck("Cargo Cultist Shorts");
    
    // 2021
    replicaCheck("miniature crystal ball");
    replicaCheck("emotion chip");
    replicaCheck("industrial fire extinguisher");

    // 2022
    replicaCheck("designer sweatpants");
    replicaCheck("Jurassic Parka");

    // 2023
    replicaCheck("Cincho de Mayo");
    replicaCheck("2002 Mr. Store Catalog");

    //Remove non-standard:
    foreach it in __iotms_usable
    {
        if (!it.is_unrestricted() || it == $item[none])
            remove __iotms_usable[it];
    }
}

initialiseIOTMsUsable();
