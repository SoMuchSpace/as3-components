package SoMuchSpace.components 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * Конмонент Конопка.
	 * @author SoMuchSpace
	 */
	public class BaseButton extends Component
	{	
		
		private var _canToggle:Boolean = false;
		
		private var _haveOverState:Boolean = false;
		private var _haveDownState:Boolean = false;
		private var _haveSelectedOverState:Boolean = false;
		private var _haveToggledState:Boolean = false;
		
		private var _toggled:Boolean = false;
		
		private var _cuttentState:String = ButtonState.UP_STATE;
		
		private var _mouseIsDown:Boolean = false;
		private var _mouseIsOver:Boolean = false;
		
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
			_mouseIsOver = true;
			if (canToggle && toggled)
			{
				if (_haveSelectedOverState && !_mouseIsDown)
				{
					currentState = ButtonState.SELECTED_OVER_STATE;
				}
				else
				{
					currentState = ButtonState.DOWN_STATE;
				}
			}
			else
			{
				if (_mouseIsDown)
				{
					currentState = ButtonState.DOWN_STATE;
				}
				else
				{
					if (_haveOverState)
					{
						currentState = ButtonState.OVER_STATE;
					}
					else
					{
						currentState = ButtonState.UP_STATE;
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
			_mouseIsOver = false;
			if (canToggle)
			{
				if (toggled)
				{
					currentState = ButtonState.DOWN_STATE;
				}
				else
				{
					currentState = ButtonState.UP_STATE;
				}
			}
			else
			{
				currentState = ButtonState.UP_STATE;
			}
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			_mouseIsDown = true;
			currentState = ButtonState.DOWN_STATE;
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			_mouseIsDown = false;
			if (_mouseIsOver && canToggle)
			{
				toggled = !toggled;
			}
			if (canToggle && _toggled)
			{
				if (_mouseIsOver && _haveSelectedOverState)
				{
					currentState = ButtonState.SELECTED_OVER_STATE;
				}
				else
				{
					currentState = ButtonState.TOGGLED_STATE;
				}
			}
			else
			{
				if (_mouseIsOver && _haveOverState)
				{
					currentState = ButtonState.OVER_STATE;
				}
				else
				{
					currentState = ButtonState.UP_STATE;
				}
			}
		}
		
		override public function draw():void 
		{
			switch (currentState) 
			{
				case ButtonState.UP_STATE:
					upView();
					break;
				case ButtonState.OVER_STATE:
					overView();
					break;
				case ButtonState.DOWN_STATE:
					downView();
					break;
				case ButtonState.TOGGLED_STATE:
					toggledView();
					break;
				case ButtonState.SELECTED_OVER_STATE:
					selectedOverView();
					break;
				case ButtonState.NOT_ENABLED_STATE:
					notEnabledView();
					break;
				default:
				upView();
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
					currentState = ButtonState.UP_STATE;
				}
				else
				{
					currentState = ButtonState.NOT_ENABLED_STATE;
				}
			}
			super.enabled = value;
		}
		
		/**
		 * Залипает кнопка при нажатии или нет.
		 */
		public function get canToggle():Boolean { return _canToggle; }
		
		public function set canToggle(value:Boolean):void 
		{
			_canToggle = value;
		}
		
		/**
		 * Нажата кнопка или нет.
		 */
		public function get toggled():Boolean { return _toggled; }
		
		public function set toggled(value:Boolean):void 
		{
			if (_canToggle && toggled != value)
			{
				if (value)
				{
					_toggled = value;
					currentState = ButtonState.DOWN_STATE;
					
				}
				else
				{
					_toggled = value;
					currentState = ButtonState.UP_STATE;
					
				}
				dispatchEvent(new Event(Event.SELECT));
			}
			
		}
		
		/**
		 * Реагирует ли кнопка на наведение на нее курсора
		 */
		public function get haveOverState():Boolean { return _haveOverState; }
		
		public function set haveOverState(value:Boolean):void 
		{
			_haveOverState = value;
		}
		
		/**
		 * Реагирует ли кнопка на нажатие на нее
		 */
		public function get haveDownState():Boolean { return _haveDownState; }
		
		public function set haveDownState(value:Boolean):void 
		{
			_haveDownState = value;
		}
		
		/**
		 * Изменяет ли свой вид кнопка при наведении на нее курсора в нажатом состоянии
		 */
		public function get haveSelectedOverState():Boolean { return _haveSelectedOverState; }
		
		public function set haveSelectedOverState(value:Boolean):void 
		{
			_haveSelectedOverState = value;
		}
		
		/**
		 * Текущее состояние кнопки
		 */
		public function get currentState():String { return _cuttentState; }
		
		public function set currentState(value:String):void 
		{
			_cuttentState = value;
			draw();
		}
		
	}

}