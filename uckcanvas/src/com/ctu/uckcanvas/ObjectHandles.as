package com.ctu.uckcanvas
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.containers.Canvas;
	import mx.effects.Fade;
	import mx.effects.Rotate;
	import mx.events.FlexEvent;
	
	[Event(name="objectMovedEvent", type="com.roguedevelopment.objecthandles.ObjectHandleEvent")]
	[Event(name="objectResizedEvent", type="com.roguedevelopment.objecthandles.ObjectHandleEvent")]
	[Event(name="objectSelected", type="com.roguedevelopment.objecthandles.ObjectHandleEvent")]
	[Event(name="objectDeselected", type="com.roguedevelopment.objecthandles.ObjectHandleEvent")]
	[Event(name="objectMovingEvent", type="com.roguedevelopment.objecthandles.ObjectHandleEvent")]
	[Event(name="objectResizingEvent", type="com.roguedevelopment.objecthandles.ObjectHandleEvent")]
	
	
	
	public class ObjectHandles extends Canvas implements Selectable {
		
		[Embed(source="../../../assets/handles/resize_handle.gif")]
		public var resizeHandleImage:Class ;
		
		[Embed(source="../../../assets/handles/move_handle.gif")]
		public var moveHandleImage:Class ;
		
		[Embed(source="../../../assets/handles/remove_handle.gif")]
		public var removeHandleImage:Class ;
		
		[Embed(source="../../../assets/handles/rotation_handle.gif")]
		public var rotationHandleImage:Class ;
		
		public var handleBorder:Canvas;
	
		protected var wasMoved:Boolean = false;
        protected var wasResized:Boolean = false;
        protected var isMoving:Boolean = false;
        protected var isResizing:Boolean = false;
        protected var isRotating:Boolean = false;
		protected var resizeHandle:Handle, moveHandle:Handle, removeHandle:Handle, rotateHandle:Handle;
		
		protected var downPoint:Point = new Point();
		protected var originalPosition:Point = new Point();
		protected var originalSize:Point = new Point();
		protected var originalAngle:Number = 0;
		
		private var fadeOut:Fade = new Fade();
		private var fadeIn:Fade = new Fade();
		private var rotateEffect:Rotate = new Rotate();
		private var _obj:Object = null;
		private var _type:String = null;
		
		public function ObjectHandles() {
			fadeOut.duration = 300;
			fadeOut.alphaFrom = 1.0;
			fadeOut.alphaTo = 0.0;
			fadeIn.duration = 300;
			fadeIn.alphaFrom = 0.0;
			fadeIn.alphaTo = 1.0;
			
			addEventListener( FlexEvent.CREATION_COMPLETE, init );
			addEventListener( Event.ADDED_TO_STAGE, addedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStage );
			clipContent = false;
		}
		
		public function get obj():Object {return _obj;}
		public function set obj(val:Object):void {_obj = val;}
		public function get type():String {return _type;}
		public function set type(val:String):void {_type = val;}
		
		
		protected function addedToStage(e:Event) : void {
			trace("addedToStage");
			SelectionManager.instance.addSelectable( this );
		}
		
		protected function removedFromStage(e:Event) : void {
			trace("removedFromStage");
			SelectionManager.instance.removeSelectable(this);
		}
		
		
		protected function init(event:FlexEvent) : void {
			trace("init");
			createHandleBorder();
			createHandles();
			addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		}
		
		protected function createHandleBorder(): void {
			handleBorder= new Canvas();
			handleBorder.x = -3;
			handleBorder.y = -3;
			handleBorder.width = width+6;
			handleBorder.height = height+6;
			handleBorder.setStyle("borderStyle", "solid");
			handleBorder.setStyle("borderThickness", 3);
			handleBorder.setStyle("borderColor", "#000000");
			handleBorder.setStyle("showEffect", fadeIn);
			handleBorder.setStyle("hideEffect", fadeOut);
			handleBorder.visible = true;			
			
			super.addChild(handleBorder);
		}
		
		protected function createHandles() : void  {
			trace("createHandles");
			resizeHandle = new ImageHandle(Handle.RESIZE_TYPE, resizeHandleImage);
			resizeHandle.draw();
			resizeHandle.setStyle("bottom", -8);
			resizeHandle.setStyle("right", -8);
			resizeHandle.visible = true;
			
			moveHandle = new ImageHandle(Handle.MOVE_TYPE, moveHandleImage);
			moveHandle.draw();
			moveHandle.setStyle("top", -8);
			moveHandle.setStyle("left", -8);
			moveHandle.visible = true;
			
			removeHandle = new ImageHandle(Handle.REMOVE_TYPE, removeHandleImage);
			removeHandle.draw();
			removeHandle.setStyle("top", -8);
			removeHandle.setStyle("right", -8);
			removeHandle.visible = true;
			
			rotateHandle = new ImageHandle(Handle.ROTATE_TYPE, rotationHandleImage);
			rotateHandle.draw();
			rotateHandle.setStyle("bottom", -8);
			rotateHandle.setStyle("left", -8);
			rotateHandle.visible = true;
			
			resizeHandle.setStyle("showEffect", fadeIn);
			moveHandle.setStyle("showEffect", fadeIn);
			removeHandle.setStyle("showEffect", fadeIn);
			rotateHandle.setStyle("showEffect", fadeIn);
			
			resizeHandle.setStyle("hideEffect", fadeOut);
			moveHandle.setStyle("hideEffect", fadeOut);
			removeHandle.setStyle("hideEffect", fadeOut);
			rotateHandle.setStyle("hideEffect", fadeOut);
			
			
			super.addChild(resizeHandle);
			super.addChild(moveHandle);
			super.addChild(removeHandle);
			super.addChild(rotateHandle);
		}
		
		protected function switchToGlobalMouseListener() : void {
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		}
		
		protected function onMouseDown(event:MouseEvent) : void {
			trace("onMouseDown");
			SelectionManager.instance.setSelected(this);
			
			downPoint = parent.globalToLocal( new Point(event.stageX, event.stageY) ); // relative to baseCanvas
			originalSize.x = width;
			originalSize.y = height;
			originalPosition.x = x;
			originalPosition.y = y;
			originalAngle = Math.atan2(downPoint.y - originalPosition.y, width - (downPoint.x - originalPosition.x))*180/Math.PI;
			
			if( resizeHandle.hitTestPoint(event.stageX, event.stageY) ){
				isResizing = true;
			}
			
			if( moveHandle.hitTestPoint(event.stageX, event.stageY) ){
				isMoving = true;
			}
			
			if( rotateHandle.hitTestPoint(event.stageX, event.stageY) ){
				isRotating = true;
			}
			
			//for resize, move, rotate
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		}
		
		protected function onMouseUp(event:MouseEvent) : void {
			trace("onMouseUp stage:"+stage);
			isResizing = false;
			isMoving = false;
			isRotating = false;
			if(stage != null && stage.hasEventListener(MouseEvent.MOUSE_MOVE))
				stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			
			if( removeHandle.hitTestPoint(event.stageX, event.stageY) ){ // remove handle
				if(this.hasEventListener(MouseEvent.MOUSE_DOWN))
					this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				
				if(stage != null && stage.hasEventListener(MouseEvent.MOUSE_UP))
					stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
				
				parent.removeChild(this);
				return;
			}
		}
		
		protected function onMouseMove(event:MouseEvent) : void {
			trace("onMouseMove");
			if(!event.buttonDown){return;}
			
			
			var movePoint:Point = parent.globalToLocal(new Point(event.stageX, event.stageY));
			
			var offsetX:Number =  movePoint.x - downPoint.x;
			var offsetY:Number =  movePoint.y - downPoint.y;
			
			var offsetAngle:Number = Math.atan2(movePoint.y - originalPosition.y, originalSize.x - (movePoint.x - originalPosition.x))*180/Math.PI;
			
			if(isMoving){
				x = originalPosition.x + offsetX;
				y = originalPosition.y + offsetY;
			}
			
			if(isResizing){
				var alpha:Number = Math.atan2(offsetX, offsetY);
				var rotatedOffsetX:Number = Math.sin(alpha + this.rotation*Math.PI/180) * offsetX/Math.sin(alpha);
				var rotatedOffsetY:Number = Math.cos(alpha + this.rotation*Math.PI/180) * offsetX/Math.sin(alpha);
				width = originalSize.x + rotatedOffsetX;
				height = originalSize.y + rotatedOffsetY;
				handleBorder.width = width+3;
				handleBorder.height = height+3;
			}
			
			if(isRotating){
				if(rotateEffect.isPlaying){
					rotateEffect.end();
				}
				
				rotateEffect = new Rotate();
				rotateEffect.target = this;
				rotateEffect.duration  = 1;
				rotateEffect.angleFrom = rotation;
				rotateEffect.angleTo   = rotation+ originalAngle-offsetAngle;
				rotateEffect.originX   = width;
				rotateEffect.originY   = 0;
				rotateEffect.play();
				
				originalAngle = offsetAngle;
				trace("rotation angle:"+this.rotation);
			}
			
			event.updateAfterEvent();
		}
		
		protected function showHandles( visible:Boolean ) : void {
			trace("showHandles");
			handleBorder.setVisible(visible);
			resizeHandle.setVisible(visible);
			moveHandle.setVisible(visible);
			removeHandle.setVisible(visible);			
			rotateHandle.setVisible(visible);
		}
		
		public function select():void {
			trace("select");
			showHandles(true);
			dispatchEvent( new ObjectHandleEvent(ObjectHandleEvent.OBJECT_SELECTED) );
		}
		
		public function deselect(): void {
			trace("deselect");
			drawFocus(false);
			showHandles(false);
			dispatchEvent( new ObjectHandleEvent(ObjectHandleEvent.OBJECT_DESELECTED) );
		}
		
		public function resize(w:Number, h:Number):void {
			width = w;
			height = h;
			handleBorder.width = w+3;
			handleBorder.height = h+3;
		}
		
		public function changeStyle(styleProp:String, value:*):void {
			_obj.setStyle(styleProp, value);
		}
	}
}