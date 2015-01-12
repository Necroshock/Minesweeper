package events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author John Everson
	 */
	public class GameEndEvent extends Event 
	{
		public static const WIN:String = "WIN";
		public static const LOSE:String = "LOSE";
		
		public function GameEndEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
			
		}
		
	}

}