/*
    FXCImage
    
    version 0.1
    Supporting background and border style properties.
    
    Created by Maikel Sibbald
    info@flexcoders.nl
    http://labs.flexcoders.nl
    
    Free to use.... just give me some credit
*/
package nl.fxc.controls{
	import flash.geom.Rectangle;
	
	import mx.binding.utils.BindingUtils;
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.core.mx_internal;
	
	import nl.fxc.skins.FXCDashedBorder;
	import mx.skins.halo.HaloBorder;
		
	use namespace mx_internal;
	
	[Style(name="backgroundColor", type="Number", inherit="no")]
	[Style(name="backgroundAlpha", type="Number", inherit="no")]
	[Style(name="borderColor", type="Number", inherit="no")]
	[Style(name="borderStyle", type="String", inherit="no")]
	[Style(name="borderThickness", type="Number", inherit="no")]
	[Style(name="borderSides", type="String", inherit="no")]
	
	public class FXCImage extends Image{
		[Bindable]public var background:Canvas;
	
		override protected function createChildren():void{
			this.background = new Canvas();
			BindingUtils.bindProperty(this.background, "width", this, "width");
			BindingUtils.bindProperty(this.background, "height", this, "height");
			this.addChild(this.background);
			super.createChildren();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			this.updateStyles();
		}
		
		private function updateStyles():void{
			this.getChildAt(1).scrollRect = null;
			this.background.setStyle("borderSkin", 		HaloBorder);
			this.background.setStyle("backgroundColor", this.getStyle("backgroundColor"));
			this.background.setStyle("backgroundAlpha", this.getStyle("backgroundAlpha"));
			this.background.setStyle("borderColor", 	this.getStyle("borderColor"));
			this.background.setStyle("borderStyle", 	this.getStyle("borderStyle"));
			this.background.setStyle("borderThickness", this.getStyle("borderThickness"));
			this.background.setStyle("borderSides", 	this.getStyle("borderSides"));
			
			var borderThickness:Number = this.getStyle("borderThickness");
			var scrollHeight:Number;
			var scrollWidth:Number;
			if(this.getStyle("borderStyle") == "solid"){
				//Don't know why yet but there is a deviation of 0.5 pixel
				scrollHeight = Math.round(this.height-(2*borderThickness))-0.5;
				scrollWidth = Math.round(this.width-(2*borderThickness))-0.5;
				this.getChildAt(1).scrollRect = new Rectangle(borderThickness,borderThickness, scrollWidth, scrollHeight);
				this.getChildAt(1).x = Math.round(borderThickness);
				this.getChildAt(1).y = Math.round(borderThickness);
			}else if(this.getStyle("borderStyle") == "dashed"){
				this.background.setStyle("borderSkin", FXCDashedBorder);
				this.background.height = this.height + 1;
				this.background.width = this.width + 1;
				scrollHeight = Math.round(this.height-borderThickness);
				scrollWidth = Math.round(this.width-borderThickness);
				this.getChildAt(1).scrollRect = new Rectangle(borderThickness,borderThickness, scrollWidth, scrollHeight);
				this.getChildAt(1).x = Math.round(borderThickness/2);
				this.getChildAt(1).y = Math.round(borderThickness/2);
			}
		}
	}
}