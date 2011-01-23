package players
{	
	import bullets.*;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.*;
		
		public class Player extends Entity
		{
			protected var currentBullet:Class;
			protected var g:Image;
			protected var flipInTween:VarTween;
			protected var flipOutTween:VarTween;
			protected const FLIP_SPEED:Number = 0.5;
			public function Player(x:Number=0, y:Number=0)
			{
				super(x, y);
				g = new Image(GC.GFX_PLAYER);
				g.originX = 6;
				graphic = g;
				flipInTween = new VarTween(onFlipInComplete, Tween.PERSIST);
				flipOutTween = new VarTween(onFlipOutComplete, Tween.PERSIST);
				
				addTween(flipInTween);
				addTween(flipOutTween);
				this.setHitbox(12, 8);
				currentBullet = WhiteBullet;
			}
			
			protected function onFlipInComplete():void
			{
				switchColor();
				flipOutTween.tween(g,"scaleX",1,FLIP_SPEED/2,Ease.quadIn);
				flipOutTween.start();
			}
			
			protected function onFlipOutComplete():void
			{
				
			}
			
			protected function switchColor():void
			{
				// Handle color shift.
				if(currentBullet == WhiteBullet)
				{
					// The player is currently white.
					g.color = 0;
					currentBullet = BlackBullet;
				}
				else
				{
					// The player is currently black.
					g.color = 0xffffff;
					currentBullet = WhiteBullet;
				}	
			}
			
			override public function update():void
			{
				x = Input.mouseX - width/2;
				if(x < 0) x = 0;
				if(x > FP.screen.width - width) x = FP.screen.width - width;
				
				if(Input.mousePressed && !flipInTween.active && !flipOutTween.active )
				{
					// Spawn our bullet.
					this.world.add(new currentBullet(x + 5, y - 2));
				}
				
				if(Input.pressed(Key.Z) && !flipInTween.active && !flipOutTween.active)
				{
					flipInTween.tween(g,"scaleX",0,FLIP_SPEED/2, Ease.quadOut);
					flipInTween.start();
				}
				
				if(this.collide(GC.TYPE_ENEMY, x, y))
				{
					// Dead.
					this.world.remove(this);
				}
				
				super.update();
			}
		}
}