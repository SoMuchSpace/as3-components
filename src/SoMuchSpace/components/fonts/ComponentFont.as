package SoMuchSpace.components.fonts 
{
	/**
	 * ...
	 * @author SoMuchSpace
	 */
	public class ComponentFont 
	{
		[Embed(source = "open-sans/OpenSans-Light.ttf",
			fontName = "Open Sans Light",
			advancedAntiAliasing  = "true",
			embedAsCFF = "false")]
		public var OPEN_SANS_LIGHT:Class;
		public static const OPEN_SANS_LIGHT:String = "Open Sans Light";
	}

}