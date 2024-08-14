// This is an Unreal Script
class TAW_UIAmbushHUD extends UIScreenListener;

var bool activate;

event OnInit(UIScreen Screen) {
	local UITacticalHUD TacticalHUD;

	local UIIcon Icon;

	TacticalHUD = UITacticalHUD(Screen);

	if(TacticalHUD != none) {
		if(TacticalHUD.m_kMouseControls != none) {
			Icon = TacticalHUD.m_kMouseControls.Spawn(class'UIIcon', TacticalHUD.m_kMouseControls).InitIcon('ambushToggleIcon', "img:///UILibrary_PerkIcons.UIPerk_ambush", false, true, 36);
			Icon.ProcessMouseEvents(OnChildMouseEvent);
			Icon.bDisableSelectionBrackets = true;
			Icon.EnableMouseAutomaticColor(class'UIUtilities_Colors'.const.GOOD_HTML_COLOR, class'UIUtilities_Colors'.const.BLACK_HTML_COLOR);

			Icon.OriginTopRight();
			Icon.AnchorTopRight();
			Icon.SetPosition(-360, 4);
			Icon.Show();

			activate = false;
		}
	}
}

simulated function OnChildMouseEvent(UIPanel ChildControl, int cmd) {
	if(cmd == class'UIUtilities_Input'.const.FXS_L_MOUSE_UP) {
		OnClickedCallback(ChildControl);
	}
	else if(cmd == class'UIUtilities_Input'.const.FXS_L_MOUSE_IN) {
		ChildControl.OnReceiveFocus();
	}
	else if(cmd == class'UIUtilities_Input'.const.FXS_L_MOUSE_OUT) {
		ChildControl.OnLoseFocus();
	}
}

simulated function OnClickedCallback(UIPanel ChildControl){
	local UIIcon Icon;
	
	activate = !activate;
	Icon = UIIcon(ChildControl);
	
	Icon.LoadIcon(activate ? "img:///TrueAmbushWotcAssets.UIPerk_ambushcancel" : "img:///UILibrary_PerkIcons.UIPerk_ambush");
}