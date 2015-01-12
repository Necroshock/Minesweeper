package model 
{
	/**
	 * ...
	 * @author John Everson
	 */
	public class Grid 
	{
		private var _sizeX:int;
		private var _sizeY:int;
		internal var _nodes:Vector.<Node>;
		
		public function Grid() 
		{
			
		}
		
		public function Reset(sizeX:int, sizeY:int):void
		{
			_sizeX = sizeX;
			_sizeY = sizeY;
			_nodes = new Vector.<Node>();
			for (var i:int = 0; i < sizeX * sizeY; ++i)
			{
				_nodes.push(new Node());
			}
		}
		
		public function GetNodeAtPosition(x:int, y:int):Node
		{
			var index:int = (_sizeX * y) + x;
			if (y >= SizeY || y < 0 || x >= SizeX || x < 0) return null;
			if (index < 0 || index > _nodes.length) return null;
			return _nodes[index];
		}
		
		public function GetNodeAtIndex(index:int):Node
		{
			return _nodes[index];
		}
		
		public function get SizeX():int	{	return _sizeX;			}
		public function get SizeY():int	{	return _sizeY;			}
		public function get Size():int	{	return _nodes.length;	}
	}

}