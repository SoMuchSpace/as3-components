package SoMuchSpace.components 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import SoMuchSpace.components.fonts.ComponentFont;
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
		
		public static function getTunedTextField(size:int = 14, color:Number = 0x000000, autoSize:String = "left"):TextField
		{
			var newTextField:TextField = new TextField();
			newTextField.autoSize = autoSize;
			newTextField.defaultTextFormat = new TextFormat(ComponentFont.OPEN_SANS, size, color);
			newTextField.embedFonts = true;
			//label.antiAliasType = AntiAliasType.ADVANCED;
			return newTextField;
		}
	}

}