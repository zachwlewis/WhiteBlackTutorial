package
{	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.TitleWorld;
	
	public class WhiteBlackTutorial extends Engine
	{
		public function WhiteBlackTutorial()
		{
			super(160,300);
			FP.screen.scale = 2;
			FP.screen.color = 0x888888;
		}
		
		override public function init():void
		{
			FP.world = new TitleWorld();
		}
	}
}