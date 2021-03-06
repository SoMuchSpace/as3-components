package SoMuchSpace.components 
{
	import flash.display.Sprite;
	/**
	 * Компонент Панель.
	 * @author SoMuchSpace
	 */
	public class Panel extends Component
	{
		protected var _containerMask:Sprite = new Sprite();
		
		private var _background:Boolean = false;
		private var _backgroundColor:Number = 0xFFFFFF;
		private var _backgroundAlpha:Number = 1;
		
		private var _border:Boolean = false;
		private var _borderColor:Number = 0x000000;
		private var _borderAlpha:Number = 1;
		
		private var _container:Container = new Container();
		
		/**
		 * Создает объект Panel.
		 */
		public function Panel(componentWidth:Number = 100, componentHeight:Number = 100) 
		{
			super();
			
			_border = true;
			_borderColor = 0xD0D0D0;
			_background = true;
			_backgroundColor = 0xF9F9F9;
			
			_componentWidth = componentWidth;
			_componentHeight = componentHeight;
			
			addChild(_container);
			addChild(_containerMask);
			_container.mask = _containerMask;
			
			_containerMask.graphics.beginFill(0x000000, 1);
			_containerMask.graphics.drawRect(0, 0, componentWidth, componentHeight);
			_containerMask.graphics.endFill();
			_container.mask = _containerMask;
		}
		
		override public function draw():void 
		{
			super.draw();
			graphics.clear();
			if (background)
			{
				graphics.beginFill(backgroundColor, backgroundAlpha);
			}
			if (border)
			{
				graphics.lineStyle(1, borderColor, borderAlpha);
			}
			graphics.drawRect(0, 0, componentWidth, componentHeight);
			graphics.endFill();
			
			_containerMask.width = componentWidth;
			_containerMask.height = componentHeight;
		}
		
		public function get background():Boolean { return _background; }
		
		public function set background(value:Boolean):void 
		{
			_background = value;
			invalidate();
		}
		
		public function get backgroundColor():Number { return _backgroundColor; }
		
		public function set backgroundColor(value:Number):void 
		{
			_backgroundColor = value;
			invalidate();
		}
		
		public function get border():Boolean { return _border; }
		
		public function set border(value:Boolean):void 
		{
			_border = value;
			invalidate();
		}
		
		public function get borderColor():Number { return _borderColor; }
		
		public function set borderColor(value:Number):void 
		{
			_borderColor = value;
			invalidate();
		}
		
		public function get container():Container { return _container; }
		
		public function get backgroundAlpha():Number 
		{
			return _backgroundAlpha;
		}
		
		public function set backgroundAlpha(value:Number):void 
		{
			_backgroundAlpha = value;
			invalidate();
		}
		
		public function get borderAlpha():Number 
		{
			return _borderAlpha;
		}
		
		public function set borderAlpha(value:Number):void 
		{
			_borderAlpha = value;
			invalidate();
		}
	}

}