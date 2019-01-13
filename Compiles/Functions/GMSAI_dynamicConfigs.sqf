/*
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

//#include "\q\addons\custom_server\Configs\GMSAI_defines.hpp";

GMSAI_blacklistedVests = [

];

GMSAI_blacklistedUniforms = [

];

GMSAI_blacklistedBackpacks = [

];

GMSAI_blacklistedHeadgear = [

];

GMSAI_blacklistedPrimaryWeapons = [

];

GMSAI_blacklistedSecondaryWeapons = [

];

GMSAI_blacklistedLaunchersAndSwingWeapons = [

];

GMSAI_blacklistedOptics = [

];

GMSAI_blacklistedAttachments = [

];

GMSAI_blacklistedItems = [

];

GMSAI_headgearList = [];
GMSAI_SkinList = [];
GMSAI_vests = [];
GMSAI_backpacks = [];
GMSAI_Pistols = [];
GMSAI_primaryWeapons = [];
//GMSAI_throwable = [];

_allWeaponRoots = ["Pistol","Rifle","Launcher"];
_allWeaponTypes = ["AssaultRifle","MachineGun","SniperRifle","Shotgun","Rifle","Pistol","SubmachineGun","Handgun","MissileLauncher","RocketLauncher","Throw","GrenadeCore"];
_addedBaseNames = [];
_allBannedWeapons = [];
_wpnAR = []; //Assault Rifles
_wpnARG = []; //Assault Rifles with GL
_wpnLMG = []; //Light Machine Guns
_wpnSMG = []; //Sub Machine Guns
_wpnDMR = []; //Designated Marksman Rifles
_wpnLauncher = [];
_wpnSniper = []; //Sniper rifles
_wpnHandGun = []; //HandGuns/Pistols
_wpnShotGun = []; //Shotguns
_wpnThrow = []; // throwables
_wpnUnknown = []; //Misc
_wpnUnderbarrel = [];
_wpnMagazines = [];
_wpnOptics = [];
_wpnPointers = [];
_wpnMuzzles = [];
_allBannedWearables = [];
_uniforms = [];
_headgear = []; 
_glasses = []; 
_masks = []; 
_backpacks = []; 
_vests = [];
_goggles = []; 
_NVG = []; 
_misc = [];
_baseClasses = [];	

_classnameList = [];
/*
//diag_log format["GMSAI_modType = %1",GMSAI_modType];
if (toLower(GMSAI_modType) isEqualTo "epoch") then
{
	_classnameList = (missionConfigFile >> "CfgPricing" ) call BIS_fnc_getCfgSubClasses;
};
if (toLower(GMSAI_modType) isEqualTo "exile") then
{
	_classnameList = (missionConfigFile >> "CfgExileArsenal" ) call BIS_fnc_getCfgSubClasses;
};
*/
//diag_log format["_fnc_dynamicConfigsConfigurator: count _classnameList = %1",count _classnameList];
{
	private _temp = [_x] call bis_fnc_itemType;
	//diag_log _temp;
	_itemCategory = _temp select 0;
	_itemType = _temp select 1;
	_price = GMSAI_maximumItemPriceInAI_Loadouts;
	if (toLower(GMSAI_modType) isEqualTo "epoch") then
	{
		_price = getNumber(missionConfigFile >> "CfgPricing" >> _x >> "price");
	};
	if (toLower(GMSAI_modType)  isEqualTo "exile") then
	{
		_price = getNumber(missionConfigFile >> "CfgExileArsenal" >> _x >> "price");
	};
	if (_price < GMSAI_maximumItemPriceInAI_Loadouts) then
	{
	if (_itemCategory isEqualTo "Weapon") then
	{
		switch (_itemType) do
		{
			case "AssaultRifle": {if !(_x in GMSAI_blacklistedSecondaryWeapons) then {_wpnAR pushBack _x}};
			case "MachineGun": {if !(_x in GMSAI_blacklistedSecondaryWeapons) then {_wpnLMG pushBack _x}};
			case "SubmachineGun": {if !(_x in GMSAI_blacklistedSecondaryWeapons) then {_wpnSMG pushBack _x}};
			case "Shotgun": {if !(_x in GMSAI_blacklistedSecondaryWeapons) then {_wpnShotGun pushBack _x}};
			case "Rifle": {if !(_x in GMSAI_blacklistedSecondaryWeapons) then {_wpnAR pushBack _x}};
			case "SniperRifle": {if !(_x in GMSAI_blacklistedSecondaryWeapons) then {_wpnSniper pushBack _x}};
			case "Handgun": {if !(_x in GMSAI_blacklistedSecondaryWeapons) then {_wpnHandGun pushBack _x}};
			case "Launcher": {if !(_x in GMSAI_blacklistedLaunchersAndSwingWeapons) then {_wpnLauncher pushBack _x}};
			case "RocketLauncher": {if !(_x in GMSAI_blacklistedLaunchersAndSwingWeapons) then {_wpnLauncher pushBack _x}};
			case "Throw": {if !(_x in GMSAI_blacklistedItems) then {_wpnThrow pushBack _x}};
		};
	};
	
	if (_itemCategory isEqualTo "Item") then
	{
		switch (_itemType) do
		{
			case "AccessoryMuzzle": {if !(_x in GMSAI_blacklistedAttachments) then {_wpnMuzzles pushBack _x}};
			case "AccessoryPointer": {if !(_x in GMSAI_blacklistedAttachments) then {_wpnPointers pushBack _x}};
			case "AccessorySights": {if !(_x in GMSAI_blacklistedOptics) then {_wpnOptics pushBack _x}};
			case "AccessoryBipod": {if !(_x in GMSAI_blacklistedAttachments) then {_wpnUnderbarrel pushBack _x}};
			case "Binocular": {if !(_x in GMSAI_blacklistedItems) then {_misc pushBack _x}};
			case "Compass": {if !(_x in GMSAI_blacklistedItems) then {_misc pushBack _x}};
			case "GPS": {if !(_x in GMSAI_blacklistedItems) then {_misc pushBack _x}};
			case "NVGoggles": {if !(_x in GMSAI_blacklistedItems) then {_NVG pushBack _x}};		
		};
	};
	
	
	if (_itemCategory isEqualTo "Equipment") then
	{
		switch (_itemType) do
		{
			case "Glasses": {if !(_x in GMSAI_blacklistedItems) then {_glasses pushBack _x}};
			case "Headgear": {if !(_x in GMSAI_blacklistedHeadgear) then {_headgear pushBack _x}};
			case "Vest": {if !(_x in GMSAI_blacklistedVests) then {_vests pushBack _x}};
			case "Uniform": {if !(_x in GMSAI_blacklistedUniforms) then {_uniforms pushBack _x}};
			case "Backpack": {if !(_x in GMSAI_blacklistedBackpacks) then {_backpacks pushBack _x}};
		};
	};
	};
} forEach _classnameList;

