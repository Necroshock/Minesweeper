package events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author John Everson
	 */
	public class LevelSelectEvent extends Event 
	{
		public static const LEVEL:String = "LEVEL";
		public static const MENU:String = "MENU";
		public static const EASY:String = "EASY";
		public static const MEDIUM:String = "MEDIUM";
		public static const HARD:String = "HARD";
		
		public var Difficulty:String;
		
		public function LevelSelectEvent(type:String, difficulty:String) 
		{
			super(type);
			Difficulty = difficulty;
		}
		
	}

}