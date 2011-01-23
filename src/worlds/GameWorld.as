package worlds
{
	import enemies.*;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	
	import players.Player;
	
	public class GameWorld extends World
	{
		protected var topTitle:Entity;
		protected var bottomTitle:Entity;
		protected var player:Player;
		protected var scoreText:Text;
		public function GameWorld()
		{
			super();
			
		}
		
		override public function begin():void
		{
			// Scrolling title stuff.
			topTitle = addGraphic(new Image(GC.GFX_TITLE_TOP),-1);
			topTitle.y = 0;
			
			bottomTitle = addGraphic(new Image(GC.GFX_TITLE_BOTTOM),-1);
			bottomTitle.y = FP.screen.height/2;
			
			var topTween:VarTween = new VarTween();
			topTween.tween(topTitle,"y",-FP.screen.height/2, 1, Ease.cubeIn);
			addTween(topTween,true);
			
			var bottomTween:VarTween = new VarTween();
			bottomTween.tween(bottomTitle,"y",FP.screen.height, 1, Ease.cubeIn);
			addTween(bottomTween,true);
			
			// Now the actual game.
			player = new Player(FP.screen.width/2 - 6, 250);
			Text.size = 8;
			scoreText = new Text("0",0,0,FP.screen.width);
			addGraphic(scoreText);
			this.add(player);
		}
		
		override public function update():void
		{
			if(this.classCount(Player) != 0)
			{
				if(this.typeCount(GC.TYPE_ENEMY) == 0 || FP.random > GC.ENEMY_SPAWN_CHANCE)
				{
					if(FP.rand(2) == 0) add(new WhiteEnemy());
					else add(new BlackEnemy());
				}
			}
			
			scoreText.text = GV.Score.toString();
			if(this.classCount(Player) == 0 && this.typeCount(GC.TYPE_ENEMY) == 0)
			{
				player = new Player(FP.screen.width/2 - 6, 250);
				add(player);
				GV.Score = 0;
			}
			
			super.update();
		}
	}
}