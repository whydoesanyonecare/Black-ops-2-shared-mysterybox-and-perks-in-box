�GSC
     �  �9  �  �9  �2  r3  \G  \G      @ �  ^        box maps/mp/_utility common_scripts/utility maps/mp/gametypes_zm/_hud_util maps/mp/zombies/_zm_weapons maps/mp/zombies/_zm_magicbox maps/mp/zombies/_zm maps/mp/zombies/_zm_unitrigger maps/mp/zombies/_zm_utility init checkforcurrentbox shared_box add_zombie_hint default_shared_box Hold ^3&&1^7 for weapon perks_in_box_enabled getdvarintdefault perks_in_box flag_wait initial_blackscreen_passed setperklimit end_game set_perk_limit mapname connected player map zm_transit get_players limit zm_prison zm_nuked zm_tomb zm_buried zm_highrise perk_purchase_limit i chests reset_box hidden get_chest_pieces unitrigger_stub prompt_and_visibility_func boxtrigger_update_prompt kill_chest_think grab_weapon_hint register_static_unitrigger magicbox_unitrigger_think run_visibility_function_for_all_triggers custom_treasure_chest_think chest_box getent script_noteworthy _zbarrier chest_rubble rubble getentarray _rubble distancesquared origin zbarrier zbarrierpieceuseboxriselogic spawnstruct angles script_unitrigger_type unitrigger_box_use script_width script_height script_length trigger_target unitrigger_force_per_player_triggers owner can_use custom_boxstub_update_prompt hint_string hint_parm1 sethintstring setcursorhint HINT_NOICON trigger_visible_to_player setvisibletoplayer get_hint_string stub magic_box_check_equipment grab_weapon_name Hold ^3&&1^7 for Equipment ^1or ^7Press ^3[{+melee}]^7 to let teammates pick it up Hold ^3&&1^7 for Weapon ^1or ^7Press ^3[{+melee}]^7 to let teammates pick it up using_locked_magicbox is_locked locked_magic_box_cost zombie_cost default_treasure_chest perk_pick user user_cost box_rerespun weapon_out unregister_unitrigger_on_kill_think forced_user trigger in_revive_trigger is_drinking disabled getcurrentweapon none reduced_cost is_player_valid maps/mp/zombies/_zm_pers_upgrades_functions is_pers_double_points_active int score maps/mp/zombies/_zm_score minus_to_player_score set_magic_box_zbarrier_state unlocking maps/mp/zombies/_zm_audio create_and_play_dialog general no_money_box auto_open no_charge chest_user play_sound_at_pos no_purchase flag_set chest_has_been_used maps/mp/_demo bookmark zm_player_use_magicbox maps/mp/zombies/_zm_stats increment_client_stat use_magicbox increment_player_stat _magic_box_used_vo watch_for_emp_close maps/mp/zombies/_zm_magicbox_lock watch_for_lock _box_open box_open _box_opened_by_fire_sale zombie_vars zombie_powerup_fire_sale_on _zombiemode_check_firesale_loc_valid_func chest_lid treasure_chest_lid_open open_chest music_chest open timedout treasure_chest_weapon_spawn treasure_chest_glowfx unregister_unitrigger waittill_any randomization_done box_hacked_respin flag moving_chest_now add_to_player_score treasure_chest_move weapon_string is_true closed_by_emp treasure_chest_timeout timeout_time grabber meleebuttonpressed isplayer distance fx_obj spawn script_model setmodel tag_origin fx_box loadfx maps/zombie/fx_zmb_race_trail_grief fx playfxontag TAG_ORIGIN magic_box_grab_by_anyone a _a778 _k778 players usebuttonpressed box_perks playsound zmb_cha_ching zombie_perk_bottle_revive dogiveperk specialty_quickrevive zombie_perk_bottle_sleight specialty_fastreload zombie_perk_bottle_doubletap specialty_rof zombie_perk_bottle_jugg specialty_armorvest zombie_perk_bottle_marathon specialty_longersprint zombie_perk_bottle_tombstone specialty_scavenger zombie_perk_bottle_deadshot specialty_deadshot zombie_perk_bottle_cherry specialty_grenadepulldeath zombie_perk_bottle_nuke specialty_flakjacket zombie_perk_bottle_additionalprimaryweapon specialty_additionalprimaryweapon zombie_perk_bottle_vulture specialty_nomotionsensor zombie_perk_bottle_whoswho specialty_finalstand treasure_chest_give_weapon delete user_grabbed_weapon weapon_grabbed chest_accessed chest_moves pulls_since_last_ray_gun treasure_chest_lid_close close close_chest closed chest_index custom_watch_for_lock box_locked chest respin clean_up_locked_box clean_up_hacked_box modelname rand number_cycles custom_magic_box_do_weapon_rise magic_box_do_weapon_rise custom_magic_box_weapon_wait pers_upgrades_awarded box_weapon pers_treasure_chest_choosespecialweapon custom_treasure_chest_chooseweightedrandomweapon custom_magicbox_float_height v_float model_dw weapon_model spawn_weapon_model weapon_is_dual_wield weapon_model_dw get_left_hand_weapon_model_name magic_chest_movable 1 random randomint chest_min_move_usage chance_of_joker no_fly_away _zombiemode_chest_joker_chance_override_func chest_joker_model chest_moving chest_joker_custom_movement weapon_fly_away_start v_fly_away moveto movedone box_moving weapon_fly_away_end acquire_weapon_toggle tesla_gun_zm ray_gun_zm pulls_since_last_tesla_gun player_seen_tesla_gun box_hacks respin_respin custom_magic_box_timer_til_despawn timer_til_despawn box_spin_done rval randomfloat pers_magic_box_weapon_count pers_treasure_chest_get_weapons_array_func pers_treasure_chest_get_weapons_array keys array_randomize pers_box_weapons pap_triggers specialty_weapupgrade treasure_chest_canplayerreceiveweapon weapon randomintrange zombie_perks num_perks hasperk getarraykeys zombie_weapons customrandomweaponweights treasure_chest_canplayerreceiveperk perk disconnect death game_ended perk_abort_drinking maps/mp/zombies/_zm_perks has_perk_paused gun perk_give_bottle_begin evt waittill_any_return fake_death player_downed weapon_change_complete wait_give_perk perk_give_bottle_end maps/mp/zombies/_zm_laststand player_is_in_laststand intermission burp D   U   l   �   �   �   �   �   &-2   6!+(-
 Y
 F.   6  6-
 �.   �  !q(-
 �. �  6-2 �  6 
 �W-
�h.  �  6
�U$ %?��  #_9;  Y   L   -.    SI;  ' (? ' (?` ' (?X ' (?P 	' (?H ' (?@ ' (?8 Z        ����)  ����3  ����<  ����D  ����N  ���� !Z( n-
�.   �  6
�h
3F; 
+' (   pSH; d -   p4  w  6   p7  �;  -   p0    �  6   p7  �9;  �    p7  �7!�(' A? ��  &X
 �V	 ���=+  �9;' ! �(-    �4  �  6- �0 4  6-4    ]  6 �n-
� �
 �N.  �  !y(!�(-
 � �
 �N.  �  '(' ( SH;4 - 7 � �. �   'H;    �S! �(' A?��-
� �
 �N.  �  !�(  �_; -  �0 �  6- �0   �  6-.   !�(  � b	  ��PN �7!�(   �7!(
5 �7!(h  �7!H(2  �7!U(-  �7!c( �7!q(- �. �  6  �   �7!�( �7!�( �-0 �  ' (  �_;1  �_; -  � �0    �  6? -  �0    �  6   -
0    �  6- 0    9;.  +; $ - 0   )  6-
 F.    <  !�(! �(  L7 q7 �_=  L7 q7 �; V  +;  -
F.    <  !�(?5  Q_= -  L7 q7 k Q/;  
 |!�(?	 
 �!�(?i  _=  =   L7 q7 5_=  L7 q7 5;  -
?.  <  !�(?%  L7 q7 U!�(-
 a.    <  !�(  ��#nP~���� x_9;  ! x(
�W'('(! �(!�(-4    �  6;b �_9;   
 �U$%F; 	   ���=+?��?   �'(-0 �  ;  	   ���=+?��7 �I;  	   ���=+?�� �_=  �;  	   ���=+?}�-0      
 F; 	   ���=+?]�'
(-.    +  =  -0    g  ;  -  UQ.  �  '
(  _=  =   5_=  5; \ 7 � ?K;. -  ?0 �  6-
 � �0 �  6- �0 4  6? -

 0 �  6	  ���=+?��?  +_= -.    +  ; 6  5_9;  -  U0 �  6  U'(? '(!?(?� ? � -.  +  =  7 � UK;& -  U0 �  6  U'(! ?(?� ? t 
_=	 7 �
K;" -
0    �  6
'(!?(?P ? @ 7 � UH;2 -  �
 \.   J  6-
 
 0   �  6	  ���=+?��	   ��L=+?��-
q.   h  6-g
�.   �  6-
 �0   �  6-
 �0   �  6  	_; -  	5 6-4    	  6  _=  ;  -4   O	  6! ^	(! h	(!q	(
�	 �	_= 	 
 �	 �	=  +_9=  - �	1 ;  !q	(  �	_; -  �	4   �	  6  �_;3 -  �
 �	.   J  6- �
 	
. J  6-
 
 �0 �  6!
(! �(-  �4   #
  6- �4 ?
  6- �2 U
  6-
 �

 x
 �0 k
  6-
 �
. �
  =   q	9= _; -0   �
  6-
 �
. �
  = 
 
 �	 �	9=   q	9; -  ?4  �
  6?�!�(  �7 �
!k(! ?(-    �2   �  6  �_= -  �7 �
.   �
  9;	 -4 �
  6i'	('('(iH; -0    +  =  -.    >  =  -7  � �.   G  dJ;�-  �#[N
 ]. W  '(-
 s0 j  6-
 �. �  '(-
 �.   �  '(! �(! +(- �0   4  6'(iH;6 �'(p'(_; ' (- 0  �  =  - 7  � �.   G  dJ=  7 �_=  7 �9;� 
F=   xF;�-
 0     6  �7 �

 ,F; -
Q 4   F  6  �7 �

 gF; -
� 4   F  6  �7 �

 �F; -
� 4   F  6  �7 �

 �F; -
� 4   F  6  �7 �

 �F; -

 4   F  6  �7 �

 !F; -
> 4   F  6  �7 �

 RF; -
n 4   F  6  �7 �

 �F; -
� 4   F  6  �7 �

 �F; -
� 4   F  6  �7 �

 �F; -
 4   F  6  �7 �

 0F; -
K 4   F  6  �7 �

 dF; -
 4   F  6? -  �7 �
 4   �  6i'(?  q'(? ��	 ���=+'A? ��? $-0    �  =  -.    >  =  F= -7  � �.   G  dJ= 7 �_= 7 �9;� 
F=   xF;�-
0     6  �7 �

 ,F; -
Q4   F  6  �7 �

 gF; -
�4   F  6  �7 �

 �F; -
�4   F  6  �7 �

 �F; -
�4   F  6  �7 �

 �F; -

4   F  6  �7 �

 !F; -
>4   F  6  �7 �

 RF; -
n4   F  6  �7 �

 �F; -
�4   F  6  �7 �

 �F; -
�4   F  6  �7 �

 �F; -
4   F  6  �7 �

 0F; -
K4   F  6  �7 �

 dF; -
4   F  6? -  �7 �
4   �  6? 	   ���=+'A? ��-0    �  6-0   �  6!�(X
 �VX
�V!�(X
 � �V  q	_=  q	9;  �N! �(  �I=   �_;  �N! �(- �2   U
  6  �	_; -  
 �	4     6  �_;. -
& �0 �  6- �
 ,. J  6
8 �U%+? +
�	 �	_= 	 
 �	 �	> - �	1 >    ? pF;  -     �2   �  6!x(!^	(!h	(!+(!�(!q	(!?(X
 �V-4   ]  6 &
�W
 �W
 aU%X
 �V! �(	���=+-    �4  �  6- �0 4  6-4    ]  6 lr���n�7]� _=  ;  
 a �W-4  y  6
�
W-4   �  6!�
('('(('(
7 �_;+  �_; -
7  � �5 6? -
7  �4   �  6'(H; j H; 	 ��L=+'A? ��? I H; 	   ���=+'A? ��? - #H; 	   ��L>+'A? ��?  &H;	 	   ���>+'A? �� �_;	 -  �/ 6
*	7 _=  
 *	7 ; -	.  5  '(? -	.  ]  '(
,F; 
 ,'(! �
(	���=+  �_;  a  �P'(?   a(P'(!�(- �^`N �N. �  !�(-.   �  ; 1 -  �7  �7 �^`O-.      . �  !�(
!h
5F= 
7 q	_= 
7 q	9;q-d.    >  '(  H_9;  !H(  � HH; '(?
  �N'( �F=   �K; d'(  �K=  �H; H; d'(? '(  �I; I  �K=  �H; H; d'(? '(  �K; 2H; d'(? '(
7  m_; '(  y_; -  y/'(I; k ! �
(- � �0 j  6  Z^`N �7!(  �_; -  �0   �  6!�(! �(-
 �
.   h  6!�(! �AX
 x
V-
�
.   �
  ; �  �_; - �1 6?� 	      ?+X
 �V+  �_;%  � a�PN' (-  �0     6  �_;#  � a�PN' (-  �0   6
	 �U%-  �0   �  6  �_; -  �0   �  6!�(X
 VX
V? 5-	.  1  6
GF> 
 TF;) 
 TF; ! �(
GF; ! _(! z(_9;( 
 r
7 �_;  -	

 r
7 �16? $ 
 �
7 �_;  -	

 �
7 �16 �_; - � �56? -  �4   �  6  �_;'  �_; - � �56? -  �4 �  6
�U%
7  
9;/  �_; -  �0   �  6  �_; -  �0   �  6!�
(X
 �V  �i�n�-.  �  '(7  �_9; 	 7! �(7  �H> 7 �F=  	   ��?H;| 7!�A  _; -  / 6?	 -.  C  6- ~. n  '(-
 �
 �.   �  '('(SH;  -. �  ;  'A?��? 7! �(-.   ]  ' (   �i�n-.   �  !
('(  
F=  7 � ZH=  q; �-
�0     9; 
 �S'(-
 �0   9; 
 �S'(-
 �0   9; 
 gS'(
�h
F;e -
Q0     9; 
 ,S'(-
 
0   9; 
 �S'(-.     SI=  -
>0   9; 
 !S'(
�h
)F;9 -
n0     9; 
 RS'(-
 �0   9; 
 �S'(
�h
3F; -
Q0     9; 
 ,S'(
�h
<F;� -
n0     9; 
 RS'(-
 �0   9; 
 �S'(-
 �0   9; 
 �S'(-
 Q0   9; 
 ,S'(-
 
0   9; 
 �S'(-
 0   9; 
 �S'(
�h
DF;q -
K0     9; 
 0S'(-
 Q0   9; 
 ,S'(-
 n0   9; 
 �S'(-
 0   9; 
 �S'(
�h
NF;U -
Q0     9; 
 ,S'(-
 0   9; 
 �S'(-
 0   9; 
 dS'(SI;  -.    n  '(? -- .     .   n  '(  )_; -  )1'(-
 �
 �.   �  '(' ( SH;H SI; - .   C  ;   ?  - .   �  ;   ' A?�� � 
 gF; -
�0     ;   
 ,F; -
Q0   ;   
 �F; -
�0   ;   
 �F; -
�0   ;   
 �F; -

0   ;   
 !F; -
>0   ;   
 RF; -
n0   ;   
 �F; -
�0   ;   
 �F; -
�0   ;   
 �F; -
0   ;   
 0F; -
K0   ;   
 dF; -
0   ;  !x(  g��
 lW
 wW
 }W
 �W-0   >  -0   �  9;x -0   �  '(-
 
 
 w
 �0  �  ' ( 
F; -4 )  6-0    8  6-0    k  >   �_=  �;   X
 �V  �={-�    վH��  �  X�-�"  � ��[��    A��Z  w  �o�  �  kQ��  � ���@N  � O��4�  ]  m���%  K  �V/�B&  #
 ����+  5 ���8�,  ] 6�GK�0  C ���2  F >   �  6>  �  �>  �  �>  �  �  �>   �  �>    >   =  �-  w>   �  �>     �>   :  �  >   z  *  �%  &  ��  �  !&  4>   �  
     .&  ]>   �  �%  7&  �>  �  1  �>  �  �,  <0  �>  �  �>  N  \  >   f  �>  �  �>    �>  +  �>  ?  �>  W  >  e  )>  |  <>  �  �  Q  w  �>   �  �>     >   c  +>  �  ?  �  g;  �  �>  �  �� �  ^  �  �  �>  �  V  >%  ��   $  J>    4  F  N%  h>  H  �)  �� X  �� h  �� x  	>   �  O	-	  �  �	>     #
>  t  ?
>   �  U
�  �  %  k
>  �  �
>  �  �  �)  �
� �  �
>    ��  4  �%  �
>  P  �
>   ^  +>     >>  �  w"  G>  �  `   �"  W>  �  j>  �  v)  �>  �  �>  �  �>   I   g"  >  �   �"  F>  �   �   �   !  <!  \!  |!  �!  �!  �!  �!  "  �"  #  4#  T#  t#  �#  �#  �#  �#  $  4$  T$  �>  4"  l$  �>   �$  �$  �)  x*  �*  �+  �+  >  $%  y-	  u&  �>   �&  �>   �&  5>  }'  ]>  �'  �,  �>  �'  6(  �>  (  >  +(  >>  c(  >  4*  b*  1>  �*  �>  l+  �+  �>  ,  C;  i,  n>  v,  �/  0  ��  �,  �>  �,  > # ,-  J-  f-  �-  �-  �-  �-  .  @.  h.  �.  �.  �.  �.  �.  /  :/  V/  r/  �/  �/  �/  �0  �0  �0  1  *1  F1  b1  ~1  �1  �1  �1  �1  *2  >  0  C>  d0  �>  �0  �� 82  �� H2  �>  e2  )� ~2  8� �2  kM  �2        +�  r  �     �%  Y �  F �  �  �  � �  q�   -  � �  �     �  P  �  F&  �+  �,  �0  �   � 
  �  |-  �-  0.  X.  /  �/  �   $  #&   �  �-  ) �  �-  3 �  �  4.  < �  \.  D �  /  N �  �/  Z�  -  n�  �  �  P&  �+  �,  p�  �  
    .  D  �%  �  4  l  �J  �  �  n  �  �  �  �  �  �  �  �  �    �  2     %  �%  &  ,&  �N  �  � ^  �  &  �v  �  �    �$  &  ��  � �  �  &  �,  60  ��  �  *  � �  .  y�  ��      � �  ��  �  t  �  
  .  @  �  �  �  Z   ^   �"  �"  H%  �'   (  *  H*  �/:  @  L  Z  �  �  $  T  r  �  �    @  J  �   �   �   !  (!  H!  h!  �!  �!  �!  �!  "  ,"  �"   #   #  @#  `#  �#  �#  �#  �#   $   $  @$  d$  �$  0%  <%  Z%  �&  �&  �&  x  �  �  �'  �'  �'  (  �)  �)  *  L*  5 �  �  H�  U�  c�  q�  �  �  �  2  B  f  ��  p&  �   �	  (  <  �  �  
    Z  �  �  $  �  n   T  L�  �  �  .  >  b  Q�  �  k�    |   �     &  �  �  �  �  \&  d&  56  F  �  �  ? N  Uj  �  Z  h  �  �  �     a t  ��  ��  �  �  #�  P�  ~�  ��  ��  ��  ��  x�  �  �   �"  �%  �1  ��  ��  h  �$  ��    � �  �0  r   |   �"  �"  �F  N   n  ��  �  �  �  ?�  �  � �             +6  �  5N  ?x  �  �  �  &  �%  \   q F  � V  � d  t  	�  �  ^	�  �%  h	�  �%  q		�    �  �  �$  �$  �%  P(  Z(  �	 �  �  �  h%  v%  �	�  �  �  l%  z%  �	�  �%  �	    %  "%  �	 2  	
 D  
 P  
`  %  �+  �
 �  ~&  x
 �  �)  �
 �  �  �)  �)  �
  �   �   �   !  ,!  L!  l!  �!  �!  �!  �!  "  0"  �"  #  $#  D#  d#  �#  �#  �#  �#  $  $$  D$  h$  �&  �'  j)  �+  �
N  ] �  s �  � �  � �  �   �%  �,   
�   �"  �,  -   �   �"  ,
 �   �"  �'  �'  �-  N.  �.  F/  �/  �0  Q �   �"  �-  <.  �.  6/  �/  �0  g �   #  r-  �0  � �   #  b-  �0  � �   (#  :-  �0  � �   0#  (-  �0  � !  H#  V-  1  � !  P#  F-  
1  � 0!  h#  �-  �.  b/  1  
 8!  p#  �-  �.  &1  ! P!  �#  �-  :1  > X!  �#  �-  B1  R p!  �#  
.  v.  V1  n x!  �#  �-  d.  R/  ^1  � �!  �#  &.  �.  r1  � �!  �#  .  �.  z1  � �!  �#  �.  �1  � �!  �#  �.  �1  � �!  $  /  ~/  �/  �1   �!  $  �.  n/  �/  �1  0 �!  ($  */  �1  K �!  0$  /  �1  d "  H$  �/  �1   "  P$  �/  �1  � �$  �$  �%  � �$  �+  ��$  �$  �(  �(  �(  �(  �(  �(  �(  )  �)  ��$  �(  �(  �)  ��$  �$   %  �*  & 8%  , L%  8 V%  ?�%  � �%  �%  a �%  l&  lD&  rH&  �J&  �L&  �N&  �R&  7T&  ]V&  �X&  ��&  �&  �N'  X'  * ^'  n'  d'  t'  ��'  �'  ��'  ��'  (  (  t)  �)  *  2*  n*  v*  X+  j+  �+  �+  �>(  �)  �)  �)  @*  `*  �*  �*  �*  x+  �+  �+  �+  �+  ! B(  5 F(  Hr(  ~(  �(  m<)  yJ)  V)  �p)  ��)  ��)  �)  � *  	 j*   �*   �*  G �*  �*  T �*  �*  _�*  z�*  r +  +  �+  +  0+  F+  � *+  @+  �N+  \+  �+  �+  � �+  ��+  i�+  �,  ��+  �,  � ,  �0  �,  ",  *,  6,  P,  �,  V,  `,  ~t,  � �,  :0  ��,  �-  0  )0  ,0  g2  �
2  �2  l 2  w 2  ^2  } 2  � "2   V2  r2   Z2  � b2  ��2  �2  � �2  