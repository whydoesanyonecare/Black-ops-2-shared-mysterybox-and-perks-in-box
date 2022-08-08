#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm_magicbox;
#include maps/mp/zombies/_zm;
#include maps/mp/zombies/_zm_unitrigger;
#include maps/mp/zombies/_zm_utility;
init()
{
	if(getdvar( "mapname" ) == "zm_tomb" )
    	thread monitor_boxes();
    else
        thread CheckForCurrentBox();

    level.shared_box = 0;
    add_zombie_hint( "default_shared_box", "Hold ^3&&1^7 for weapon");
    level.perks_in_box_enabled = getdvarintdefault("perks_in_box", 1);
    flag_wait( "initial_blackscreen_passed" );
    thread setperklimit();
}

monitor_boxes()
{
	flag_wait( "initial_blackscreen_passed" );
    wait 10;
    for(i = 0; i < level.chests.size; i++)
    {
        level.chests[ i ] thread reset_box();		
	}
    for(;;)
    {
        for(i = 0; i < level.chests.size; i++)
        {
            if(!level.chests[ i ].hidden)
            {
                level.chests[ i ].unitrigger_stub.prompt_and_visibility_func = ::boxtrigger_update_prompt;
                level.chests[ i ].zbarrier waittill( "left" );
                //iPrintLn("left");
            }
        }
        wait 15;
        //iPrintLn("15");
	}
}

setperklimit()
{
    level endon("end_game");
    for(;;)
    {
        set_perk_limit(getdvar("mapname"));
        level waittill("connected", player);
    }
}

set_perk_limit(map)
{
    if ( !isDefined( map ) )
	{
		return 0;
	}
    switch(map)
    {
        case "zm_transit":
            if(get_players().size > 1)
            {
                limit = 6;
            }
            else
            {
                limit = 5;
            }
            break;
        case "zm_prison":
            limit = 5;
            break;
        case "zm_nuked":
            limit = 4;
            break;
        case "zm_tomb":
            limit = 9;
            break;
        case "zm_buried":
            limit = 7;
            break;
        case "zm_highrise":
            limit = 6;
            break;
    }
    level.perk_purchase_limit = limit;
}

CheckForCurrentBox()
{
	flag_wait( "initial_blackscreen_passed" );
    if( getdvar( "mapname" ) == "zm_nuked" || getdvar( "mapname" ) == "zm_tomb" )
    {
        wait 10;
    }
    for(i = 0; i < level.chests.size; i++)
    {
        level.chests[ i ] thread reset_box();
		if(level.chests[ i ].hidden)
    	{
			level.chests[ i ] get_chest_pieces();
    	}
		if(!level.chests[ i ].hidden)
		{
			level.chests[ i ].unitrigger_stub.prompt_and_visibility_func = ::boxtrigger_update_prompt;
		}
	}
}

reset_box()
{
	self notify("kill_chest_think");
    wait .1;
	if(!self.hidden)
    {
		self.grab_weapon_hint = 0;
		self thread maps/mp/zombies/_zm_unitrigger::register_static_unitrigger( self.unitrigger_stub, ::magicbox_unitrigger_think );
    	self.unitrigger_stub run_visibility_function_for_all_triggers();
	}
	self thread custom_treasure_chest_think();
}

get_chest_pieces()
{
	self.chest_box = getent( self.script_noteworthy + "_zbarrier", "script_noteworthy" );
	self.chest_rubble = [];
	rubble = getentarray( self.script_noteworthy + "_rubble", "script_noteworthy" );
	i = 0;
	while ( i < rubble.size )
	{
		if ( distancesquared( self.origin, rubble[ i ].origin ) < 10000 )
		{
			self.chest_rubble[ self.chest_rubble.size ] = rubble[ i ];
		}
		i++;
	}
	self.zbarrier = getent( self.script_noteworthy + "_zbarrier", "script_noteworthy" );
	if ( isDefined( self.zbarrier ) )
	{
		self.zbarrier zbarrierpieceuseboxriselogic( 3 );
		self.zbarrier zbarrierpieceuseboxriselogic( 4 );
	}
	self.unitrigger_stub = spawnstruct();
	self.unitrigger_stub.origin = self.origin + ( anglesToRight( self.angles ) * -22.5 );
	self.unitrigger_stub.angles = self.angles;
	self.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
	self.unitrigger_stub.script_width = 104;
	self.unitrigger_stub.script_height = 50;
	self.unitrigger_stub.script_length = 45;
	self.unitrigger_stub.trigger_target = self;
	unitrigger_force_per_player_triggers( self.unitrigger_stub, 1 );
	self.unitrigger_stub.prompt_and_visibility_func = ::boxtrigger_update_prompt;
	self.zbarrier.owner = self;
}

