package SoMuchSpace.components.mouse 
{
	/**
	 * ...
	 * @author SoMuchSpace
	 */
	public class CustomMouseCursor 
	{
		
		public static var CLOSE_HAND:String = "closeHand";
		public static var OPEN_HAND:String = "openHand";
		
		[Embed(source = "icon/cursor-closedhand.png")]
		internal static var CLOSE_HAND_ICON:Class;
		[Embed(source = "icon/cursor-openhand.png")]
		internal static var OPEN_HAND_ICON:Class;
		
	}

}