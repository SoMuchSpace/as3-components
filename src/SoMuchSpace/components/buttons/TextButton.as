package SoMuchSpace.components.buttons
{
	import flash.text.TextField;
	import SoMuchSpace.components.utils.ComponentUtils;
	
	/**
	 * ...
	 * @author SoMuchSpace
	 */
	public class TextButton extends BaseButton
	{
		private var _textField:TextField;
		
		public function TextButton(text:String) 
		{
			haveDownState = true;
			haveOverState = true;
			
			_textField = ComponentUtils.getTunedTextField(14, 0xFFFFFF);
			_textField.mouseEnabled = false;
			addChild(_textField);
			
			_componentWidth = 80;
			_componentHeight = 23;
			
			this.text = text;
		}
		
		override public function draw():void 
		{
			super.draw();
			_textField.x = Math.round((componentWidth - _textField.width) / 2);
			_textField.y = Math.round((componentHeight - _textField.height) / 2);
		}
		
		override protected function upView():void 
		{
			graphics.clear();
			//graphics.lineStyle(1, 0x21A4D2);
			graphics.beginFill(0x2EB3DE);
			graphics.drawRect(0, 0, componentWidth, componentHeight);
			graphics.endFill();
		}
		
		override protected function overView():void 
		{
			graphics.clear();
			//graphics.lineStyle(1, 0x1B84A7);
			graphics.beginFill(0x45BBE2);
			graphics.drawRect(0, 0, componentWidth, componentHeight);
			graphics.endFill();
		}
		
		override protected function downView():void 
		{
			graphics.clear();
			//graphics.lineStyle(1, 0x1B84A7);
			graphics.beginFill(0x20A2CC);
			graphics.drawRect(0, 0, componentWidth, componentHeight);
			graphics.endFill();
		}
		
		override protected function notEnabledView():void 
		{
			graphics.clear();
			//graphics.lineStyle(1, 0x8A9BA5);
			graphics.beginFill(0xBAC5CB);
			graphics.drawRect(0, 0, componentWidth, componentHeight);
			graphics.endFill();
		}
		
		public function get text():String { return _textField.text; }
		
		public function set text(value:String):void 
		{
			_textField.text = value;
			minHeight = _textField.height + 10;
			minWidth = _textField.width + 10;
			draw();
		}
		
	}

}