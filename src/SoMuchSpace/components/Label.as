package SoMuchSpace.components 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import SoMuchSpace.components.fonts.ComponentFont;
	/**
	 * ...
	 * @author ...
	 */
	public class Label extends Component
	{
		private var _textField:TextField = new TextField();
		
		public function Label(text:String = "") 
		{
			_textField.defaultTextFormat = new TextFormat(ComponentFont.OPEN_SANS, 20, 0);
			_textField.embedFonts = true;
			//_textField.antiAliasType = AntiAliasType.ADVANCED;
			_textField.autoSize = TextFieldAutoSize.LEFT;
			_textField.selectable = false;
			addChild(_textField);
			
			this.text = text;
		}
		
		public function get text():String
		{
			return _textField.text;
		}
		
		public function set text(value:String):void 
		{
			_textField.text = value;
			minHeight = _textField.height;
			minWidth = _textField.width;
		}
		
	}

}