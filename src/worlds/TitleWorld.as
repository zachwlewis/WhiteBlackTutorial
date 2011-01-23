package worlds
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	
	public class TitleWorld extends World
	{
		protected var topTitle:Entity;
		protected var bottomTitle:Entity;
		protected var hasPlayedTitle:Boolean;
		protected var infoText:Text;
		public function TitleWorld()
		{
			hasPlayedTitle = false;
			super();
		}
		
		override public function begin():void
		{
			
			
			topTitle = addGraphic(new Image(GC.GFX_TITLE_TOP));
			topTitle.y = -FP.screen.height;
			
			bottomTitle = addGraphic(new Image(GC.GFX_TITLE_BOTTOM));
			bottomTitle.y = FP.screen.height * 1.5;
			
			var topTween:VarTween = new VarTween(onBounceIn);
			topTween.tween(topTitle,"y",0, 1.5, Ease.bounceOut);
			addTween(topTween,true);
			
			var bottomTween:VarTween = new VarTween();
			bottomTween.tween(bottomTitle,"y",FP.screen.height/2, 1.5, Ease.bounceOut);
			addTween(bottomTween,true);
			
		}
		
		protected function onBounceIn():void
		{
			Text.size = 16;
			infoText = new Text("click to play");
			infoText.x = FP.screen.width/2 - infoText.width/2;
			infoText.y = FP.screen.height - 40;
			infoText.color = 0;
			infoText.alpha = 0;
			addGraphic(infoText, -1);
			var textTween:VarTween = new VarTween(onTextFade);
			textTween.tween(infoText, "alpha",1,0.5,Ease.quadIn);
			addTween(textTween, true);
		}
		
		protected function onTextFade():void
		{
			hasPlayedTitle = true;
		}
		
		override public function update():void
		{
			if(Input.mousePressed && hasPlayedTitle)
			{
				// Handle contitions for going to next world.
				FP.world = new GameWorld();
			}
		}
	}
}