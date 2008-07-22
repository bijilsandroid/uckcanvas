package com.ctu.uckcanvas
{
	import flash.display.Bitmap;
	import mx.controls.Image;
	
	public class ImageHandle extends Handle {
		public function ImageHandle(type:String, image:Class) {
			super(type);
			var bm:Bitmap = new image();
			addChild(bm);
			
			width = bm.width;
			height = bm.height;
			bm.x = 0;
			bm.y = 0;
		}
		
		public override function draw():void {
       		
		}
		
	}
}