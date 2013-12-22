package SoMuchSpace.components.mouse 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	import SoMuchSpace.controller.IController;
	/**
	 * ...
	 * @author SoMuchSpace
	 */
	public class CustomMouseCursorManager implements IController
	{
		private var _cursorNameList:Vector.<String> = new Vector.<String>();
		
		public function CustomMouseCursorManager() 
		{
			
		}
		
		public function start():void 
		{
			var bitmap:Bitmap;
			
			bitmap = new CustomMouseCursor.CLOSE_HAND_ICON();
			addCursor(CustomMouseCursor.CLOSE_HAND, bitmap.bitmapData, new Point(9, 9));
			
			bitmap = new CustomMouseCursor.OPEN_HAND_ICON();
			addCursor(CustomMouseCursor.OPEN_HAND, bitmap.bitmapData, new Point(9, 9));
		}
		
		private function addCursor(cursorName:String, cursor:BitmapData, hotSpot:Point=null):void
		{
			var bitmapDataVector:Vector.<BitmapData> = new Vector.<BitmapData>();
			bitmapDataVector.push(cursor);
			
			addAnimatedCursor(cursorName, bitmapDataVector, 0, hotSpot);
		}
		
		private function addAnimatedCursor(cursorName:String, cursorVector:Vector.<BitmapData>, frameRate:int = 0, hotSpot:Point=null):void
		{
			if (hotSpot == null)
			{
				hotSpot = new Point();
			}
			
			var mouseCursorData:MouseCursorData = new MouseCursorData();
			
			mouseCursorData.data = cursorVector;
			mouseCursorData.frameRate = frameRate;
			mouseCursorData.hotSpot = hotSpot;
			
			Mouse.registerCursor(cursorName, mouseCursorData);
			_cursorNameList.push(cursorName);
		}
		
		public function stop():void 
		{
			while (_cursorNameList.length)
			{
				Mouse.unregisterCursor(_cursorNameList.shift());
			}
		}
		
		public function destroy():void 
		{
			stop();
		}
		
	}

}