boxtrigger_update_prompt( player )
{
	can_use = self custom_boxstub_update_prompt( player );
	if ( isDefined( self.hint_string ) )
	{
		if ( isDefined( self.hint_parm1 ) )
		{
			self sethintstring( self.hint_string, self.hint_parm1 );
		}
		else
		{
			self sethintstring( self.hint_string );
		}
	}
	return can_use;
}

custom_boxstub_update_prompt( player )
{
    self setcursorhint( "HINT_NOICON" );
    if(!self trigger_visible_to_player( player ))
    {
        if(level.shared_box)
        {
            self setvisibletoplayer( player );
            self.hint_string = get_hint_string( self, "default_shared_box" );
            return 1;
        }
        return 0;
    }
    self.hint_parm1 = undefined;
    if ( isDefined( self.stub.trigger_target.grab_weapon_hint ) && self.stub.trigger_target.grab_weapon_hint )
    {
        if(level.shared_box)
        {
            self.hint_string = get_hint_string( self, "default_shared_box" );
        }    
        else
        {
            if (isDefined( level.magic_box_check_equipment ) && [[ level.magic_box_check_equipment ]]( self.stub.trigger_target.grab_weapon_name ) )
            {
                self.hint_string = "Hold ^3&&1^7 for Equipment ^1or ^7Press ^3[{+melee}]^7 to let teammates pick it up";
            }
            else 
            {
                self.hint_string = "Hold ^3&&1^7 for Weapon ^1or ^7Press ^3[{+melee}]^7 to let teammates pick it up";
            }
        }
    }
    else
    {
        if ( isDefined( level.using_locked_magicbox ) && level.using_locked_magicbox && isDefined( self.stub.trigger_target.is_locked ) && self.stub.trigger_target.is_locked )
        {
            self.hint_string = get_hint_string( self, "locked_magic_box_cost" );
        }
        else
        {
            self.hint_parm1 = self.stub.trigger_target.zombie_cost;
            self.hint_string = get_hint_string( self, "default_treasure_chest" );
        }
    }
    return 1;
}

