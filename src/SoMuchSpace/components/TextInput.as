package SoMuchSpace.components 
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import SoMuchSpace.components.fonts.ComponentFont;
	/**
	 * ...
	 * @author ...
	 */
	public class TextInput extends Component
	{
		private var _textField:TextField = new TextField();
		
		public function TextInput(text:String = "") 
		{
			_textField.defaultTextFormat = new TextFormat(ComponentFont.OPEN_SANS, 10, 0x000000);
			_textField.background = true;
			_textField.border = true;
			_textField.backgroundColor = 0xFFFFFF;
			_textField.borderColor = 0xA3A3A3;
			_textField.selectable = true;
			_textField.type = TextFieldType.INPUT;
			
			this.text = text;
			
			componentHeight = _textField.height;
			componentWidth = _textField.width;
			
			_textField.addEventListener(Event.CHANGE, onTextChange);
			
			addChild(_textField);
		}
		
		private function onTextChange(e:Event):void 
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function selectAll():void {
			_textField.setSelection(0, _textField.length);
		}
		
		override public function draw():void 
		{
			super.draw();
			_textField.width = componentWidth;
			_textField.height = componentHeight;
		}
		
		public function get text():String 
		{
			return _textField.text;
		}
		
		public function set text(value:String):void 
		{
			_textField.text = value;
		}
		
		public function get restrict():String 
		{
			return _textField.restrict;
		}
		
		public function set restrict(value:String):void 
		{
			_textField.restrict = value;
		}
		
		public function get maxChars():int 
		{
			return _textField.maxChars;
		}
		
		public function set maxChars(value:int):void 
		{
			_textField.maxChars = value;
		}
		
	}

}