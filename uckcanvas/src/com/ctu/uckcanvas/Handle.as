/**
 * Selection Handle
 **/

package com.ctu.uckcanvas
{
	import mx.core.UIComponent;
	
	public class Handle extends UIComponent {
		public static const RESIZE_TYPE:String = "resizeType";
		public static const REMOVE_TYPE:String = "removeType";
		public static const MOVE_TYPE:String = "moveType";
		public static const ROTATE_TYPE:String = "rotateType";
		
		private var _handleType:String = RESIZE_TYPE;
		
		public function Handle(type:String) {
			super();
			if(type != null) _handleType = type;
			width = 10;
			height = 10;
			//draw();
		}
		
		public function get handleType():String {
			return _handleType;
		}
		
		public function draw(): void {
			trace("draw!!!");
			graphics.clear();
			//TODO more appealing graphics
			if(_handleType == REMOVE_TYPE) {
				
				graphics.beginFill(0x888888);
				graphics.drawRect(0,0,10,10);
				graphics.endFill();
				
				graphics.lineStyle(1,0xFF0000);
				graphics.moveTo(3,3);
				graphics.lineTo(8,8 );
				graphics.moveTo(8,3);
				graphics.lineTo(3,8 );
				return;
			} 
			graphics.beginFill(0x888888);
			graphics.drawRect(0,0,10,10);
			graphics.endFill();
		}

	}
}