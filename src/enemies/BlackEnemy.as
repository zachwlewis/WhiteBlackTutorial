package enemies
{
	import net.flashpunk.graphics.Image;
	import bullets.*;
	public class BlackEnemy extends Enemy
	{
		public function BlackEnemy()
		{
			super();
			g.color = 0;
		}
		
		override protected function hit(b:Bullet):void
		{
			if(b.type == GC.TYPE_WHITE_BULLET)
			{
				this.getScore();
			}
			super.hit(b);
		}
	}
}