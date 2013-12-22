package SoMuchSpace.components.scrollbar 
{
	import SoMuchSpace.components.BaseButton;
	
	/**
	 * ...
	 * @author DanPo
	 */
	public class ScrollbarArrowButton extends BaseButton
	{
		public static const UP:String = "up";
		public static const LEFT:String = "left";
		public static const DOWN:String = "down";
		public static const RIGHT:String = "right";
		
		private var type:String;
		
		public function ScrollbarArrowButton(type:String) 
		{
			this.type = type;
			if (type == UP || type == DOWN)
			{
				setComponentSize(14, 15);
			}
			else if (type == LEFT || type == RIGHT)
			{
				setComponentSize(15, 14);
			}
			over = true;
			down = true;
			
		}
		
		override protected function upView():void 
		{
			graphics.clear();
			
			graphics.lineStyle(1, 0x686868);
			graphics.beginFill(0xFEFEFE);
			
			graphics.drawRect(.5, .5, componentWidth, componentHeight);
			graphics.endFill();
			
			graphics.lineStyle(1, 0x686868);
			drawArrows();
			
		}
		
		override protected function overView():void 
		{
			graphics.clear();
			
			graphics.lineStyle(1, 0x686868);
			graphics.beginFill(0xFEFEFE);
			
			graphics.drawRect(.5, .5, componentWidth, componentHeight);
			graphics.endFill();
			
			graphics.lineStyle(1, 0x686868);
			drawArrows();
		}
		
		override protected function downView():void 
		{
			graphics.clear();
			
			graphics.lineStyle(1, 0x686868);
			graphics.beginFill(0xE0E0E0);
			
			graphics.drawRect(.5, .5, componentWidth, componentHeight);
			graphics.endFill();
			
			graphics.lineStyle(1, 0x686868);
			drawArrows();
		}
		
		override protected function notEnabledView():void 
		{
			graphics.clear();
			
			graphics.lineStyle(1, 0xA2A2A2);
			graphics.beginFill(0xFCFCFC);
			
			graphics.drawRect(.5, .5, componentWidth, componentHeight);
			graphics.endFill();
			
			graphics.lineStyle(1, 0xBFBFBF);
			drawArrows();
		}
		
		private function drawArrows():void
		{
			if (type == UP)
			{
				graphics.moveTo(4, 7);
				graphics.lineTo(7, 4);
				graphics.lineTo(10, 7);
				graphics.moveTo(4, 10);
				graphics.lineTo(7, 7);
				graphics.lineTo(10, 10);
			}
			else if (type == DOWN)
			{
				graphics.moveTo(4, 5);
				graphics.lineTo(7, 8);
				graphics.lineTo(10, 5);
				graphics.moveTo(4, 8);
				graphics.lineTo(7, 11);
				graphics.lineTo(10, 8);
			}
			else if (type == LEFT)
			{
				graphics.moveTo(7, 4);
				graphics.lineTo(4, 7);
				graphics.lineTo(7, 10);
				graphics.moveTo(10, 4);
				graphics.lineTo(7, 7);
				graphics.lineTo(10, 10);
			}
			else if (type == RIGHT)
			{
				graphics.moveTo(5, 4);
				graphics.lineTo(8, 7);
				graphics.lineTo(5, 10);
				graphics.moveTo(8, 4);
				graphics.lineTo(11, 7);
				graphics.lineTo(8, 10);
			}
			
		}
	}

}