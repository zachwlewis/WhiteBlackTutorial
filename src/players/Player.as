package players
{	
	import bullets.*;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity
	{
		protected var currentBullet:Class;
		public function Player(x:Number=0, y:Number=0)
		{
			super(x, y);
			graphic = new Image(GC.GFX_PLAYER);
			this.setHitbox(12, 8);
			currentBullet = WhiteBullet;
		}
		
		override public function update():void
		{
			x = Input.mouseX - width/2;
			if(x < 0) x = 0;
			if(x > FP.screen.width - width) x = FP.screen.width - width;
			
			if(Input.mousePressed)
			{
				// Spawn our bullet.
				this.world.add(new currentBullet(x + 5, y - 2));
			}
			
			if(Input.pressed(Key.Z))
			{
				// Handle color shift.
				if(currentBullet == WhiteBullet)
				{
					// The player is currently white.
					Image(this.graphic).color = 0;
					currentBullet = BlackBullet;
				}
				else
				{
					// The player is currently black.
					Image(this.graphic).color = 0xffffff;
					currentBullet = WhiteBullet;
				}
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