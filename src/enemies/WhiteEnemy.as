package enemies
{
	import bullets.*;

	public class WhiteEnemy extends Enemy
	{
		public function WhiteEnemy()
		{
			super();
		}
		
		override protected function hit(b:Bullet):void
		{
			if(b.type == GC.TYPE_BLACK_BULLET)
			{
				this.world.remove(this);
				this.getScore();
			}
			super.hit(b);
		}
	}
}