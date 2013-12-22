package SoMuchSpace.components 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import SoMuchSpace.components.fonts.ComponentFont;
	import SoMuchSpace.components.utils.ComponentUtils;
	/**
	 * ...
	 * @author ...
	 */
	public class Label extends Component
	{
		private var _textField:TextField;
		
		public function Label(text:String = "") 
		{
			_textField = ComponentUtils.getTunedTextField();
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