package model 
{
	import events.GameEndEvent;
	import starling.events.EventDispatcher;
	/**
	 * ...
	 * @author John Everson
	 */
	public class MinesweeperModel extends EventDispatcher
	{
		private var _authority:MinesweeperAuthority;
		private var _difficulty:int;
		internal var _grid:Grid;
		internal var _gameWon:Boolean = false;
		internal var _gameLost:Boolean = false;
		
		public function MinesweeperModel() 
		{
			_authority = new MinesweeperAuthority(this);
		}
		
		public function Reset(difficulty:int):void
		{
			_grid = new Grid();
			_difficulty = difficulty;
			switch(_difficulty)
			{
				case 0:
					_grid.Reset(4, 4);
					break;
				case 1:
					_grid.Reset(6, 6);
					break;
				case 2:
				default:
					_grid.Reset(8, 8);
					break;
			}
			var mines:int = _grid.Size / 6;
			var minesPlanted:int = 0;
			do 
			{
				var mineIndex:int = int(Math.random() * _grid.Size);
				var node:Node = _grid.GetNodeAtIndex(mineIndex);
				if (!node.isMine)
				{
					node.isMine = true;
					minesPlanted++;
				}
			} while (minesPlanted < mines);
			
			MarkAllHints();
		}
		
		private function MarkAllHints():void
		{
			for (var i:int = 0; i < _grid.SizeX; ++i)
			{
				for (var j:int = 0; j < _grid.SizeY; ++j)
				{
					var baseNode:Node = _grid.GetNodeAtPosition(i, j);
					if (baseNode.isMine) continue;
					
					//check all adjacent nodes for mines
					var node:Node = _grid.GetNodeAtPosition(i - 1, j);
					if (node && node.isMine) baseNode.adjacentBombs++;
					
					node = _grid.GetNodeAtPosition(i - 1, j - 1);
					if (node && node.isMine) baseNode.adjacentBombs++;
					
					node = _grid.GetNodeAtPosition(i, j - 1);
					if (node && node.isMine) baseNode.adjacentBombs++;
					
					node = _grid.GetNodeAtPosition(i + 1, j - 1);
					if (node && node.isMine) baseNode.adjacentBombs++;
					
					node = _grid.GetNodeAtPosition(i + 1, j);
					if (node && node.isMine) baseNode.adjacentBombs++;
					
					node = _grid.GetNodeAtPosition(i + 1, j + 1);
					if (node && node.isMine) baseNode.adjacentBombs++;
					
					node = _grid.GetNodeAtPosition(i, j + 1);
					if (node && node.isMine) baseNode.adjacentBombs++;
					
					node = _grid.GetNodeAtPosition(i - 1, j + 1);
					if (node && node.isMine) baseNode.adjacentBombs++;
				}
			}
		}
		
		public function Sweep(posX:int, posY:int):void
		{
			var baseNode:Node = _grid.GetNodeAtPosition(posX, posY);
			baseNode.revealed = true;
			if (baseNode.isMine || baseNode.adjacentBombs > 0) return;
			
			var node:Node = _grid.GetNodeAtPosition(posX - 1, posY);
			if (node && !node.revealed && !node.isMine) Sweep(posX - 1, posY);
			
			node = _grid.GetNodeAtPosition(posX, posY - 1);
			if (node && !node.revealed && !node.isMine) Sweep(posX, posY - 1);
			
			node = _grid.GetNodeAtPosition(posX + 1, posY);
			if (node && !node.revealed && !node.isMine) Sweep(posX + 1, posY);
			
			node = _grid.GetNodeAtPosition(posX, posY + 1);
			if (node && !node.revealed && !node.isMine) Sweep(posX, posY + 1);
		}
		
		public function RevealTile(posX:int, posY:int):void
		{
			var node:Node = _grid.GetNodeAtPosition(posX, posY);
			if (node.isFlagged) return;
			Sweep(posX, posY);
			
			_authority.CheckConditions();
		}
		
		public function FlagNode(posX:int, posY:int):void
		{
			var node:Node = _grid.GetNodeAtPosition(posX, posY);
			node.isFlagged = !node.isFlagged;
			
			_authority.CheckConditions();
		}
		
		internal function DispatchWin():void
		{
			dispatchEvent(new GameEndEvent(GameEndEvent.WIN));
		}
		
		internal function DispatchLoss():void
		{
			dispatchEvent(new GameEndEvent(GameEndEvent.LOSE));
		}
		
		public function get MineGrid():Grid		{	return _grid;		}
		public function get Difficulty():int	{	return _difficulty;	}
	}

}