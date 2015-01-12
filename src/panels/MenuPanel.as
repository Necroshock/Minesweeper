package panels 
{
	import events.LevelSelectEvent;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author John Everson
	 */
	public class MenuPanel extends Sprite
	{
		[Embed(source="../../bin/textures/button_up.png")]
		public static var ButtonSprite:Class;
		
		private var _easyButton:Button;
		private var _medButton:Button;
		private var _hardButton:Button;
		
		public function MenuPanel() 
		{
			
		}
		
		public function Open():void
		{
			var textField:TextField = new TextField(300, 200, "MINESWEEPER", "Verdana", 32, 0xFF0000);
			addChild(textField);
			textField.alignPivot();
			textField.y -= 100;
			
			//wierd formating here trying to keep it readable by breaking the line, would normally want this string externalized though
			textField = new TextField(500, 400, "Click on nodes to reveal hints about where mines are located. Mark mines by CTRL+click. Mark all mines and only mines to win. "
												+ "Reveal and mine and lose the game.", "Verdana", 20, 0xFF0000);
			addChild(textField);
			textField.alignPivot();
			
			//easy
			var texture:Texture = Texture.fromEmbeddedAsset(ButtonSprite);
			_easyButton = new Button(texture, "E");
			addChild(_easyButton);
			_easyButton.alignPivot();
			_easyButton.x -= 125;
			_easyButton.y += 100;
			_easyButton.addEventListener(Event.TRIGGERED, onTriggered);
			//medium
			_medButton = new Button(texture, "M");
			addChild(_medButton);
			_medButton.alignPivot();
			_medButton.y += 100;
			_medButton.addEventListener(Event.TRIGGERED, onTriggered);
			//hard
			_hardButton = new Button(texture, "H");
			addChild(_hardButton);
			_hardButton.alignPivot();
			_hardButton.x += 125;
			_hardButton.y += 100;
			_hardButton.addEventListener(Event.TRIGGERED, onTriggered);
		}
		
		private function onTriggered(e:Event):void 
		{
			if (e.target == _easyButton)
			{
				dispatchEvent(new LevelSelectEvent(LevelSelectEvent.LEVEL, LevelSelectEvent.EASY));
			}
			else if (e.target == _medButton)
			{
				dispatchEvent(new LevelSelectEvent(LevelSelectEvent.LEVEL, LevelSelectEvent.MEDIUM));
			}
			else
			{
				dispatchEvent(new LevelSelectEvent(LevelSelectEvent.LEVEL, LevelSelectEvent.HARD));
			}
		}
		
		public function Close():void
		{
			removeChildren();
			_easyButton.removeEventListener(Event.TRIGGERED, onTriggered);
			_medButton.removeEventListener(Event.TRIGGERED, onTriggered);
			_hardButton.removeEventListener(Event.TRIGGERED, onTriggered);
		}
		
		
	}

}