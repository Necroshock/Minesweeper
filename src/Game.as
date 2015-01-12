package  
{
	import events.GameEndEvent;
	import events.LevelSelectEvent;
	import events.ResetEvent;
	import model.MinesweeperModel;
	import panels.LevelCompletePanel;
	import panels.MenuPanel;
	import starling.display.Sprite;
	import starling.events.Event;
	import view.MinesweeperView;
	
	/**
	 * ...
	 * @author John Everson
	 */
	public class Game extends Sprite 
	{
		private var _stageHeight:int;
		private var _stageWidth:int;
		private var _menu:MenuPanel;
		private var _popup:LevelCompletePanel;
		private var _view:MinesweeperView;
		private var _model:MinesweeperModel;
		
		public function Game() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_stageHeight = stage.stageHeight;
			_stageWidth = stage.stageWidth;
			
			OpenMenu();
		}
		
		private function OpenMenu():void
		{
			_menu = new MenuPanel();
			addChild(_menu);
			_menu.x = _stageWidth / 2;
			_menu.y = _stageHeight / 2;
			_menu.Open();
			_menu.addEventListener(LevelSelectEvent.LEVEL, onLevelSelected);
		}
		
		private function CloseMenu():void
		{
			removeChild(_menu);
			_menu.Close();
			_menu.removeEventListener(LevelSelectEvent.LEVEL, onLevelSelected);
		}
		
		private function onLevelSelected(e:LevelSelectEvent):void 
		{
			switch(e.Difficulty)
			{
				case LevelSelectEvent.EASY:
					ResetGame(0);
					break;
				case LevelSelectEvent.MEDIUM:
					ResetGame(1);
					break;
				case LevelSelectEvent.HARD:
				default:
					ResetGame(2);
					break;
			}
			CloseMenu();
		}
		
		
		private function ResetGame(diff:int):void
		{	
			_model = new MinesweeperModel();
			_model.Reset(diff);
			_model.addEventListener(GameEndEvent.WIN, onWin);
			_model.addEventListener(GameEndEvent.LOSE, onLose);
			
			_view = new MinesweeperView(_model);
			_view.x = _stageWidth / 2;
			_view.y = _stageHeight / 2;
			addChild(_view);
		}
		
		private function onWin(e:GameEndEvent):void 
		{
			_popup = new LevelCompletePanel();
			addChild(_popup);
			_popup.Open("You Win!");
			_popup.x = _stageWidth / 2;
			_popup.y = _stageHeight / 2;
			
			_model.removeEventListener(GameEndEvent.WIN, onWin);
			_model.removeEventListener(GameEndEvent.LOSE, onLose);
			
			_popup.addEventListener(ResetEvent.TRIGGERED, onReset);
			_popup.addEventListener(LevelSelectEvent.MENU, onBackToMenu);
		}
		
		private function onLose(e:GameEndEvent):void 
		{
			_popup = new LevelCompletePanel();
			addChild(_popup);
			_popup.Open("You Lost!");
			_popup.x = _stageWidth / 2;
			_popup.y = _stageHeight / 2;
			
			_model.removeEventListener(GameEndEvent.WIN, onWin);
			_model.removeEventListener(GameEndEvent.LOSE, onLose);
			
			_popup.addEventListener(ResetEvent.TRIGGERED, onReset);
			_popup.addEventListener(LevelSelectEvent.MENU, onBackToMenu);
		}
		
		private function onBackToMenu(e:LevelSelectEvent):void 
		{
			removeChild(_popup);
			_popup.removeEventListener(ResetEvent.TRIGGERED, onReset);
			_popup.removeEventListener(LevelSelectEvent.MENU, onBackToMenu);
			_popup.Close();
			
			_model = null;
			removeChild(_view);
			_view = null;
			
			OpenMenu();
		}
		
		private function onReset(e:ResetEvent):void 
		{
			removeChildren();
			
			_popup.removeEventListener(ResetEvent.TRIGGERED, onReset);
			_popup.removeEventListener(LevelSelectEvent.MENU, onBackToMenu);
			_popup.Close();
			
			ResetGame(_model.Difficulty);
		}
	}

}