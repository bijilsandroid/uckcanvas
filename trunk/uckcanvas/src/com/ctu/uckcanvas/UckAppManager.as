package com.ctu.uckcanvas
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.containers.Canvas;
	import mx.containers.ViewStack;
	import mx.controls.Image;
	import mx.controls.TextArea;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	import mx.styles.CSSStyleDeclaration;

	public class UckAppManager {
		protected var baseCanvas:Canvas = null; 
		protected var propertyBar:ViewStack = null;
		protected var selectionBox:SelectionBox = null;
		protected var rectObj:Canvas = null;
		protected var isSelecting:Boolean = false;
		protected var penLineCanvas:UIComponent = null;
		protected var penLine:Sprite = null;
		protected var penRect:Rectangle = null;
		public var imagePoint:Point = new Point();
		
		public function UckAppManager(bc:Canvas, pb:ViewStack) {
			baseCanvas = bc;
			propertyBar = pb;
		}

		public function selectionTool():void {
			trace("selectionTool");
			// remove text tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawTextBox);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawTextBox);
			}
			// remove image tool
			if(baseCanvas.hasEventListener(MouseEvent.CLICK)){
				baseCanvas.removeEventListener(MouseEvent.CLICK, showUploadForm);
			}
			// remove rectangle tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawRect);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawRect);
			}
			// remove pen tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawPen);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawPen);
			}
			
			baseCanvas.addEventListener(MouseEvent.MOUSE_DOWN, startDrawSelBox);
 			baseCanvas.addEventListener(MouseEvent.MOUSE_UP, endDrawSelBox);
 			
 			//propertyBar.selectedIndex = 0;
		}
		
		public function textTool():void {
			trace("textTool!");
			// remove selection tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawSelBox);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawSelBox);
			}
			// remove image tool
			if(baseCanvas.hasEventListener(MouseEvent.CLICK)){
				baseCanvas.removeEventListener(MouseEvent.CLICK, showUploadForm);
			}
			// remove rectangle tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawRect);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawRect);
			}
			// remove pen tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawPen);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawPen);
			}
			
			baseCanvas.addEventListener(MouseEvent.MOUSE_DOWN, startDrawTextBox);
			baseCanvas.addEventListener(MouseEvent.MOUSE_UP, endDrawTextBox);
			
 			propertyBar.selectedIndex = 1;
		}
		
		public function penTool(): void {
			trace("penTool");
			// remove selection tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawSelBox);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawSelBox);
			}
			// remove text tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawTextBox);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawTextBox);
			}
			// remove image tool
			if(baseCanvas.hasEventListener(MouseEvent.CLICK)){
				baseCanvas.removeEventListener(MouseEvent.CLICK, showUploadForm);
			}
			// remove rectangle tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawRect);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawRect);
			}
			
			baseCanvas.addEventListener(MouseEvent.MOUSE_DOWN, startDrawPen);
			baseCanvas.addEventListener(MouseEvent.MOUSE_UP, endDrawPen);
			
 			propertyBar.selectedIndex = 2;
		}
		
		public function rectTool():void {
			trace("recTool");
			// remove selection tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawSelBox);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawSelBox);
			}
			// remove text tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawTextBox);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawTextBox);
			}
			// remove pen tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawPen);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawPen);
			}
			// remove image tool
			if(baseCanvas.hasEventListener(MouseEvent.CLICK)){
				baseCanvas.removeEventListener(MouseEvent.CLICK, showUploadForm);
			}
			
			baseCanvas.addEventListener(MouseEvent.MOUSE_DOWN, startDrawRect);
			baseCanvas.addEventListener(MouseEvent.MOUSE_UP, endDrawRect);
			
 			propertyBar.selectedIndex = 3;
		}
		
		public function imageTool():void {
			trace("imageTool");
			// remove selection tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawSelBox);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawSelBox);
			}
			// remove text tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawTextBox);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawTextBox);
			}
			// remove pen tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawPen);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawPen);
			}
			// remove rectangle tool
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_DOWN)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawRect);
			}
			if(baseCanvas.hasEventListener(MouseEvent.MOUSE_UP)){
				baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawRect);
			}
			
			baseCanvas.addEventListener(MouseEvent.CLICK, showUploadForm);
 			
 			propertyBar.selectedIndex = 4;
		}
		
		public function clearCanvas():void {
			trace("clearCanvas");
			//TODO clean up listener and other garbages!
			baseCanvas.removeAllChildren();
		}
		
		private function startDrawSelBox(event:MouseEvent):void{
			trace("start of startDrawSelBox");
			if(event.eventPhase != EventPhase.AT_TARGET){
				event.stopPropagation();
				return;
			}
			
			deselectAll(event);
			selectionBox = new SelectionBox();
			selectionBox.x = baseCanvas.mouseX;
			selectionBox.y = baseCanvas.mouseY;
		
			baseCanvas.addChild(selectionBox);
			baseCanvas.addEventListener(MouseEvent.MOUSE_MOVE, drawSelBox); // draw selection box
		}
		
		private function drawSelBox(event:MouseEvent):void {
			trace("drawSelBox");
			selectionBox.width = selectionBox.mouseX;
			selectionBox.height = selectionBox.mouseY;
			event.updateAfterEvent();
		}
		
		private function endDrawSelBox(event:MouseEvent):void {
			trace("endDrawSelBox");
			if(selectionBox ) {
				selectArea(event);
				baseCanvas.removeChild(selectionBox);
				selectionBox = null;
			}
			baseCanvas.removeEventListener(MouseEvent.MOUSE_MOVE, drawSelBox);
		}
		
		private function selectArea(event:MouseEvent):void {
			trace("selectArea");
			var selectables:Array = SelectionManager.instance.getItems();
			for each(var selectable:ObjectHandles in selectables){
					var extendX:Number = selectable.x - selectionBox.x + selectable.width;
					var extendY:Number = selectable.y - selectionBox.y + selectable.height;
					if(selectionBox.x <= selectable.x && selectionBox.y <= selectable.y && extendX <= selectionBox.width && extendY <= selectionBox.height){
						SelectionManager.instance.setSelected(selectable, false);
					}
			}
		}

		
		
		public function startDrawTextBox(event:MouseEvent): void {
			trace("startDrawTextBox!!");
			var textObjHandles: ObjectHandles = new ObjectHandles();
			
			textObjHandles.x = baseCanvas.mouseX;
			textObjHandles.y = baseCanvas.mouseY;
			textObjHandles.width = 100;
			textObjHandles.height = 50;
			
			var textObj: TextArea = new TextArea();
			textObj.text = "type here..";
			textObjHandles.obj = textObj;
			textObjHandles.addChild(textObj);
			textObj.setStyle("borderThickness", 0);
			textObj.setStyle("backgroundAlpha", 0.0);
			textObj.setStyle("focusAlpha", 0); 
			textObj.setStyle("fontFamily", "EmbeddedTahoma");
			textObj.setStyle("fontSize", 18);
			textObj.percentHeight = 100;
			textObj.percentWidth = 100;
			baseCanvas.addChild(textObjHandles);
		}
		
		public function endDrawTextBox(event:MouseEvent): void {
			baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawTextBox);
			baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawTextBox);
			selectionTool();
		}
		
		public function deselectAll(event:MouseEvent):void {
			trace("deselectAll + isSelecting:"+isSelecting);
			//if(event.eventPhase == EventPhase.AT_TARGET && !isSelecting){
				
				SelectionManager.instance.selectNone();
			//}
		}

		private function startDrawPen(event:MouseEvent):void {
			penLineCanvas = new UIComponent();
			penLineCanvas.x = 0;
			penLineCanvas.y = 0;
			penLine = new Sprite();
			penLineCanvas.addChild(penLine);
			baseCanvas.addChild(penLineCanvas);
			
			penLine.graphics.lineStyle(2, 0x00FF00);
			penLine.graphics.moveTo(baseCanvas.mouseX, baseCanvas.mouseY);
			baseCanvas.addEventListener(MouseEvent.MOUSE_MOVE, drawPen);
		}
		
		private function drawPen(event:MouseEvent):void {
			trace("drawPen");
			//penLineCanvas.graphics.lineTo(baseCanvas.mouseX, baseCanvas.mouseY);
			penLine.graphics.lineTo(baseCanvas.mouseX, baseCanvas.mouseY);
		}
		
		private function endDrawPen(event:MouseEvent):void {
			trace("penLineCanvas!!!");
			baseCanvas.removeEventListener(MouseEvent.MOUSE_MOVE, drawPen);
			var bounds:Rectangle = penLine.getBounds(baseCanvas);
			var penHandle:ObjectHandles = new ObjectHandles();
			penHandle.x = bounds.x;
			penHandle.y = bounds.y;
			penHandle.width = bounds.width;
			penHandle.height = bounds.height;
			
			penHandle.obj = penLineCanvas;
			penHandle.addChild(penLineCanvas);
			penLineCanvas.x = - bounds.x;
			penLineCanvas.y = - bounds.y;
			
			baseCanvas.addChild(penHandle);
			
			baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawPen);
			baseCanvas.removeEventListener(MouseEvent.MOUSE_UP, endDrawPen);
			
			selectionTool();
		}
		
		private function showUploadForm(event:MouseEvent): void {
			trace("showUploadForm");
			trace(baseCanvas.parent);
			var imageUploadWin:ImageUploadWin = ImageUploadWin(PopUpManager.createPopUp(baseCanvas.parent, ImageUploadWin, true));
			imageUploadWin.x = event.stageX;
			imageUploadWin.y = event.stageY;
			imageUploadWin.callBack = loadImage;
			imagePoint.x = event.stageX;
			imagePoint.y = event.stageY;
			
		}
		
		public function loadImage(url:String): void {
			trace("loadImage");
			var img:Image = new Image();
			img.maintainAspectRatio = false;
			img.addEventListener(Event.COMPLETE, createImage);
			img.load(url);
		}
		
		public function createImage(event:Event):void {
			trace("createImage");
			var img:Image = Image(event.target);
			var width:Number = 200, height:Number = 100;
			var textObjHandles: ObjectHandles = new ObjectHandles();
			
			if(img.content.width > width) {
				height = img.content.height * (200/img.content.width);
			} else {
				width = img.content.width;
				height = img.content.height;	
			}
			
			textObjHandles.width = width;
			textObjHandles.height = height;
			textObjHandles.x = imagePoint.x;
			textObjHandles.y = imagePoint.y;
			textObjHandles.obj = img; 
			textObjHandles.addChild(img);
			img.percentWidth = 100;
			img.percentHeight = 100;
			
			baseCanvas.addChild(textObjHandles);
			baseCanvas.removeEventListener(MouseEvent.CLICK, showUploadForm);
			selectionTool();
		}
		
		public function startDrawRect(event:MouseEvent):void {
			trace("startDrawRect");
			var rectObjHandles:ObjectHandles = new ObjectHandles();
			rectObjHandles.x = baseCanvas.mouseX;
			rectObjHandles.y = baseCanvas.mouseY;
			rectObjHandles.width = 20;
			rectObjHandles.height = 20;
			
			rectObj = new Canvas();
			rectObjHandles.obj = rectObj;
			rectObjHandles.addChild(rectObj);
			rectObj.setStyle("backgroundColor", "#FFDE00");
			rectObj.setStyle("borderThickness", 0);
			rectObj.percentWidth = 100;
			rectObj.percentHeight = 100;
			baseCanvas.addChild(rectObjHandles);
						
			baseCanvas.addEventListener(MouseEvent.MOUSE_MOVE, drawRect);
		}
		
		public function drawRect(event:MouseEvent):void {
			trace("drawRect");
			var rectObjHandles:ObjectHandles = ObjectHandles(rectObj.parent);
			rectObjHandles.resize(rectObjHandles.mouseX, rectObjHandles.mouseY);
		}
		
		public function endDrawRect(event:MouseEvent):void {
			trace("endDrawRect");
			baseCanvas.removeEventListener(MouseEvent.MOUSE_MOVE, drawRect);
			baseCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawRect);
			selectionTool();
		}
		
		public function changeStyle(styleProp:String, value:*):void {
			var selectedObjects:Array = SelectionManager.instance.getItems();
			for each(var selectedObj:Selectable in selectedObjects){
				selectedObj.changeStyle(styleProp, value);
			}
		}
	}
}