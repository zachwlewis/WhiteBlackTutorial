package enemies
{
	import bullets.*;
	
	import flash.display.BitmapData;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Ease;

	
	public class Enemy extends Entity
	{
		protected const EXPLOSION_SIZE:uint = 50;
		protected var g:Image;
		protected var explosionEmitter:Emitter;
		public function Enemy()
		{	
			super(FP.rand(FP.screen.width-10), -10);
			// Define our enemy graphic.
			g = new Image(GC.GFX_ENEMY);
			
			// Set up our emitter.
			explosionEmitter = new Emitter(new BitmapData(1,1),1,1);
			// Define our particles
			explosionEmitter.newType("explode",[0]);
			explosionEmitter.setAlpha("explode",1,0);
			explosionEmitter.setMotion("explode", 0, 30, 2, 360, -20, -0.5, Ease.quadOut);
			explosionEmitter.relative = false;
			
			graphic = new Graphiclist(g, explosionEmitter);
			
			this.setHitbox(10,10);
			this.type = GC.TYPE_ENEMY;
		}
		
		override public function update():void
		{
			this.y += FP.elapsed*GC.ENEMY_SPEED;
			if(this.y > FP.screen.height && this.world != null) this.world.remove(this);
			
			var b:Bullet = Bullet(this.collideTypes([GC.TYPE_WHITE_BULLET, GC.TYPE_BLACK_BULLET],x,y));
			if(b != null)
			{
				hit(b);
			}
			
			if(!collidable && explosionEmitter.particleCount == 0 && world != null)
			{
				this.world.remove(this);
			}
			
			super.update();
		}
		
		protected function hit(b:Bullet):void
		{
			// Stub for children.
			b.world.remove(b);
		}
		
		protected function getScore():void
		{
			GV.Score += GC.ENEMY_VALUE;
			
			// Let's set our emitter color. Derp.
			explosionEmitter.setColor("explode", g.color, g.color);
			
			// Blow up!
			for(var i:uint = 0; i < EXPLOSION_SIZE; i++)
			{
				explosionEmitter.emit("explode", x + width/2, y + height/2);
			}
			
			this.collidable = false;
			g.visible = false;
		}
	}
}