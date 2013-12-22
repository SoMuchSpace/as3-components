package SoMuchSpace.components 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import SoMuchSpace.components.events.ComponentEvent;
	/**
	 * Базовый класс для компонентов.
	 * @author SoMuchSpace
	 */
	[Event(name="resizeComponent", type="SoMuchSpace.components.events.ComponentEvent")]
	[Event(name="moveComponent", type="SoMuchSpace.components.events.ComponentEvent")]
	public class Component extends Sprite
	{
		
		protected var _componentHeight:Number = 0;
		protected var _componentWidth:Number = 0;
		
		protected var _minWidth:Number = 0;
		protected var _minHeight:Number = 0;
		protected var _maxWidth:Number = 0;
		protected var _maxHeight:Number = 0;
		
		private var _defaultMouseEnabled:Boolean = true;
		private var _defaultMouseChildren:Boolean = true;
		
		protected var _enabled:Boolean = true;
		
		/**
		 * Создает объект Component. Наследникам обязательно вызывать super(), иначе объект не будут инициализироваться.
		 */
		public function Component() 
		{
			mouseChildren = true;
			mouseEnabled = true;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			init();
			draw();
		}
		
		/**
		 * Инициализирует класс. Вызывается при добавлении компонента в спсиок отображения. При переопределении обязятельно вызывать super.init().
		 */
		protected function init():void
		{
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		/**
		 * Перерисовывает компонент.
		 */
		public function draw():void
		{
			
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			uninit();
		}
		
		/**
		 * Очищает класс. Вызывается при удалении компонента из списка отображения.
		 */
		protected function uninit():void
		{
			
		}
		
		public function invalidate():void
		{
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		private function onInvalidate(e:Event):void 
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
		}
		
		public function get componentHeight():Number { return _componentHeight; }
		
		public function set componentHeight(value:Number):void 
		{
			var newHeight:Number = getValidatedHeight(value);
			if (_componentHeight == newHeight)
			{
				return;
			}
			_componentHeight = newHeight;
			if (stage)
			{
				draw();
			}
			//invalidate();
			dispatchEvent(new ComponentEvent(ComponentEvent.RESIZE));
		}
		
		private function getValidatedHeight(height:Number):Number
		{
			var correctHeight:Number = Math.abs(height);
			if (correctHeight < minHeight)
			{
				correctHeight = minHeight;
			}
			else if (maxHeight && correctHeight>maxHeight)
			{
				correctHeight = maxHeight;
			}
			return correctHeight;
		}
		
		public function get componentWidth():Number { return _componentWidth; }
		
		public function set componentWidth(value:Number):void 
		{
			var newWidth:Number = getValidatedWidth(value);
			if (_componentWidth == newWidth)
			{
				return;
			}
			_componentWidth = newWidth;
			if (stage)
			{
				draw();
			}
			//invalidate();
			dispatchEvent(new ComponentEvent(ComponentEvent.RESIZE));
		}
		
		private function getValidatedWidth(width:Number):Number
		{
			var correctWidth:Number = Math.abs(width);
			if (correctWidth < minWidth)
			{
				correctWidth = minWidth;
			}
			else if (maxWidth && correctWidth > maxWidth)
			{
				correctWidth = maxWidth;
			}
			return correctWidth;
		}
		
		/**
		 * Меняет размеры компонента.
		 * @param	width новая ширина компонента
		 * @param	height новая высота компонента
		 */
		public function setComponentSize(width:Number, height:Number):void
		{
			var newWidth:Number = getValidatedWidth(width);
			var newHeight:Number = getValidatedWidth(height);
			if (_componentWidth == newWidth && _componentHeight == newHeight)
			{
				return;
			}
			_componentWidth = newWidth;
			_componentHeight = newHeight;
			if (stage)
			{
				draw();
			}
			//invalidate();
			dispatchEvent(new ComponentEvent(ComponentEvent.RESIZE));
		}
		
		/**
		 * Положение компонента по оси X
		 */
		override public function get x():Number { return super.x; }
		
		override public function set x(value:Number):void 
		{
			super.x = value;
			dispatchEvent(new ComponentEvent(ComponentEvent.MOVE));
		}
		
		/**
		 * Положение компонента по оси Y
		 */
		override public function get y():Number { return super.y; }
		
		override public function set y(value:Number):void 
		{
			super.y = value;
			dispatchEvent(new ComponentEvent(ComponentEvent.MOVE));
		}
		
		public function move(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
			dispatchEvent(new ComponentEvent(ComponentEvent.MOVE));
		}
		
		/**
		 * Активен ли компонент
		 */
		public function get enabled():Boolean { return _enabled; }
		
		public function set enabled(value:Boolean):void 
		{
			if (_enabled == value)
			{
				return;
			}
			if (value)
			{
				mouseEnabled = _defaultMouseEnabled;
				mouseChildren = _defaultMouseChildren;
			}
			else
			{
				_defaultMouseEnabled = mouseEnabled;
				_defaultMouseChildren = mouseChildren;
				mouseEnabled = false;
				mouseChildren = false;
			}
			_enabled = value;
		}
		
		public function get minWidth():Number { return _minWidth; }
		
		public function set minWidth(value:Number):void 
		{
			_minWidth = value;
			if (componentWidth < minWidth)
			{
				_componentWidth = minWidth;
			}
		}
		
		public function get minHeight():Number { return _minHeight; }
		
		public function set minHeight(value:Number):void 
		{
			_minHeight = value;
			if (componentHeight < minHeight)
			{
				_componentHeight = minHeight;
			}
		}
		
		public function get maxWidth():Number { return _maxWidth; }
		
		public function set maxWidth(value:Number):void 
		{
			_maxWidth = value;
			if (componentWidth > maxWidth)
			{
				_componentWidth = maxWidth;
			}
		}
		
		public function get maxHeight():Number { return _maxHeight; }
		
		public function set maxHeight(value:Number):void 
		{
			_maxHeight = value;
			if (componentHeight > maxHeight)
			{
				_componentHeight = maxHeight;
			}
		}
	}

}