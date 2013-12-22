package SoMuchSpace.components 
{
	/**
	 * ...
	 * @author SoMuchSpace
	 */
	public class ComponentUtils 
	{
		public static function getXPositionAfter(component:Component, offset:Number = 0):Number
		{
			return component.x + component.componentWidth + offset;
		}
		
		public static function getYPositionAfter(component:Component, offset:Number = 0):Number
		{
			return component.y + component.componentHeight + offset;
		}
		
	}

}