package SoMuchSpace.components.utils 
{
	import flash.display.Stage;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author SoMuchSpace
	 */
	public class MouseUtils 
	{
		static private var _stage:Stage;
		
		static private var _isMouseDown:Boolean = false;
		
		static public function setStage(stage:Stage):void
		{
			if (_stage)
			{
				_stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			}
			_stage = stage;
			if (_stage)
			{
				_stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			}
		}
		
		static private function onMouseDown(e:MouseEvent):void 
		{
			_isMouseDown = true;
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		static private function onMouseUp(e:MouseEvent):void 
		{
			_isMouseDown = false;
			_stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		static public function get isMouseDown():Boolean 
		{
			if (_stage == null)
			{
				throw new Error("Use setStage() function first.");
			}
			return _isMouseDown;
		}
	}

}