package bullets
{
	public class WhiteBullet extends Bullet
	{
		public function WhiteBullet(x:int, y:int)
		{
			super(x, y);
			this.type = GC.TYPE_WHITE_BULLET;
		}
	}
}