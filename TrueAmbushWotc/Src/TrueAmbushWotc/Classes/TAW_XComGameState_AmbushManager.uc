// This is an Unreal Script
class TAW_XComGameState_AmbushManager extends XComGameState_BaseObject;

var bool ambushActive;

static function bool ToggleAmbush() {
	return SetAmbushMode(!GetManager().ambushActive);
}

static function bool SetAmbushMode(bool shouldBActive) {
	local XComGameState ChangeState;
	local TAW_XComGameState_AmbushManager Manager;

	Manager = GetManager();

	ChangeState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Set Ambush Mode");

	Manager = TAW_XComGameState_AmbushManager(ChangeState.CreateStateObject(class'TAW_XComGameState_AmbushManager', Manager.ObjectID));
	ChangeState.AddStateObject(Manager);
	Manager.ambushActive = shouldBActive;

	`XEVENTMGR.TriggerEvent(shouldBActive ? 'AmbushModeActivated' : 'AmbushModeDeactivated', Manager, Manager, ChangeState);
	`GAMERULES.SubmitGameState(ChangeState);
	return Manager.ambushActive;
}

static function TAW_XComGameState_AmbushManager GetManager() {
	local XComGameStateHistory History;
	local TAW_XComGameState_AmbushManager Manager;
	local XComGameState ChangeState;

	History = `XCOMHISTORY;
	Manager = TAW_XComGameState_AmbushManager(History.GetSingleGameStateObjectForClass(class'TAW_XComGameState_AmbushManager', true));

	if(Manager == none) {
		ChangeState = class'XcomGameStateContext_ChangeContainer'.static.CreateChangeState("Create Ambush Manager");
		Manager = TAW_XComGameState_AmbushManager(ChangeState.CreateStateObject(class'TAW_XComGameState_AmbushManager'));
		ChangeState.AddStateObject(Manager);
		`GAMERULES.SubmitGameState(ChangeState);
	}

	return Manager;
}