package SoMuchSpace.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import SoMuchSpace.components.scrollbar.Scrollbar;
	import SoMuchSpace.components.scrollbar.ScrollbarDisplayPolicy;
	import SoMuchSpace.components.scrollbar.ScrollbarType;
	
	/**
	 * ...
	 * @author SoMuchSpace
	 */
	public class ScrollPane extends Panel
	{
		
		private var _xScrollbar:Scrollbar;
		private var _yScrollbar:Scrollbar;
		
		private var _xScrollbarPolicy:String;
		private var _yScrollbarPolicy:String;
		
		private var hitSprite:Sprite = new Sprite();
		
		public function ScrollPane(verticalScrollbarDisplayPolicy:String = "scrollbarAsNeeded", horizontalScrollbarDisplayPolicy:String = "scrollbarAsNeeded")
		{
			super();
			
			_xScrollbarPolicy = horizontalScrollbarDisplayPolicy;
			_yScrollbarPolicy = verticalScrollbarDisplayPolicy;
			
			addChild(hitSprite);
			addChild(container);
			
			_componentWidth = 100;
			_componentHeight = 100;
			
			if (_xScrollbarPolicy == ScrollbarDisplayPolicy.SCROLLBAR_ALWAYS)
			{
				createXScrollBar();
			}
			if (_yScrollbarPolicy == ScrollbarDisplayPolicy.SCROLLBAR_ALWAYS)
			{
				createYScrollbar();
			}
			// TODO: вложенные крулпане
			hitSprite.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			container.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		private function createXScrollBar():void
		{
			if (!_xScrollbar)
			{
				_xScrollbar = new Scrollbar(ScrollbarType.HORIZONTAL, 1, 0, 0, false);
			}
			addChild(xScrollbar);
			xScrollbar.addEventListener(Event.CHANGE, onScrollbarScrollPositionChanged);
		}
		
		private function createYScrollbar():void
		{
			if (!_yScrollbar)
			{
				_yScrollbar = new Scrollbar(ScrollbarType.VERTICAL, 1, 0, 0, false);
			}
			addChild(yScrollbar);
			yScrollbar.addEventListener(Event.CHANGE, onScrollbarScrollPositionChanged);
		}
		
		private function onScrollbarScrollPositionChanged(e:Event):void
		{
			if (xScrollbar)
			{
				container.x = -xScrollbar.scrollPosition;
			}
			else
			{
				container.x = 0;
			}
			if (yScrollbar)
			{
				container.y = -yScrollbar.scrollPosition;
			}
			else
			{
				container.y = 0;
			}
		}
		
		override public function draw():void
		{
			super.draw();
			
			var maskWidth:Number = componentWidth;
			var maskHeight:Number = componentHeight;
			
			var containerRect:Rectangle = container.getRect(container);
			
			var containerWidth:Number = containerRect.x + containerRect.width;
			var containerHeight:Number = containerRect.y + containerRect.height;
			
			if (_xScrollbarPolicy == ScrollbarDisplayPolicy.SCROLLBAR_AS_NEEDED)
			{
				var cWidth:Number = maskWidth;
				if (containerWidth <= cWidth)
				{
					if (xScrollbar != null)
					{
						deleteXScrollbar();
						minHeight = 29;
					}
				}
				else
				{
					if (!xScrollbar)
					{
						createXScrollBar();
						maskHeight -= _xScrollbar.height;
						_minHeight = 44;
					}
				}
			}
			if (_yScrollbarPolicy == ScrollbarDisplayPolicy.SCROLLBAR_AS_NEEDED)
			{
				var cHeight:Number = maskHeight;
				if (containerHeight <= cHeight)
				{
					if (yScrollbar)
					{
						deleteYScrollbar();
						minWidth = 29;
					}
				}
				else
				{
					if (!yScrollbar)
					{
						createYScrollbar();
						minWidth = 44;
					}
				}
			}
			if (yScrollbar)
			{
				
				yScrollbar.x = componentWidth - yScrollbar.componentWidth;
				maskWidth = yScrollbar.x;
				
				if (xScrollbar)
				{
					yScrollbar.componentHeight = componentHeight - xScrollbar.componentHeight;
				}
				else
				{
					yScrollbar.componentHeight = componentHeight;
				}
			}
			else
			{
				maskWidth = componentWidth;
			}
			if (xScrollbar)
			{
				xScrollbar.y = componentHeight - xScrollbar.componentHeight;
				maskHeight = xScrollbar.y;
				
				if (yScrollbar)
				{
					xScrollbar.componentWidth = componentWidth - yScrollbar.componentWidth;
				}
				else
				{
					xScrollbar.componentWidth = componentWidth;
				}
			}
			else
			{
				maskHeight = componentHeight;
			}
			if (xScrollbar)
			{
				var prevMax:Number = xScrollbar.maxScrollPosition;
				xScrollbar.wholeSize = containerWidth;
				xScrollbar.maxScrollPosition = containerWidth - maskWidth;
				
				if (xScrollbar.enabled)
				{
					if (xScrollbar.scrollPosition == prevMax)
					{
						xScrollbar.scrollPosition = xScrollbar.maxScrollPosition;
					}
					container.x = -xScrollbar.scrollPosition;
				}
				else
				{
					container.x = 0;
				}
				xScrollbar.draw();
			}
			else
			{
				container.x = 0;
			}
			if (yScrollbar)
			{
				prevMax = yScrollbar.maxScrollPosition;
				yScrollbar.wholeSize = containerHeight;
				yScrollbar.maxScrollPosition = containerHeight - maskHeight;
				if (yScrollbar.enabled)
				{
					if (yScrollbar.scrollPosition == prevMax)
					{
						yScrollbar.scrollPosition = yScrollbar.maxScrollPosition;
					}
					container.y = -yScrollbar.scrollPosition;
				}
				else
				{
					container.y = 0;
				}
				yScrollbar.draw();
			}
			else
			{
				container.y = 0;
			}
			
			container.setComponentSize(maskWidth, maskHeight);
			
			hitSprite.graphics.clear();
			hitSprite.graphics.beginFill(0, 0);
			hitSprite.graphics.drawRect(0, 0, maskWidth, maskHeight);
			hitSprite.graphics.endFill();
			container.hitArea = hitSprite;
		}
		
		private function deleteXScrollbar():void
		{
			xScrollbar.removeEventListener(Event.CHANGE, onScrollbarScrollPositionChanged);
			removeChild(xScrollbar);
			_xScrollbar = null;
		}
		
		private function deleteYScrollbar():void
		{
			yScrollbar.removeEventListener(Event.CHANGE, onScrollbarScrollPositionChanged);
			removeChild(yScrollbar);
			_yScrollbar = null;
		}
		
		private function onMouseWheel(e:MouseEvent):void
		{
			if (yScrollbar && yScrollbar.enabled)
			{
				yScrollbar.scrollPosition -= yScrollbar.arrowsScrollSize * e.delta;
			}
			else if (xScrollbar && xScrollbar.enabled)
			{
				xScrollbar.scrollPosition -= xScrollbar.arrowsScrollSize * e.delta;
			}
		}
		
		public function get yScrollbar():Scrollbar
		{
			return _yScrollbar;
		}
		
		public function get xScrollbar():Scrollbar
		{
			return _xScrollbar;
		}
	}

}