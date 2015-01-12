package view 
{
	import flash.ui.Keyboard;
	import model.MinesweeperModel;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	/**
	 * ...
	 * @author John Everson
	 */
	public class MinesweeperView extends Sprite
	{	
		private var _model:MinesweeperModel;
		private var _nodes:Vector.<NodeButton>;
		private var _ctrlDown:Boolean = false;
		
		public function MinesweeperView(model:MinesweeperModel) 
		{
			_nodes = new Vector.<NodeButton>();
			
			_model = model;
			
			BuildGrid();
			
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function BuildGrid():void
		{
			//make a button to have a size reference
			var button:NodeButton = new NodeButton(0,0, null);
			
			var sizeX:int = _model.MineGrid.SizeX;
			var sizeY:int = _model.MineGrid.SizeY;
			var projWidth:Number = sizeX * button.width;
			var projHeight:Number = sizeY * button.height;
			
			for (var i:int = 0; i < sizeX; ++i)
			{
				for (var j:int = 0; j < sizeY; ++j)
				{
					button = new NodeButton(i, j, _model.MineGrid.GetNodeAtPosition(i,j));
					button.alignPivot();
					button.x = -(projWidth / 2) + (button.width / 2) + (button.width * i);
					button.y = -(projHeight / 2) + (button.height / 2) + (button.height * j);
					button.addEventListener(Event.TRIGGERED, onNodePressed);
					_nodes.push(button);
					addChild(button);
				}
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.CONTROL)
			{
				_ctrlDown = false;
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.CONTROL)
			{
				_ctrlDown = true;
			}
		}
		
		private function onNodePressed(e:Event):void 
		{
			var node:NodeButton = e.target as NodeButton;
			
			if (_ctrlDown)
			{
				_model.FlagNode(node.PosX, node.PosY);
			}
			else
			{
				_model.RevealTile(node.PosX, node.PosY);
			}
			
			
			for each (node in _nodes)
			{
				node.Refresh();
			}
		}
		
	}

}