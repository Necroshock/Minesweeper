package model 
{
	/**
	 * ...
	 * @author John Everson
	 */
	public class MinesweeperAuthority 
	{
		private var _model:MinesweeperModel;
		
		public function MinesweeperAuthority(model:MinesweeperModel) 
		{
			_model = model;
		}
		
		public function CheckConditions():void
		{
			var numMines:int = 0;
			var numFlags:int = 0;
			var unflaggedMines:int = 0;
			if (_model._gameWon || _model._gameLost) return;
			for each(var node:Node in _model._grid._nodes)
			{
				if (node.isMine)
				{
					numMines ++;
					if (node.revealed)
					{
						_model._gameLost = true;
						_model.DispatchLoss();
					}
					if (node.isFlagged)
					{
						numFlags++;
					}
					else
					{
						unflaggedMines++;
					}
				}
				else if (node.isFlagged)
				{
					numFlags++;
				}
			}
			if (numFlags == numMines && unflaggedMines == 0)
			{
				_model._gameWon = true;
				_model.DispatchWin();
			}
		}
	}

}