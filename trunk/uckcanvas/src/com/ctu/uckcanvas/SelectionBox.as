package com.ctu.uckcanvas
{
	import mx.containers.Canvas;
	import nl.fxc.skins.FXCDashedBorder; // dashed border skin
	
	public class SelectionBox extends Canvas
	{
		public function SelectionBox()
		{
			super();
			width =1;
			height =1;
			setStyle( "borderColor", "#000000" );
			setStyle( "borderStyle", "solid" );
			setStyle( "borderThickness", 1 );
			setStyle("borderSkin", nl.fxc.skins.FXCDashedBorder);
			clipContent  = false;			
		}
		
	}
}