GMSAI_primaryWeapons = _wpnAR + _wpnLMG + _wpnSMG + _wpnShotGun + _wpnSniper;
GMSAI_WeaponList_Blue = GMSAI_primaryWeapons;
GMSAI_WeaponList_Red = GMSAI_primaryWeapons;
GMSAI_WeaponList_Green = GMSAI_primaryWeapons;
GMSAI_WeaponList_Orange = GMSAI_primaryWeapons;

GMSAI_pistols = _wpnHandGun;
GMSAI_Pistols_blue = GMSAI_Pistols;
GMSAI_Pistols_red = GMSAI_Pistols;
GMSAI_Pistols_green = GMSAI_Pistols;
GMSAI_Pistols_orange = GMSAI_Pistols;

GMSAI_headgearList = _headgear;
GMSAI_headgear_blue = GMSAI_headgearList;
GMSAI_headgear_red = GMSAI_headgearList;
GMSAI_headgear_green = GMSAI_headgearList;
GMSAI_headgear_orange = GMSAI_headgearList;
	
GMSAI_SkinList = _uniforms;
GMSAI_SkinList_blue = GMSAI_SkinList;
GMSAI_SkinList_red = GMSAI_SkinList;
GMSAI_SkinList_green = GMSAI_SkinList;
GMSAI_SkinList_orange = GMSAI_SkinList;

GMSAI_vests = _vests;
GMSAI_vests_blue = GMSAI_vests;
GMSAI_vests_red = GMSAI_vests;
GMSAI_vests_green = GMSAI_vests;
GMSAI_vests_orange = GMSAI_vests;

GMSAI_backpacks = _backpacks;
GMSAI_backpacks_blue = GMSAI_backpacks;
GMSAI_backpacks_red = GMSAI_backpacks;
GMSAI_backpacks_green = GMSAI_backpacks;
GMSAI_backpacks_orange = GMSAI_backpacks;
	
GMSAI_explosives = 	_wpnThrow;

diag_log format["Compilation of dynamic AI Loadouts complete at %1",diag_tickTime];