custom_treasure_chest_think()
{
    if(!isdefined(level.perk_pick))
    {
        level.perk_pick = 0;
    }
	self endon( "kill_chest_think" );
	user = undefined;
	user_cost = undefined;
	self.box_rerespun = undefined;
	self.weapon_out = undefined;
	self thread unregister_unitrigger_on_kill_think();
	while ( 1 )
	{
		if ( !isdefined( self.forced_user ) )
		{
			self waittill( "trigger", user );
			if ( user == level )
			{
				wait 0.1;
				continue;
			}
		}
		else
		{
			user = self.forced_user;
		}
		if ( user in_revive_trigger() )
		{
			wait 0.1;
			continue;
		}
		if ( user.is_drinking > 0 )
		{
			wait 0.1;
			continue;
		}
		if ( isdefined( self.disabled ) && self.disabled )
		{
			wait 0.1;
			continue;
		}
		if ( user getcurrentweapon() == "none" )
		{
			wait 0.1;
			continue;
		}
		reduced_cost = undefined;
		if ( is_player_valid( user ) && user maps/mp/zombies/_zm_pers_upgrades_functions::is_pers_double_points_active() )
		{
			reduced_cost = int( self.zombie_cost / 2 );
		}
		if ( isdefined( level.using_locked_magicbox ) && level.using_locked_magicbox && isdefined( self.is_locked ) && self.is_locked ) 
		{
			if ( user.score >= level.locked_magic_box_cost )
			{
				user maps/mp/zombies/_zm_score::minus_to_player_score( level.locked_magic_box_cost );
				self.zbarrier set_magic_box_zbarrier_state( "unlocking" );
				self.unitrigger_stub run_visibility_function_for_all_triggers();
			}
			else
			{
				user maps/mp/zombies/_zm_audio::create_and_play_dialog( "general", "no_money_box" );
			}
			wait 0.1 ;
			continue;
		}
		else if ( isdefined( self.auto_open ) && is_player_valid( user ) )
		{
			if ( !isdefined( self.no_charge ) )
			{
				user maps/mp/zombies/_zm_score::minus_to_player_score( self.zombie_cost );
				user_cost = self.zombie_cost;
			}
			else
			{
				user_cost = 0;
			}
			self.chest_user = user;
			break;
		}
		else if ( is_player_valid( user ) && user.score >= self.zombie_cost )
		{
			user maps/mp/zombies/_zm_score::minus_to_player_score( self.zombie_cost );
			user_cost = self.zombie_cost;
			self.chest_user = user;
			break;
		}
		else if ( isdefined( reduced_cost ) && user.score >= reduced_cost )
		{
			user maps/mp/zombies/_zm_score::minus_to_player_score( reduced_cost );
			user_cost = reduced_cost;
			self.chest_user = user;
			break;
		}
		else if ( user.score < self.zombie_cost )
		{
			play_sound_at_pos( "no_purchase", self.origin );
			user maps/mp/zombies/_zm_audio::create_and_play_dialog( "general", "no_money_box" );
			wait 0.1;
			continue;
		}
		wait 0.05;
	}
	flag_set( "chest_has_been_used" );
	maps/mp/_demo::bookmark( "zm_player_use_magicbox", getTime(), user );
	user maps/mp/zombies/_zm_stats::increment_client_stat( "use_magicbox" );
	user maps/mp/zombies/_zm_stats::increment_player_stat( "use_magicbox" );
	if ( isDefined( level._magic_box_used_vo ) )
	{
		user thread [[ level._magic_box_used_vo ]]();
	}
	self thread watch_for_emp_close();
	if ( isDefined( level.using_locked_magicbox ) && level.using_locked_magicbox )
	{
		self thread maps/mp/zombies/_zm_magicbox_lock::watch_for_lock();
	}
	self._box_open = 1;
	level.box_open = 1;
	self._box_opened_by_fire_sale = 0;
	if ( isDefined( level.zombie_vars[ "zombie_powerup_fire_sale_on" ] ) && level.zombie_vars[ "zombie_powerup_fire_sale_on" ] && !isDefined( self.auto_open ) && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() )
	{
		self._box_opened_by_fire_sale = 1;
	}
	if ( isDefined( self.chest_lid ) )
	{
		self.chest_lid thread treasure_chest_lid_open();
	}
	if ( isDefined( self.zbarrier ) )
	{
		play_sound_at_pos( "open_chest", self.origin );
		play_sound_at_pos( "music_chest", self.origin );
		self.zbarrier set_magic_box_zbarrier_state( "open" );
	}
	self.timedout = 0;
	self.weapon_out = 1;
	self.zbarrier thread treasure_chest_weapon_spawn( self, user );
	self.zbarrier thread treasure_chest_glowfx();
	thread maps/mp/zombies/_zm_unitrigger::unregister_unitrigger( self.unitrigger_stub );
	self.zbarrier waittill_any( "randomization_done", "box_hacked_respin" );
	if ( flag( "moving_chest_now" ) && !self._box_opened_by_fire_sale && isDefined( user_cost ) )
	{
		user maps/mp/zombies/_zm_score::add_to_player_score( user_cost, 0 );
	}
	if ( flag( "moving_chest_now" ) && !level.zombie_vars[ "zombie_powerup_fire_sale_on" ] && !self._box_opened_by_fire_sale )
	{
		self thread treasure_chest_move( self.chest_user );
	}
	else
	{
		self.grab_weapon_hint = 1;
		self.grab_weapon_name = self.zbarrier.weapon_string;
		self.chest_user = user;
		thread maps/mp/zombies/_zm_unitrigger::register_static_unitrigger( self.unitrigger_stub, ::magicbox_unitrigger_think );
		if ( isDefined( self.zbarrier ) && !is_true( self.zbarrier.closed_by_emp ) )
		{
			self thread treasure_chest_timeout();
		}
		timeout_time = 105;
		grabber = user;
		for( i=0;i<105;i++ )
		{
			if(user meleeButtonPressed() && isplayer( user ) && distance(self.origin, user.origin) <= 100)
			{
				fx_obj = spawn( "script_model", self.origin + (0,0,35) );
    			fx_obj setmodel( "tag_origin" );
				Fx_box = loadfx("maps/zombie/fx_zmb_race_trail_grief");
				fx = PlayFXOnTag(Fx_box, fx_obj, "TAG_ORIGIN");
				level.magic_box_grab_by_anyone = 1;
				level.shared_box = 1;
				self.unitrigger_stub run_visibility_function_for_all_triggers();
				for( a=i;a<105;a++ )
				{
					foreach(player in level.players)
					{
						if(player usebuttonpressed() && distance(self.origin, player.origin) <= 100 && isDefined( player.is_drinking ) && !player.is_drinking)
						{
							if(level.box_perks == 0 && level.perk_pick == 1)
                            {
                                player playsound( "zmb_cha_ching" );
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_revive" )
                                {
                                    player thread DoGivePerk("specialty_quickrevive");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_sleight")
                                {
                                    player thread DoGivePerk("specialty_fastreload");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_doubletap" )
                                {
                                    player thread DoGivePerk("specialty_rof");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_jugg")
                                {
                                    player thread DoGivePerk("specialty_armorvest");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_marathon" )
                                {
                                    player thread DoGivePerk("specialty_longersprint");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_tombstone")
                                {
                                    player thread DoGivePerk("specialty_scavenger");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_deadshot" )
                                {
                                    player thread DoGivePerk("specialty_deadshot");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_cherry")
                                {
                                    player thread DoGivePerk("specialty_grenadepulldeath");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_nuke" )
                                {
                                    player thread DoGivePerk("specialty_flakjacket");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_additionalprimaryweapon")
                                {
                                    player thread DoGivePerk("specialty_additionalprimaryweapon");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_vulture" )
                                {
                                    player thread DoGivePerk("specialty_nomotionsensor");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_whoswho")
                                {
                                    player thread DoGivePerk("specialty_finalstand");
                                }
                            }
                            else
                            {
                                player thread treasure_chest_give_weapon( self.zbarrier.weapon_string );
                            }
                            a = 105;
							break;
						}
					}
					wait 0.1;
				}
				break;
			}
			if(grabber usebuttonpressed() && isplayer( grabber ) && user == grabber && distance(self.origin, grabber.origin) <= 100 && isDefined( grabber.is_drinking ) && !grabber.is_drinking)
			{
                if(level.box_perks == 0 && level.perk_pick == 1)
                {
                    grabber playsound( "zmb_cha_ching" );
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_revive" )
                    {
                        grabber thread DoGivePerk("specialty_quickrevive");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_sleight")
                    {
                        grabber thread DoGivePerk("specialty_fastreload");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_doubletap" )
                    {
                        grabber thread DoGivePerk("specialty_rof");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_jugg")
                    {
                        grabber thread DoGivePerk("specialty_armorvest");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_marathon" )
                    {
                        grabber thread DoGivePerk("specialty_longersprint");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_tombstone")
                    {
                        grabber thread DoGivePerk("specialty_scavenger");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_deadshot" )
                    {
                        grabber thread DoGivePerk("specialty_deadshot");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_cherry")
                    {
                        grabber thread DoGivePerk("specialty_grenadepulldeath");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_nuke" )
                    {
                        grabber thread DoGivePerk("specialty_flakjacket");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_additionalprimaryweapon")
                    {
                        grabber thread DoGivePerk("specialty_additionalprimaryweapon");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_vulture" )
                    {
                        grabber thread DoGivePerk("specialty_nomotionsensor");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_whoswho")
                    {
                        grabber thread DoGivePerk("specialty_finalstand");
                    }
                }
				else
                {
                    grabber thread treasure_chest_give_weapon( self.zbarrier.weapon_string );
                }
                break;
			}
			wait 0.1;
		}
		fx_obj delete();
		fx Delete();
		self.weapon_out = undefined;
		self notify( "user_grabbed_weapon" );
		user notify( "user_grabbed_weapon" );
		self.grab_weapon_hint = 0;
		self.zbarrier notify( "weapon_grabbed" );
		if ( isDefined( self._box_opened_by_fire_sale ) && !self._box_opened_by_fire_sale )
		{
			level.chest_accessed += 1;
		}
		if ( level.chest_moves > 0 && isDefined( level.pulls_since_last_ray_gun ) )
		{
			level.pulls_since_last_ray_gun += 1;
		}
		thread maps/mp/zombies/_zm_unitrigger::unregister_unitrigger( self.unitrigger_stub );
		if ( isDefined( self.chest_lid ) )
		{
			self.chest_lid thread treasure_chest_lid_close( self.timedout );
		}
		if ( isDefined( self.zbarrier ) )
		{
			self.zbarrier set_magic_box_zbarrier_state( "close" );
			play_sound_at_pos( "close_chest", self.origin );
			self.zbarrier waittill( "closed" );
			wait 1;
		}
		else
		{
			wait 3;
		}
		if ( isDefined( level.zombie_vars[ "zombie_powerup_fire_sale_on" ] ) && level.zombie_vars[ "zombie_powerup_fire_sale_on" ] || self [[ level._zombiemode_check_firesale_loc_valid_func ]]() || self == level.chests[ level.chest_index ] )
		{
			thread maps/mp/zombies/_zm_unitrigger::register_static_unitrigger( self.unitrigger_stub, ::magicbox_unitrigger_think );
		}
	}
    level.perk_pick = 0;
	self._box_open = 0;
	level.box_open = 0;
	level.shared_box = 0;
	level.magic_box_grab_by_anyone = 0;
	self._box_opened_by_fire_sale = 0;
	self.chest_user = undefined;
	self notify( "chest_accessed" );
	self thread custom_treasure_chest_think();
}

custom_watch_for_lock()
{
    self endon( "user_grabbed_weapon" );
    self endon( "chest_accessed" );
    self waittill( "box_locked" );
    self notify( "kill_chest_think" );
    self.grab_weapon_hint = 0;
    wait 0.1;
    self thread maps/mp/zombies/_zm_unitrigger::register_static_unitrigger( self.unitrigger_stub, ::magicbox_unitrigger_think );
    self.unitrigger_stub run_visibility_function_for_all_triggers();
    self thread custom_treasure_chest_think();
}

treasure_chest_weapon_spawn( chest, player, respin )
{
	if ( isDefined( level.using_locked_magicbox ) && level.using_locked_magicbox )
	{
		self.owner endon( "box_locked" );
		self thread maps/mp/zombies/_zm_magicbox_lock::clean_up_locked_box();
	}
	self endon( "box_hacked_respin" );
	self thread clean_up_hacked_box();
	self.weapon_string = undefined;
	modelname = undefined;
	rand = undefined;
	number_cycles = 40;
	if ( isDefined( chest.zbarrier ) )
	{
		if ( isDefined( level.custom_magic_box_do_weapon_rise ) )
		{
			chest.zbarrier thread [[ level.custom_magic_box_do_weapon_rise ]]();
		}
		else
		{
			chest.zbarrier thread magic_box_do_weapon_rise();
		}
	}
	i = 0;
	while ( i < number_cycles )
	{
		if ( i < 20 )
		{
			wait 0.05;
			i++;
			continue;
		}
		else if ( i < 30 )
		{
			wait 0.1;
			i++;
			continue;
		}
		else if ( i < 35 )
		{
			wait 0.2;
			i++;
			continue;
		}
		else
		{
			if ( i < 38 )
			{
				wait 0.3;
			}
		}
		i++;
	}
	if ( isDefined( level.custom_magic_box_weapon_wait ) )
	{
		[[ level.custom_magic_box_weapon_wait ]]();
	}
	if ( isDefined( player.pers_upgrades_awarded[ "box_weapon" ] ) && player.pers_upgrades_awarded[ "box_weapon" ] )
	{
		rand = pers_treasure_chest_choosespecialweapon( player );
	}
	else
	{
        
		rand = custom_treasure_chest_chooseweightedrandomweapon( player );
	}
    if(rand == "zombie_perk_bottle_revive")
    {
        rand = "zombie_perk_bottle_revive";
    }
	self.weapon_string = rand;
	wait 0.1;
	if ( isDefined( level.custom_magicbox_float_height ) )
	{
		v_float = anglesToUp( self.angles ) * level.custom_magicbox_float_height;
	}
	else
	{
		v_float = anglesToUp( self.angles ) * 40;
	}
	self.model_dw = undefined;
	self.weapon_model = spawn_weapon_model( rand, undefined, self.origin + v_float, self.angles + vectorScale( ( 0, 1, 0 ), 180 ) );
	if ( weapon_is_dual_wield( rand ) )
	{
		self.weapon_model_dw = spawn_weapon_model( rand, get_left_hand_weapon_model_name( rand ), self.weapon_model.origin - vectorScale( ( 0, 1, 0 ), 3 ), self.weapon_model.angles );
	}
    if ( getDvar( "magic_chest_movable" ) == "1" && !( isdefined( chest._box_opened_by_fire_sale ) && chest._box_opened_by_fire_sale ) && !( isdefined( level.zombie_vars["zombie_powerup_fire_sale_on"] ) && level.zombie_vars["zombie_powerup_fire_sale_on"] && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() ) )
	{
    	random = randomint( 100 );
		if ( !isDefined( level.chest_min_move_usage ) )
		{
			level.chest_min_move_usage = 4;
		}
		if ( level.chest_accessed < level.chest_min_move_usage )
		{
			chance_of_joker = -1;
		}
		else chance_of_joker = level.chest_accessed + 20;
		if ( level.chest_moves == 0 && level.chest_accessed >= 8 )
		{
			chance_of_joker = 100;
		}
		if ( level.chest_accessed >= 4 && level.chest_accessed < 8 )
		{
			if ( random < 15 )
			{
				chance_of_joker = 100;
			}
			else
			{
				chance_of_joker = -1;
			}
		}
		if ( level.chest_moves > 0 )
		{
			if ( level.chest_accessed >= 8 && level.chest_accessed < 13 )
			{
				if ( random < 30 )
				{
					chance_of_joker = 100;
				}
				else
				{
					chance_of_joker = -1;
				}
			}
			if ( level.chest_accessed >= 13 )
			{
				if ( random < 50 )
				{
					chance_of_joker = 100;
				}
				else
				{
					chance_of_joker = -1;
				}
			}
		}
		if ( isDefined( chest.no_fly_away ) )
		{
			chance_of_joker = -1;
		}
		if ( isDefined( level._zombiemode_chest_joker_chance_override_func ) )
		{
			chance_of_joker = [[ level._zombiemode_chest_joker_chance_override_func ]]( chance_of_joker );
		}
		if ( chance_of_joker > random )
		{
			self.weapon_string = undefined;
			self.weapon_model setmodel( level.chest_joker_model );
			self.weapon_model.angles = self.angles + vectorScale( ( 0, 1, 0 ), 90 );
			if ( isDefined( self.weapon_model_dw ) )
			{
				self.weapon_model_dw delete();
				self.weapon_model_dw = undefined;
			}
			self.chest_moving = 1;
			flag_set( "moving_chest_now" );
			level.chest_accessed = 0;
			level.chest_moves++;
		}
	}
	self notify( "randomization_done" );
	if ( flag( "moving_chest_now" ) && !( level.zombie_vars["zombie_powerup_fire_sale_on"] && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() ) )
	{
		if ( isDefined( level.chest_joker_custom_movement ) )
		{
			self [[ level.chest_joker_custom_movement ]]();
		}
		else
		{
			wait 0.5;
			level notify( "weapon_fly_away_start" );
			wait 2;
			if ( isDefined( self.weapon_model ) )
			{
				v_fly_away = self.origin + ( anglesToUp( self.angles ) * 500 );
				self.weapon_model moveto( v_fly_away, 4, 3 );
			}
			if ( isDefined( self.weapon_model_dw ) )
			{
				v_fly_away = self.origin + ( anglesToUp( self.angles ) * 500 );
				self.weapon_model_dw moveto( v_fly_away, 4, 3 );
			}
			self.weapon_model waittill( "movedone" );
			self.weapon_model delete();
			if ( isDefined( self.weapon_model_dw ) )
			{
				self.weapon_model_dw delete();
				self.weapon_model_dw = undefined;
			}
			self notify( "box_moving" );
			level notify( "weapon_fly_away_end" );
		}
	}
	else
	{
		acquire_weapon_toggle( rand, player );
		if ( rand == "tesla_gun_zm" || rand == "ray_gun_zm" )
		{
			if ( rand == "ray_gun_zm" )
			{
				level.pulls_since_last_ray_gun = 0;
			}
			if ( rand == "tesla_gun_zm" )
			{
				level.pulls_since_last_tesla_gun = 0;
				level.player_seen_tesla_gun = 1;
			}
		}
		if ( !isDefined( respin ) )
		{
			if ( isDefined( chest.box_hacks[ "respin" ] ) )
			{
				self [[ chest.box_hacks[ "respin" ] ]]( chest, player );
			}
		}
		else
		{
			if ( isDefined( chest.box_hacks[ "respin_respin" ] ) )
			{
				self [[ chest.box_hacks[ "respin_respin" ] ]]( chest, player );
			}
		}
		if ( isDefined( level.custom_magic_box_timer_til_despawn ) )
		{
			self.weapon_model thread [[ level.custom_magic_box_timer_til_despawn ]]( self );
		}
		else
		{
			self.weapon_model thread timer_til_despawn( v_float );
		}
		if ( isDefined( self.weapon_model_dw ) )
		{
			if ( isDefined( level.custom_magic_box_timer_til_despawn ) )
			{
				self.weapon_model_dw thread [[ level.custom_magic_box_timer_til_despawn ]]( self );
			}
			else
			{
				self.weapon_model_dw thread timer_til_despawn( v_float );
			}
		}
		self waittill( "weapon_grabbed" );
		if ( !chest.timedout )
		{
			if ( isDefined( self.weapon_model ) )
			{
				self.weapon_model delete();
			}
			if ( isDefined( self.weapon_model_dw ) )
			{
				self.weapon_model_dw delete();
			}
		}
	}
	self.weapon_string = undefined;
	self notify( "box_spin_done" );
}

pers_treasure_chest_choosespecialweapon( player )
{
	rval = randomfloat( 1 );
	if ( !isDefined( player.pers_magic_box_weapon_count ) )
	{
		player.pers_magic_box_weapon_count = 0;
	}
	if ( player.pers_magic_box_weapon_count < 2 || player.pers_magic_box_weapon_count == 0 && rval < 0.6 )
	{
		player.pers_magic_box_weapon_count++;
		if ( isDefined( level.pers_treasure_chest_get_weapons_array_func ) )
		{
			[[ level.pers_treasure_chest_get_weapons_array_func ]]();
		}
		else
		{
			maps/mp/zombies/_zm_pers_upgrades_functions::pers_treasure_chest_get_weapons_array();
		}
		keys = array_randomize( level.pers_box_weapons );
		pap_triggers = getentarray( "specialty_weapupgrade", "script_noteworthy" );
		i = 0;
		while ( i < keys.size )
		{
			if ( maps/mp/zombies/_zm_magicbox::treasure_chest_canplayerreceiveweapon( player, keys[ i ], pap_triggers ) )
			{
				return keys[ i ];
			}
			i++;
		}
		return keys[ 0 ];
	}
	else
	{
		player.pers_magic_box_weapon_count = 0;
		weapon = custom_treasure_chest_chooseweightedrandomweapon( player );
		return weapon;
	}
}

custom_treasure_chest_chooseweightedrandomweapon( player )
{
    level.box_perks = randomintrange(0,5);
	zombie_perks = [];
    if(level.box_perks == 0 && player.num_perks < level.perk_purchase_limit && level.perks_in_box_enabled)
    {  
		if(!player hasperk("specialty_rof"))
		{
        	zombie_perks[zombie_perks.size] = "zombie_perk_bottle_doubletap";
		}
		if(!player hasperk("specialty_armorvest"))
		{
        	zombie_perks[zombie_perks.size] = "zombie_perk_bottle_jugg";
		}
		if(!player hasperk("specialty_fastreload"))
		{
        	zombie_perks[zombie_perks.size] = "zombie_perk_bottle_sleight";
		}
        if(getdvar("mapname") == "zm_transit")
        {
			if(!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
			if(!player hasperk("specialty_longersprint"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_marathon";
			}
            if(get_players().size > 1 && !player hasperk("specialty_scavenger") )
            {
		        zombie_perks[zombie_perks.size] = "zombie_perk_bottle_tombstone";
            }
        }
        if(getdvar("mapname") == "zm_prison")
        {
			if(!player hasperk("specialty_deadshot"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_deadshot";
			}
			if(!player hasperk("specialty_grenadepulldeath"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_cherry";
			}  
        }
        if(getdvar("mapname") == "zm_nuked")
        {
			if(!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
        }
        if(getdvar("mapname") == "zm_tomb")
        {
			if(!player hasperk("specialty_deadshot"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_deadshot";
			}
			if(!player hasperk("specialty_grenadepulldeath"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_cherry";
			}
			if(!player hasperk("specialty_flakjacket"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_nuke";
			}
			if(!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
			if(!player hasperk("specialty_longersprint"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_marathon";
			}
			if(!player hasperk("specialty_additionalprimaryweapon"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_additionalprimaryweapon";
			}
		}
        if(getdvar("mapname") == "zm_buried")
        {
			if(!player hasperk("specialty_nomotionsensor"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_vulture";
			}
			if(!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
			if(!player hasperk("specialty_deadshot"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_marathon";
			}
			if(!player hasperk("specialty_additionalprimaryweapon"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_additionalprimaryweapon";
			}
		}
        if(getdvar("mapname") == "zm_highrise")
        {
			if(!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
			if(!player hasperk("specialty_additionalprimaryweapon"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_additionalprimaryweapon";
			}
			if(!player hasperk("specialty_finalstand"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_whoswho";
			}
		}
    }
	if(zombie_perks.size > 0)
	{
		keys = array_randomize( zombie_perks );
	}
    else
    {
    	keys = array_randomize( getarraykeys( level.zombie_weapons ) );
    }
	if ( isDefined( level.customrandomweaponweights ) )
	{
		keys = player [[ level.customrandomweaponweights ]]( keys );
	}
	pap_triggers = getentarray( "specialty_weapupgrade", "script_noteworthy" );
	i = 0;
	while ( i < keys.size )
	{
        if( zombie_perks.size > 0 )
        {
            if( treasure_chest_canplayerreceiveperk( player, keys[ i ] ) )
            {
                return keys[ i ];
            }
        }
        else
        {
            if( treasure_chest_canplayerreceiveweapon( player, keys[ i ], pap_triggers ) )
            {
                return keys[ i ];
            }
        }
		i++;
	}
	return keys[ 0 ];
}

treasure_chest_canplayerreceiveperk( player, weapon )
{
    
    if(weapon == "zombie_perk_bottle_sleight")
    {
        if(player hasperk("specialty_fastreload"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_revive")
    {
        if(player hasperk("specialty_quickrevive"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_doubletap")
    {
        if(player hasperk("specialty_rof"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_jugg")
    {
        if(player hasperk("specialty_armorvest"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_marathon")
    {
        if(player hasperk("specialty_longersprint"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_tombstone")
    {
        if(player hasperk("specialty_scavenger"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_deadshot")
    {
        if(player hasperk("specialty_deadshot"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_cherry")
    {
        if(player hasperk("specialty_grenadepulldeath"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_nuke")
    {
        if(player hasperk("specialty_flakjacket"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_additionalprimaryweapon")
    {
        if(player hasperk("specialty_additionalprimaryweapon"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_vulture")
    {
        if(player hasperk("specialty_nomotionsensor"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_whoswho")
    {
        if(player hasperk("specialty_finalstand"))
        {
            return 0;
        }
    }
    level.perk_pick = 1;
    return 1;
}

doGivePerk(perk)
{
    self endon("disconnect");
    self endon("death");
    level endon("game_ended");
    self endon("perk_abort_drinking");
    if (!(self hasperk(perk) || (self maps/mp/zombies/_zm_perks::has_perk_paused(perk))))
    {
        gun = self maps/mp/zombies/_zm_perks::perk_give_bottle_begin(perk);
        evt = self waittill_any_return("fake_death", "death", "player_downed", "weapon_change_complete");
        if (evt == "weapon_change_complete")
            self thread maps/mp/zombies/_zm_perks::wait_give_perk(perk, 1);
        self maps/mp/zombies/_zm_perks::perk_give_bottle_end(gun, perk);
        if (self maps/mp/zombies/_zm_laststand::player_is_in_laststand() || isDefined(self.intermission) && self.intermission)
            return;
        self notify("burp");
    }
}
