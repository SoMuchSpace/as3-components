package SoMuchSpace.components 
{
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author SoMuchSpace
	 */
	public class Progressbar extends Component
	{
		private var _totalValue:Number = 100;
		private var _currentValue:Number = 0;
		
		public function Progressbar() 
		{
			super();
			setComponentSize(140, 10);
		}
		
		override public function draw():void 
		{
			super.draw();
			graphics.clear();
			graphics.lineStyle(1, 0xC6C6C6);
			var bitmap:BitmapData = new BitmapData(6, 6, false, 0xFCFCFC);
			var i:uint = 0;
			var l:uint = bitmap.width;
			while (i < l)
			{
				bitmap.setPixel(i, l - 1 - i, 0xF2F2F2);
				i++;
			}
			graphics.beginBitmapFill(bitmap);
			graphics.drawRoundRect(0, 0, componentWidth, componentHeight, 5, 5);
			graphics.endFill();
			graphics.lineStyle();
			var w:uint = currentValue/totalValue * (componentWidth - 0);
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(w, componentHeight - 0, Math.PI/2);
			graphics.beginGradientFill(GradientType.LINEAR, [0xbad8f0, 0x3f9ee7], [1, 1], [0x00, 0xFF], matrix);
			graphics.drawRoundRect(0, 0, w, componentHeight - 0, 5, 5);
			graphics.endFill();
		}
		
		public function get currentValue():Number { return _currentValue; }
		
		public function set currentValue(value:Number):void 
		{
			if (_currentValue != value)
			{
				_currentValue = value;
				draw();
			}
		}
		
		public function get totalValue():Number { return _totalValue; }
		
		public function set totalValue(value:Number):void 
		{
			if (_totalValue != value)
			{
				_totalValue = value;
				draw();
			}
		}
		
	}

}