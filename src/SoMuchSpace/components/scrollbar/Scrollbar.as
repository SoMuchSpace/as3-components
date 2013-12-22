package SoMuchSpace.components.scrollbar
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import SoMuchSpace.components.buttons.BaseButton;
	import SoMuchSpace.components.buttons.ButtonState;
	import SoMuchSpace.components.Container;
	
	/**
	 * ...
	 * @author SoMuchSpace
	 */
	[Event(name="change",type="flash.events.Event")]
	
	public class Scrollbar extends Container
	{
		private var type:String;
		
		private var backgroundButton:Sprite;
		private var _firstButton:BaseButton;
		private var _middleButton:BaseButton;
		private var _lastButton:BaseButton;
		
		private var _minScrollPosition:Number;
		private var _scrollPosition:Number = 0;
		private var _maxScrollPosition:Number = 0;
		
		private var _wholeSize:Number;
		
		private var _arrowsScrollSize:Number = 10;
		
		private var startMousePoint:Point;
		
		private var _roundScrollPosition:Boolean = true;
		
		private var timer:Timer;
		
		/**
		 * Создает компонент Scrollbar
		 * @param	type тип скруллбара: ScrollbarType.VERTICAL или
		 * ScrollbarType.HORIZONTAL
		 * @param	viewportSize размер видимой области прокручиваемого объекта
		 * по нужной оси.
		 * @param	minScrollPosition
		 * @param	maxScrollPosition
		 * @param	roundScrollPosition
		 */
		public function Scrollbar(type:String, wholeSize:Number = 1, 
			minScrollPosition:Number = 0, maxScrollPosition:Number = 0, 
			roundScrollPosition:Boolean = true)
		{
			super();
			this.type = type;
			_wholeSize = wholeSize;
			this.minScrollPosition = minScrollPosition;
			this.maxScrollPosition = maxScrollPosition;
			_scrollPosition = minScrollPosition;
			_middleButton = new ScrollbarDragButton(type);
			backgroundButton = new Sprite();
			
			if (type == ScrollbarType.VERTICAL)
			{
				_componentWidth = 14;
				_componentHeight = 100;
				_minHeight = 30;
				_firstButton = new ScrollbarArrowButton(ScrollbarArrowButton.UP);
				_lastButton = new ScrollbarArrowButton(ScrollbarArrowButton.DOWN);
			}
			else if (type == ScrollbarType.HORIZONTAL)
			{
				_componentWidth = 100;
				_componentHeight = 14;
				_minWidth = 30;
				_firstButton = new ScrollbarArrowButton(ScrollbarArrowButton.LEFT);
				_lastButton = new ScrollbarArrowButton(ScrollbarArrowButton.RIGHT);
			}
			// TODO: при перетаскивании ползунка зажатость сделана криво
			
			addChild(backgroundButton);
			addChild(_middleButton);
			if (type == ScrollbarType.VERTICAL)
			{
				addChild(_firstButton);
				addChild(_lastButton);
			}
			else if (type == ScrollbarType.HORIZONTAL)
			{
				addChild(_firstButton);
				addChild(_lastButton);
			}
			
			backgroundButton.addEventListener(MouseEvent.MOUSE_DOWN, onBackgroundMouseDown);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_middleButton.addEventListener(MouseEvent.MOUSE_DOWN, onSliderPress);
			_firstButton.addEventListener(MouseEvent.MOUSE_DOWN, onFirstButtonPress);
			_lastButton.addEventListener(MouseEvent.MOUSE_DOWN, onLastButtonPress);
		}
		
		private function onBackgroundMouseDown(e:MouseEvent):void
		{
			orientateToMousePosition();
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onBackgroundMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onBackgroundMouseUp);
		}
		
		private function orientateToMousePosition():void
		{
			if (type == ScrollbarType.VERTICAL)
			{
				scrollPosition = (mouseY - _firstButton.componentHeight - _middleButton.componentHeight / 2)
					* (maxScrollPosition - minScrollPosition)
					/ (componentHeight - _firstButton.componentHeight - _lastButton.componentHeight
					- _middleButton.componentHeight);
			}
			else if (type == ScrollbarType.HORIZONTAL)
			{
				scrollPosition = (mouseX - _firstButton.componentWidth - _middleButton.componentWidth / 2)
					* (maxScrollPosition - minScrollPosition)
					/ (componentWidth - _firstButton.componentWidth - _lastButton.componentWidth
					- _middleButton.componentWidth);
			}
		}
		
		private function onBackgroundMouseUp(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onBackgroundMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onBackgroundMouseUp);
		}
		
		private function onBackgroundMouseMove(e:MouseEvent):void
		{
			orientateToMousePosition();
		}
		
		private function onMouseWheel(e:MouseEvent):void
		{
			if (enabled)
			{
				scrollPosition -= arrowsScrollSize * e.delta;
			}
		}
		
		private function onSliderPress(e:MouseEvent):void
		{
			startMousePoint = new Point(mouseX - _middleButton.x, mouseY - _middleButton.y);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onSliderDrag);
			stage.addEventListener(MouseEvent.MOUSE_UP, onSliderRelease);
		}
		
		private function onSliderDrag(e:MouseEvent):void
		{
			_middleButton.currentState = ButtonState.DOWN_STATE;
			if (type == ScrollbarType.VERTICAL)
			{
				scrollPosition = (mouseY - startMousePoint.y - _firstButton.componentHeight)
					* (maxScrollPosition - minScrollPosition) 
					/ (componentHeight - _firstButton.componentHeight - _lastButton.componentHeight
					- _middleButton.componentHeight);
			}
			else if (type == ScrollbarType.HORIZONTAL)
			{
				scrollPosition = (mouseX - startMousePoint.x - _firstButton.componentWidth)
					* (maxScrollPosition - minScrollPosition)
					/ (componentWidth - _firstButton.componentWidth - _lastButton.componentWidth 
					- _middleButton.componentWidth);
			}
		}
		
		private function onSliderRelease(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSliderDrag);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onSliderRelease);
			stage.removeEventListener(Event.ENTER_FRAME, onScrollTimerTick);
			
			var mousePosition:Point = new Point(stage.mouseX, stage.mouseY);
			var objectsUnderMouse:Array = stage.getObjectsUnderPoint(mousePosition);
			var mouseOverMiddleButton:Boolean = objectsUnderMouse.indexOf(_middleButton) < 0;
			
			if (mouseOverMiddleButton)
			{
				_middleButton.currentState = ButtonState.OVER_STATE;
			}
			else
			{
				_middleButton.currentState = ButtonState.UP_STATE;
			}
		}
		
		private function onFirstButtonPress(e:MouseEvent):void
		{
			scrollPosition -= arrowsScrollSize;
			startTimerScroll();
		}
		
		private function startTimerScroll():void
		{
			timer = new Timer(250, 0);
			timer.addEventListener(TimerEvent.TIMER, onScrollTimerTick);
			timer.start();
			stage.addEventListener(MouseEvent.MOUSE_UP, onArrowButtonRelease);
		}
		
		private function onScrollTimerTick(e:TimerEvent):void
		{
			if (e.target.delay == 250)
			{
				e.target.delay = 50;
			}
			if (_firstButton.currentState == ButtonState.DOWN_STATE)
			{
				scrollPosition -= arrowsScrollSize;
			}
			else if (_lastButton.currentState == ButtonState.DOWN_STATE)
			{
				scrollPosition += arrowsScrollSize;
			}
		}
		
		private function onArrowButtonRelease(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onArrowButtonRelease);
			stopTimerScroll();
		}
		
		private function stopTimerScroll():void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, onScrollTimerTick);
			timer = null;
		}
		
		private function onLastButtonPress(e:MouseEvent):void
		{
			scrollPosition += arrowsScrollSize;
			startTimerScroll();
		}
		
		override public function draw():void
		{
			graphics.clear();
			graphics.lineStyle(1, 0xA3A3A3);
			graphics.beginFill(0xE0E0E0);
			graphics.drawRect(0, 0, componentWidth, componentHeight);
			graphics.endFill();
			backgroundButton.graphics.clear();
			backgroundButton.graphics.beginFill(0, 0);
			if (type == ScrollbarType.VERTICAL)
			{
				_lastButton.y = componentHeight - _lastButton.componentHeight;
				_middleButton.componentWidth = componentWidth;
				backgroundButton.y = _firstButton.y + _firstButton.componentHeight;
				backgroundButton.graphics.drawRect(0, 0, componentWidth, _lastButton.y);
				var newHeight:Number = Math.round((componentHeight - _firstButton.componentHeight
					- _lastButton.componentHeight) / wholeSize
					* (wholeSize - maxScrollPosition + minScrollPosition));
				
				if (componentHeight - _firstButton.componentHeight - _lastButton.componentHeight
					<= _middleButton.minHeight)
				{
					_middleButton.visible = false;
				}
				else if (newHeight 
					>= componentHeight - _firstButton.componentHeight - _lastButton.componentHeight)
				{
					_middleButton.visible = false;
					_firstButton.enabled = false;
					_lastButton.enabled = false;
					enabled = false;
				}
				else
				{
					enabled = true;
					_middleButton.visible = true;
					_firstButton.enabled = true;
					_lastButton.enabled = true;
					_middleButton.componentHeight = newHeight + newHeight % 2;
					_middleButton.y = Math.round(_firstButton.componentHeight
						+ (componentHeight - _firstButton.componentHeight
						- _lastButton.componentHeight - _middleButton.componentHeight)
						/ (maxScrollPosition - minScrollPosition)
						* (scrollPosition - minScrollPosition));
				}
			}
			else if (type == ScrollbarType.HORIZONTAL)
			{
				_lastButton.x = componentWidth - _lastButton.componentWidth;
				_middleButton.componentHeight = componentHeight;
				backgroundButton.x = _firstButton.x + _firstButton.componentWidth;
				backgroundButton.graphics.drawRect(0, 0, _lastButton.x, componentHeight);
				
				var newWidth:Number = Math.round((componentWidth - _firstButton.componentWidth
					- _lastButton.componentWidth) / wholeSize
					* (wholeSize - maxScrollPosition + minScrollPosition));
					
				if (componentWidth - _firstButton.componentWidth - _lastButton.componentWidth
					<= _middleButton.minWidth)
				{
					_middleButton.visible = false;
				}
				else if (newWidth
					>= componentWidth - _firstButton.componentWidth - _lastButton.componentWidth)
				{
					_middleButton.visible = false;
					_firstButton.enabled = false;
					_lastButton.enabled = false;
					enabled = false;
				}
				else
				{
					enabled = true;
					_middleButton.visible = true;
					_firstButton.enabled = true;
					_lastButton.enabled = true;
					_middleButton.componentWidth = newWidth + newWidth % 2;
					_middleButton.x = Math.round(_firstButton.componentWidth 
						+ (componentWidth - _firstButton.componentWidth 
						- _lastButton.componentWidth - _middleButton.componentWidth) 
						/ (maxScrollPosition - minScrollPosition) 
						* (scrollPosition - minScrollPosition));
				}
			}
			_middleButton.cancelInvalidation();
			_middleButton.draw();
			backgroundButton.graphics.endFill();
		}
		
		public function get minScrollPosition():Number
		{
			return _minScrollPosition;
		}
		
		public function set minScrollPosition(value:Number):void
		{
			if (minScrollPosition == value)
			{
				return;
			}
			if (value > maxScrollPosition)
			{
				_minScrollPosition = maxScrollPosition;
			}
			else
			{
				_minScrollPosition = value;
			}
			if (scrollPosition < minScrollPosition)
			{
				scrollPosition = minScrollPosition;
			}
			invalidate();
		}
		
		public function get scrollPosition():Number
		{
			return _scrollPosition;
		}
		
		public function set scrollPosition(value:Number):void
		{
			
			var v:Number = value;
			if (v < minScrollPosition)
			{
				v = minScrollPosition;
			}
			else if (v > maxScrollPosition)
			{
				v = maxScrollPosition;
			}
			v = roundScrollPosition ? v : v;
			if (_scrollPosition != v)
			{
				_scrollPosition = v;
				invalidate();
				dispatchEvent(new Event(Event.CHANGE));
			}
		
		}
		
		public function get maxScrollPosition():Number
		{
			return _maxScrollPosition;
		}
		
		public function set maxScrollPosition(value:Number):void
		{
			if (_maxScrollPosition == value)
			{
				return;
			}
			if (value < minScrollPosition)
			{
				_maxScrollPosition = _maxScrollPosition = value;
			}
			else
			{
				_maxScrollPosition = value;
			}
			if (scrollPosition > maxScrollPosition)
			{
				scrollPosition = maxScrollPosition;
			}
			invalidate();
		}
		
		public function get firstButton():BaseButton { return _firstButton; }
		
		public function get middleButton():BaseButton { return _middleButton; }
		
		public function get lastButton():BaseButton { return _lastButton; }
		
		public function get wholeSize():Number
		{
			return _wholeSize;
		}
		
		public function set wholeSize(value:Number):void
		{
			_wholeSize = value;
			invalidate();
		}
		
		public function get roundScrollPosition():Boolean
		{
			return _roundScrollPosition;
		}
		
		public function set roundScrollPosition(value:Boolean):void
		{
			_roundScrollPosition = value;
		}
		
		public function get arrowsScrollSize():Number
		{
			return _arrowsScrollSize;
		}
		
		public function set arrowsScrollSize(value:Number):void
		{
			_arrowsScrollSize = value;
		}
	
	}

}