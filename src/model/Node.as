package model 
{
	/**
	 * ...
	 * @author John Everson
	 */
	public class Node 
	{
		public var revealed:Boolean = false;
		public var isMine:Boolean = false;
		public var isFlagged:Boolean = false;
		public var adjacentBombs:int = 0;
		
		public function Node() 
		{
			
		}
	}

}