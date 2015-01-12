package panels 
{
	import adobe.utils.CustomActions;
	import events.LevelSelectEvent;
	import events.ResetEvent;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author John Everson
	 */
	public class LevelCompletePanel extends Sprite
	{
		[Embed(source="../../bin/textures/gray.png")]
		public static const Background:Class;
		[Embed(source="../../bin/textures/empty.png")]
		public static const Empty:Class;
		
		private var _resetButton:Button;
		private var _menuButton:Button;
		
		public function LevelCompletePanel() 
		{
			
		}
		
		public function Open(message:String):void
		{
			var texture:Texture = Texture.fromEmbeddedAsset(Background)
			var background:Image = new Image(texture);
			background.alignPivot();
			addChild(background);
			background.width = 500;
			background.height = 400;
			background.alpha = 0.75;
			
			var textField:TextField = new TextField(500, 400, message, "Verdana", 20, 0xFF0000);
			textField.alignPivot();
			addChild(textField);
			
			texture = Texture.fromEmbeddedAsset(Empty);
			_resetButton = new Button(texture, "Reset");
			_resetButton.alignPivot();
			_resetButton.y += 100;
			_resetButton.x -= 100;
			addChild(_resetButton);
			_resetButton.addEventListener(Event.TRIGGERED, onResetClicked);
			
			_menuButton = new Button(texture, "Menu");
			_menuButton.alignPivot();
			_menuButton.y += 100;
			_menuButton.x += 100;
			addChild(_menuButton); 
			_menuButton.addEventListener(Event.TRIGGERED, onMenuClicked);
		}
		
		private function onResetClicked(e:Event):void 
		{
			dispatchEvent(new ResetEvent());
		}
		
		private function onMenuClicked(e:Event):void 
		{
			dispatchEvent(new LevelSelectEvent(LevelSelectEvent.MENU, ""));
		}
		
		public function Close():void
		{
			removeChildren();
			_resetButton.removeEventListener(Event.TRIGGERED, onResetClicked);
			_menuButton.removeEventListener(Event.TRIGGERED, onMenuClicked);
		}
	}

}