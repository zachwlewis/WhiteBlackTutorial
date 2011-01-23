package
{
	public class GC
	{
		[Embed(source = '../assets/player.png')]
		public static const GFX_PLAYER:Class;
		
		[Embed(source = '../assets/enemy.png')]
		public static const GFX_ENEMY:Class;
		
		[Embed(source = '../assets/background_01.png')]
		public static const GFX_TITLE_TOP:Class;
		
		[Embed(source = '../assets/background_02.png')]
		public static const GFX_TITLE_BOTTOM:Class;
		
		public static const BULLET_SPEED:Number = 100;
		public static const ENEMY_SPEED:Number = 40;
		public static const ENEMY_SPAWN_CHANCE:Number = 1 - 1/60;
		public static const ENEMY_VALUE:Number = 100;
		
		// Types
		public static const TYPE_WHITE_BULLET:String = "white_bullet";
		public static const TYPE_BLACK_BULLET:String = "black_bullet";
		public static const TYPE_ENEMY:String = "enemy";
	}
}