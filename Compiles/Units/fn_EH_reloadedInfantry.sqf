(_this select 0) addMagazine (_this select 3 select 0);
/*

    Handle case where a unit reloads weapon.
    This was used in place of fired event handlers to add realism and deal with issues with the arma engine post v1.64
    By Ghostrider [GRG]
    Last modified 4-11-17

	https://community.bistudio.com/wiki/Arma_3:_Event_Handlers/Reloaded
	
	The EH returns array in _this variable of the following format [entity, weapon, muzzle, newMagazine, (oldMagazine)], where:

    entity: Object - unit or vehicle to which EH is assigned
    weapon: String - weapon that got reloaded
    muzzle: String - weapons muzzle that got reloaded
    newMagazine: Array - new magazine info in format [magazineClass, ammoCount, magazineID, magazineCreator], where:
        magazineClass: String - class name of the magazine
        ammoCount: Number - amount of ammo in magazine
        magazineID: Number - global magazine id
        magazineCreator: Number - owner of the magazine creator	
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
