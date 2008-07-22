/**
 *  Manage selectable objects
 **/
package com.ctu.uckcanvas
{
	public class SelectionManager
	{
		private static var _instance:SelectionManager; // singleton
		private var _items:Array = new Array(); // selectable object array
		
		[Bindable]
		public var currentlySelected:Array = new Array(); // selected object array
		
		public static function  get instance() : SelectionManager {
			if( ! _instance ) { _instance = new SelectionManager(); }
			return _instance;
		}
		
		public function selectNone() : void {
			trace("selectNone");
			for each (var obj:Selectable in _items ) {
				obj.deselect();
			}
			currentlySelected = new Array();
		}
		
		public function setSelected(obj:Selectable, singleFlag:Boolean = true) : void {
			trace("currently selected object: "+currentlySelected.length);
			var ind:int = currentlySelected.indexOf(obj);
			if( ind != -1) { // aleady selected
				 if(singleFlag){
				 	for each (var selT:Selectable in currentlySelected) {
				 		if(obj != selT) selT.deselect();
				 	}
				 	currentlySelected = new Array();
				 	currentlySelected.push(obj);
				 	return;
				 }
				 
				 trace("multi selected and already selected");
//				 
//				 obj.deselect();
//				 currentlySelected.slice(ind,1);
				 return;
			}
			
			if(singleFlag){
				for each (var selB:Selectable in currentlySelected) {
			 		selB.deselect();
			 	}
			 	currentlySelected = new Array();
			 	obj.select();
			 	currentlySelected.push(obj);
			 	return;
			}
			
			trace("muli select and not yet selected");
			obj.select();
			currentlySelected.push(obj);
		}
		
		public function getItems():Array {
          return _items;
        }
        
        public function addSelectable(obj:Selectable) : void {
			var ind:int = _items.indexOf( obj );
			if( ind != -1 ) { return; }
			
			_items.push(obj);
		}
		
		public function removeSelectable( obj : Selectable ) : void {
			var ind:int = _items.indexOf( obj );
			if( ind == -1 ) { return; }
			_items.splice( ind	, 1 );
		}
	}
}