package view 
{
	import model.Node;
	import starling.display.Button;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author John Everson
	 */
	public class NodeButton extends Button 
	{
		[Embed(source="../../bin/textures/button_up.png")]
		public static const ButtonUp:Class;
		[Embed(source="../../bin/textures/empty.png")]
		public static const Empty:Class;
		[Embed(source="../../bin/textures/mine.png")]
		public static const Mine:Class;
		[Embed(source="../../bin/textures/button_flagged.png")]
		public static const ButtonFlagged:Class
		
		private var _posX:int;
		private var _posY:int;
		private var _node:Node
		
		public function NodeButton(posX:int, posY:int, node:Node) 
		{
			_posX = posX;
			_posY = posY;
			_node = node;
			super(Texture.fromEmbeddedAsset(ButtonUp));
			alphaWhenDisabled = 1;
		}
		
		public function Refresh():void
		{
			if (!_node.revealed)
			{
				if (!_node.isFlagged)
				{
					upState = Texture.fromEmbeddedAsset(ButtonUp);
				}
				else
				{
					upState = Texture.fromEmbeddedAsset(ButtonFlagged);
				}
				return
			}
			enabled = false;
			if (_node.isMine)
			{
				upState = Texture.fromEmbeddedAsset(Mine);
				return;
			}
			if (_node.adjacentBombs > 0)
			{
				text = _node.adjacentBombs.toString();
			}
			upState = Texture.fromEmbeddedAsset(Empty);
		}
		
		public function get PosX():int	{	return _posX;	}
		public function get PosY():int 	{	return _posY;	}
	}
	
	
}