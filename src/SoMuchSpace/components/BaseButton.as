package SoMuchSpace.components 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * Конмонент Конопка.
	 * @author DanPo
	 */
	public class BaseButton extends Component
	{	
		public static const UP_STATE:String = "upState";
		public static const OVER_STATE:String = "overState";
		public static const DOWN_STATE:String = "downState";
		public static const SELECTED_OVER_STATE:String = "selectedOverState";
		public static const TOGGLED_STATE:String = "toggledState";
		public static const NOT_ENABLED_STATE:String = "notEnabledState";
		
		private var _toggle:Boolean = false;
		private var _over:Boolean = false;
		private var _down:Boolean = false;
		private var _selectedOver:Boolean = false;
		
		private var _selected:Boolean = false;
		
		private var _state:String = UP_STATE;
		private var _pressed:Boolean = false;
		private var _overed:Boolean = false;
		
		/**
		 * Создает объект BaseButton. По умолчанию размер компонента 50x20.
		 */
		public function BaseButton() 
		{
			super();
			_componentWidth = 50;
			_componentHeight = 20;
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
		}
		
		private function rollOverHandler(e:MouseEvent):void 
		{
			_overed = true;
			if (toggle && selected)
			{
				if (_selectedOver && !_pressed)
				{
					state = SELECTED_OVER_STATE;
				}
				else
				{
					state = DOWN_STATE;
				}
			}
			else
			{
				if (_pressed)
				{
					state = DOWN_STATE;
				}
				else
				{
					if (_over)
					{
						state = OVER_STATE;
					}
					else
					{
						state = UP_STATE;
					}
				}
			}
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
		}
		
		private function rollOutHandler(e:MouseEvent):void 
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			_overed = false;
			if (toggle)
			{
				if (selected)
				{
					state = DOWN_STATE;
				}
				else
				{
					state = UP_STATE;
				}
			}
			else
			{
				state = UP_STATE;
			}
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			_pressed = true;
			state = DOWN_STATE;
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			_pressed = false;
			if (_overed && toggle)
			{
				selected = !selected;
			}
			if (toggle && _selected)
			{
				if (_overed && _selectedOver)
				{
					state = SELECTED_OVER_STATE;
				}
				else
				{
					state = DOWN_STATE;
				}
			}
			else
			{
				if (_overed && _over)
				{
					state = OVER_STATE;
				}
				else
				{
					state = UP_STATE;
				}
			}
		}
		
		override public function draw():void 
		{
			super.draw();
			if (state == UP_STATE)
			{
				upView();
			}
			else if(state == OVER_STATE)
			{
				overView();
			}
			else if (state == DOWN_STATE)
			{
				downView();
			}
			else if (state == TOGGLED_STATE)
			{
				toggledView();
			}
			else if (state == SELECTED_OVER_STATE)
			{
				selectedOverView();
			}
			else if (state == NOT_ENABLED_STATE)
			{
				notEnabledView();
			}
		}
		
		/**
		 * Вид компонента в обычном состоянии.
		 */
		protected function upView():void
		{
			graphics.clear();
			graphics.lineStyle(1, 0xC0C0C0);
			graphics.beginFill(0x0080FF);
			graphics.drawRect(0, 0, componentWidth, componentHeight);
			graphics.endFill();
		}
		
		/**
		 * Вид компонента при наведении на него курсора мыши.
		 */
		protected function overView():void
		{
			graphics.clear();
			graphics.lineStyle(1);
			graphics.beginFill(0x0080FF);
			graphics.drawRect(0, 0, componentWidth, componentHeight);
			graphics.endFill();
		}
		
		/**
		 * Вид компонента при нажатии на него.
		 */
		protected function downView():void
		{
			graphics.clear();
			graphics.lineStyle(1, 0xC0C0C0);
			graphics.beginFill(0x004182);
			graphics.drawRect(0, 0, componentWidth, componentHeight);
			graphics.endFill();
		}
		
		/**
		 * Вид компонента в переключенном состоянии. По умолчанию равно downView()
		 */
		protected function toggledView():void
		{
			downView();
		}
		
		/**
		 * Вид компонента при наведении на него курсора мыши в нажатом состоянии.
		 */
		protected function selectedOverView():void
		{
			graphics.clear();
			graphics.lineStyle(1);
			graphics.beginFill(0x004182);
			graphics.drawRect(0, 0, componentWidth, componentHeight);
			graphics.endFill();
		}
		
		/**
		 * Вид конмпонента когда его состояние неактивно
		 */
		protected function notEnabledView():void
		{
			graphics.clear();
			graphics.lineStyle(1);
			graphics.beginFill(0x00FFFF);
			graphics.drawRect(0, 0, componentWidth, componentHeight);
			graphics.endFill();
		}
		
		override public function get enabled():Boolean { return super.enabled; }
		
		override public function set enabled(value:Boolean):void 
		{
			if (enabled != value)
			{
				if (value)
				{
					state = UP_STATE;
				}
				else
				{
					state = NOT_ENABLED_STATE;
				}
			}
			super.enabled = value;
		}
		
		/**
		 * Залипает кнопка при нажатии или нет.
		 */
		public function get toggle():Boolean { return _toggle; }
		
		public function set toggle(value:Boolean):void 
		{
			_toggle = value;
		}
		
		/**
		 * Нажата кнопка или нет.
		 */
		public function get selected():Boolean { return _selected; }
		
		public function set selected(value:Boolean):void 
		{
			if (_toggle && selected != value)
			{
				
				if (value)
				{
					_selected = value;
					state = DOWN_STATE;
					
				}
				else
				{
					_selected = value;
					state = UP_STATE;
					
				}
				dispatchEvent(new Event(Event.SELECT));
			}
			
		}
		
		/**
		 * Реагирует ли кнопка на наведение на нее курсора
		 */
		public function get over():Boolean { return _over; }
		
		public function set over(value:Boolean):void 
		{
			_over = value;
		}
		
		/**
		 * Реагирует ли кнопка на нажатие на нее
		 */
		public function get down():Boolean { return _down; }
		
		public function set down(value:Boolean):void 
		{
			_down = value;
		}
		
		/**
		 * Изменяет ли свой вид кнопка при наведении на нее курсора в нажатом состоянии
		 */
		public function get selectedOver():Boolean { return _selectedOver; }
		
		public function set selectedOver(value:Boolean):void 
		{
			_selectedOver = value;
		}
		
		/**
		 * Текущее состояние кнопки
		 */
		public function get state():String { return _state; }
		
		public function set state(value:String):void 
		{
			_state = value;
			invalidate();
		}
		
	}

}