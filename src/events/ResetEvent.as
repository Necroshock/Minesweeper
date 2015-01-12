package events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author John Everson
	 */
	public class ResetEvent extends Event 
	{
		public static const TRIGGERED:String = "TRIGGERED";
		public function ResetEvent() 
		{
			super(TRIGGERED);
			
		}
		
	}

}