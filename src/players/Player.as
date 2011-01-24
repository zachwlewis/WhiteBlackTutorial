package players
{	
	import bullets.*;
	
	import flash.display.BitmapData;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.*;
		
		public class Player extends Entity
		{
			protected var currentBullet:Class;
			protected var g:Image;
			protected var flipInTween:VarTween;
			protected var flipOutTween:VarTween;
			protected var explosionEmitter:Emitter;
			protected const FLIP_SPEED:Number = 0.5;
			protected const EXPLOSION_SIZE:uint = 100;
			protected var fireRate:Number;
			protected var fireTimer:Number;
			
			public function Player(x:Number=0, y:Number=0)
			{
				super(x, y);
				g = new Image(GC.GFX_PLAYER);
				g.originX = 6;
				flipInTween = new VarTween(onFlipInComplete, Tween.PERSIST);
				flipOutTween = new VarTween(onFlipOutComplete, Tween.PERSIST);
				explosionEmitter = new Emitter(new BitmapData(1,1),1,1);
				// Define our particles
				explosionEmitter.newType("explode",[0]);
				explosionEmitter.setAlpha("explode",1,0);
				explosionEmitter.setMotion("explode", 0, 50, 2, 360, -40, -0.5, Ease.quadOut);
				
				explosionEmitter.relative = false;
				graphic = new Graphiclist(g, explosionEmitter);
				
				addTween(flipInTween);
				addTween(flipOutTween);
				this.setHitbox(12, 8);
				currentBullet = WhiteBullet;
				
				// Define our auto-shoot propertites.
				fireRate = 0.2;
				fireTimer = 0;
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
					explosionEmitter.setColor("explode", 0, 0);
					currentBullet = BlackBullet;
				}
				else
				{
					// The player is currently black.
					g.color = 0xffffff;
					explosionEmitter.setColor("explode", 0xffffff, 0xffffff);
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
					fireTimer = 0;
					this.world.add(new currentBullet(x + 5, y - 2));
				}
				else if(Input.mouseDown && !flipInTween.active && !flipOutTween.active)
				{
					fireTimer += FP.elapsed;
					if(fireTimer > fireRate)
					{
						fireTimer -= fireRate;
						this.world.add(new currentBullet(x + 5, y - 2));
					}
				}
				
				
				if(Input.pressed(Key.Z) && !flipInTween.active && !flipOutTween.active)
				{
					flipInTween.tween(g,"scaleX",0,FLIP_SPEED/2, Ease.quadOut);
					flipInTween.start();
				}
				
				if(this.collide(GC.TYPE_ENEMY, x, y))
				{
					// Dead.
					collidable = false;
					g.visible = false;
					
					for (var i:uint = 0; i < EXPLOSION_SIZE; i++)
					{
						explosionEmitter.emit("explode",x + width/2, y+ height/2);
					}
				}
				
				if(!collidable && explosionEmitter.particleCount == 0)
				{
					if(this.world != null) this.world.remove(this);
				}
				
				super.update();
			}
		}
}