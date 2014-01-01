package SoMuchSpace.components
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import SoMuchSpace.components.events.ComponentEvent;
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
		
		private var _hitSprite:Sprite = new Sprite();
		
		public var scrollIfChildScrollPaneCant:Boolean = true;
		
		public function ScrollPane(componentWidth:Number = 100, componentHeight:Number = 100,
			verticalScrollbarDisplayPolicy:String = "scrollbarAsNeeded", 
			horizontalScrollbarDisplayPolicy:String = "scrollbarAsNeeded")
		{
			super();
			
			_xScrollbarPolicy = horizontalScrollbarDisplayPolicy;
			_yScrollbarPolicy = verticalScrollbarDisplayPolicy;
			
			addChild(_hitSprite);
			addChild(container);
			
			_componentWidth = componentWidth;
			_componentHeight = componentHeight;
			
			if (_xScrollbarPolicy == ScrollbarDisplayPolicy.SCROLLBAR_ALWAYS)
			{
				createXScrollBar();
			}
			if (_yScrollbarPolicy == ScrollbarDisplayPolicy.SCROLLBAR_ALWAYS)
			{
				createYScrollbar();
			}
			
			container.addEventListener(Event.ADDED, onChildAddedToContainer);
			container.addEventListener(Event.REMOVED, onChildRemovedFromContainer);
			
			container.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_hitSprite.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		private function createXScrollBar():void
		{
			if (!_xScrollbar)
			{
				_xScrollbar = new Scrollbar(ScrollbarType.HORIZONTAL);
			}
			addChild(xScrollbar);
			xScrollbar.addEventListener(Event.CHANGE, onScrollbarScrollPositionChanged);
		}
		
		private function createYScrollbar():void
		{
			if (!_yScrollbar)
			{
				_yScrollbar = new Scrollbar(ScrollbarType.VERTICAL);
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
		
		private function onChildAddedToContainer(e:Event):void 
		{
			invalidate();
			
			var displayObject:DisplayObject = e.target as DisplayObject;
			if (displayObject is Component && displayObject.parent == container)
			{
				var component:Component = displayObject as Component;
				component.addEventListener(ComponentEvent.MOVE, onChildChanged);
				component.addEventListener(ComponentEvent.RESIZE, onChildChanged);
			}
		}
		
		private function onChildChanged(e:ComponentEvent):void 
		{
			invalidate();
		}
		
		private function onChildRemovedFromContainer(e:Event):void 
		{
			invalidate();
			
			var displayObject:DisplayObject = e.target as DisplayObject;
			if (displayObject is Component && displayObject.parent == container)
			{
				var component:Component = displayObject as Component;
				component.removeEventListener(ComponentEvent.MOVE, onChildChanged);
				component.removeEventListener(ComponentEvent.RESIZE, onChildChanged);
			}
		}
		
		
		
		override public function draw():void
		{
			super.draw();
			
			var maskWidth:Number = componentWidth;
			var maskHeight:Number = componentHeight;
			
			var containerWidth:Number = 0;
			var containerHeight:Number = 0;
			
			for (var i:int = 0; i < container.numChildren; i++) 
			{
				var displayObject:DisplayObject = container.getChildAt(i);
				var displayObjectRight:Number = 0;
				var displayObjectBottom:Number = 0;
				if (displayObject is Component)
				{
					var component:Component = displayObject as Component;
					displayObjectRight = component.x + component.componentWidth;
					displayObjectBottom = component.y + component.componentHeight;
					
				}
				else
				{
					var displayObjectVisibility:Rectangle = getVisibility(displayObject);
					displayObjectRight = displayObjectVisibility.right;
					displayObjectBottom = displayObjectVisibility.bottom;
				}
				if (displayObjectRight > containerWidth)
				{
					containerWidth = displayObjectRight;
				}
				if (displayObjectBottom > containerHeight)
				{
					containerHeight = displayObjectBottom;
				}
			}
			
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
			
			container.minWidth = maskWidth;
			container.minHeight = maskHeight;
			
			_hitSprite.graphics.clear();
			_hitSprite.graphics.beginFill(0, 0);
			_hitSprite.graphics.drawRect(0, 0, maskWidth, maskHeight);
			_hitSprite.graphics.endFill();
			container.hitArea = _hitSprite;
		}
		
		private function getVisibility(displayObject:DisplayObject):Rectangle
		{
			var visibility:Rectangle;
			if (displayObject.parent == null) return new Rectangle();
			if (displayObject is DisplayObjectContainer)
			{
				visibility = getChildVisibility(displayObject as DisplayObjectContainer, displayObject.parent);
			}
			else
			{
				visibility = displayObject.getBounds(displayObject.parent);
			}
			// Is the DisplayObject masked?
			if (displayObject.mask != null)
			{
				visibility = visibility.intersection(displayObject.mask.getBounds(displayObject.parent));
			}
			// Is the DisplayObject partly or completely off-stage?
			visibility = visibility.intersection(displayObject.stage.getBounds(displayObject.parent));
			return visibility;
		}
		
		private function getChildVisibility(displayObjectContainer:DisplayObjectContainer, target:DisplayObjectContainer):Rectangle
		{
			var visibility:Rectangle = new Rectangle();
			var child:DisplayObject;
			var childRect:Rectangle;
			var i:uint;
			
			for (i = 1; i <= displayObjectContainer.numChildren; i++)
			{
				child = displayObjectContainer.getChildAt(i - 1);
				if (child != null)
				{
					if (child.visible)
					{
						if (child is DisplayObjectContainer)
						{
							childRect = getChildVisibility(child as DisplayObjectContainer, target);
						}
						else
						{
							childRect = child.getBounds(target);
						}
						if (child.mask != null)
						{
							childRect = childRect.intersection(child.mask.getBounds(target));
						}
						visibility = visibility.union(childRect);
					}
				}
			}
			return visibility;
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
			var displayObject:DisplayObject = e.target as DisplayObject;
			
			var parentScrollpane:ScrollPane = getFirstParentScrollPane(displayObject);
			
			while(parentScrollpane)
			{
				var targetScrollbar:Scrollbar;
				if (parentScrollpane.yScrollbar && parentScrollpane.yScrollbar.enabled)
				{
					targetScrollbar = parentScrollpane.yScrollbar;
				}
				else if (parentScrollpane.xScrollbar && parentScrollpane.xScrollbar.enabled)
				{
					targetScrollbar = parentScrollpane.xScrollbar;
				}
				
				if (targetScrollbar)
				{
					var canScrollFurther:Boolean = e.delta > 0 && targetScrollbar.scrollPosition != targetScrollbar.minScrollPosition
						|| e.delta < 0 && targetScrollbar.scrollPosition != targetScrollbar.maxScrollPosition;
					if (canScrollFurther)
					{
						targetScrollbar.scrollPosition -= targetScrollbar.arrowsScrollSize * e.delta;
						break;
					}
					else if(scrollIfChildScrollPaneCant)
					{
						parentScrollpane = getFirstParentScrollPane(parentScrollpane);
					}
					else
					{
						break;
					}
				}
				else
				{
					break;
				}
			}
			
		}
		
		private function getFirstParentScrollPane(displayObject:DisplayObject):ScrollPane
		{
			var displayObjectContainer:DisplayObjectContainer = displayObject.parent;
			
			while (displayObjectContainer)
			{
				if (displayObjectContainer is ScrollPane)
				{
					return displayObjectContainer as ScrollPane;
				}
				displayObjectContainer = displayObjectContainer.parent;
			}
			
			return null;
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