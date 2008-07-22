/**
 * Basic interface of selectable objects 
 **/

package com.ctu.uckcanvas
{
	public interface Selectable
	{
		function select() : void;
		function deselect() : void;
		function changeStyle(styleProp:String, value:*):void;
	}
}