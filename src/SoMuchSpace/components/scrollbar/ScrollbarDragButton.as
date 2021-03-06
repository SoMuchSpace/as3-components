package SoMuchSpace.components.scrollbar 
{
	import SoMuchSpace.components.buttons.BaseButton;
	
	/**
	 * ...
	 * @author SoMuchSpace
	 */
	internal class ScrollbarDragButton extends BaseButton
	{
		
		private var _scrollbarType:String;
		
		public function ScrollbarDragButton(scrollbarType:String ) 
		{
			super();
			this._scrollbarType = scrollbarType;
			if (scrollbarType == ScrollbarType.VERTICAL)
			{
				setComponentSize(14, 83);
				minHeight = 8;
			}
			else (scrollbarType == ScrollbarType.HORIZONTAL)
			{
				setComponentSize(83, 14);
				minWidth = 8;
			}
			haveOverState = true;
			haveDownState = true;
		}
		
		override protected function upView():void 
		{
			graphics.clear();
			graphics.lineStyle(1, 0xA4A4A4);
			graphics.beginFill(0xF9F9F9);
			graphics.drawRect(0, 0, componentWidth, componentHeight);
			graphics.endFill();
			
			graphics.lineStyle(1, 0x6A6A6A);
			drawLines();
			
		}
		
		override protected function overView():void 
		{
			graphics.clear();
			graphics.lineStyle(1, 0xA4A4A4);
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0, 0, componentWidth, componentHeight);
			graphics.endFill();
			
			graphics.lineStyle(1, 0x6A6A6A);
			drawLines();
		}
		
		override protected function downView():void 
		{
			graphics.clear();
			graphics.lineStyle(1, 0xA4A4A4);
			graphics.beginFill(0xD1D1D1);
			graphics.drawRect(0, 0, componentWidth, componentHeight);
			graphics.endFill();
			
			graphics.lineStyle(1, 0x6A6A6A);
			drawLines();
		}
		
		private function drawLines():void
		{
			if (_scrollbarType == ScrollbarType.HORIZONTAL)
			{
				graphics.moveTo(componentWidth / 2 - 2, 3);
				graphics.lineTo(componentWidth / 2 - 2, componentHeight - 3);
				graphics.moveTo(componentWidth / 2, 3);
				graphics.lineTo(componentWidth / 2, componentHeight - 2);
				graphics.moveTo(componentWidth / 2 + 2, 3);
				graphics.lineTo(componentWidth / 2 + 2, componentHeight - 3);
			}
			else if (_scrollbarType == ScrollbarType.VERTICAL)
			{
				graphics.moveTo(3, componentHeight / 2 - 2);
				graphics.lineTo(componentWidth - 3, componentHeight / 2 - 2);
				graphics.moveTo(3, componentHeight / 2);
				graphics.lineTo(componentWidth - 2, componentHeight / 2);
				graphics.moveTo(3, componentHeight / 2 + 2);
				graphics.lineTo(componentWidth - 3, componentHeight / 2 + 2);
			}
		}
	}

}