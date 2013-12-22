package SoMuchSpace.components 
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import SoMuchSpace.components.utils.ComponentUtils;
	/**
	 * ...
	 * @author SoMuchSpace
	 */
	public class InputText extends Component
	{
		private var _textField:TextField;
		
		public function InputText(text:String = "") 
		{
			_textField = ComponentUtils.getTunedTextField(18, 0x000000, TextFieldAutoSize.NONE);
			_textField.background = true;
			_textField.border = true;
			_textField.backgroundColor = 0xFFFFFF;
			_textField.borderColor = 0xA3A3A3;
			_textField.type = TextFieldType.INPUT;
			
			this.text = text;
			
			minHeight = Math.round(_textField.textHeight + 4);
			minWidth = 4;
			
			componentWidth = 100;
			
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