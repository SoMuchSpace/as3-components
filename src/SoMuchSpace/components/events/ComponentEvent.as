package SoMuchSpace.components.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author DanPo
	 */
	public class ComponentEvent extends Event
	{
		public static const RESIZE:String = "resizeComponent";
		public static const DRAW:String = "drawComponent"
		public static const MOVE:String = "moveComponent";
		
		public function ComponentEvent(type:String, bubbles:Boolean = false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new ComponentEvent(type, bubbles, cancelable);
		}
		
		override public function toString():String 
		{
			return formatToString("ComponentEvent", type, bubbles, cancelable);
		}
		
	}

}