package SoMuchSpace.components.buttons
{
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import SoMuchSpace.components.BaseButton;
	import SoMuchSpace.components.fonts.ComponentFont;
	
	/**
	 * ...
	 * @author DanPo
	 */
	public class TextButton extends BaseButton
	{
		private var _text:String;
		private var _label:TextField;
		
		public function TextButton(text:String) 
		{
			super();
			
			_text = text;
			
			down = true;
			
			_label = new TextField();
			_label.autoSize = TextFieldAutoSize.LEFT;
			_label.mouseEnabled = false;
			_label.defaultTextFormat = new TextFormat(ComponentFont.OPEN_SANS, 14, 0xFFFFFF);
			_label.embedFonts = true;
			//label.antiAliasType = AntiAliasType.ADVANCED;
			addChild(_label);
			
			_componentWidth = 80;
			_componentHeight = 23;
		}
		
		override public function draw():void 
		{
			_label.text = _text;
			//label.setTextFormat(new TextFormat("Verdana", 11, 0xFFFFFF));
			
			minWidth = _label.width + 10;
			
			_label.x = Math.round((componentWidth - _label.width) / 2);
			_label.y = Math.round((componentHeight - _label.height) / 2);
			super.draw();
			//upView();
		}
		
		override protected function upView():void 
		{
			graphics.clear();
			//graphics.lineStyle(1, 0x21A4D2);
			graphics.beginFill(0x2EB3DE);
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
		
		public function get text():String { return _text; }
		
		public function set text(value:String):void 
		{
			_text = value;
			draw();
		}
		
	}

}