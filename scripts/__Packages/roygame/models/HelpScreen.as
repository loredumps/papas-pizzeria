class roygame.models.HelpScreen
{
   var currentscreen = 1;
   var maxscreens = 13;
   function HelpScreen(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.gameclip = _loc2_.gameObj.clip;
      _loc2_.setupScreen();
   }
   function switchScreens(which)
   {
      var _loc2_ = this;
      if(which >= 1)
      {
         if(which > _loc2_.maxscreens)
         {
            which = 1;
         }
         _loc2_.currentscreen = which;
         _loc2_.clip.board.gotoAndStop(which);
         _loc2_.clip.board.fader.gotoAndPlay(1);
      }
   }
   function setupScreen()
   {
      var screen = this;
      var gameObj = screen.gameObj;
      screen.clip = screen.gameclip.attachMovie("helpscreen","helpscreen",50005);
      screen.gameObj.soundEngine.switchMusic(0);
      screen.clip.board.basics_btn.onPress = function()
      {
         screen.switchScreens(2);
      };
      screen.clip.board.orders_btn.onPress = function()
      {
         screen.switchScreens(3);
      };
      screen.clip.board.readingtickets_btn.onPress = function()
      {
         screen.switchScreens(4);
      };
      screen.clip.board.movingtickets_btn.onPress = function()
      {
         screen.switchScreens(5);
      };
      screen.clip.board.topping_btn.onPress = function()
      {
         screen.switchScreens(6);
      };
      screen.clip.board.baking_btn.onPress = function()
      {
         screen.switchScreens(7);
      };
      screen.clip.board.cutting_btn.onPress = function()
      {
         screen.switchScreens(8);
      };
      screen.clip.board.finishing_btn.onPress = function()
      {
         screen.switchScreens(9);
      };
      screen.clip.board.ranking_btn.onPress = function()
      {
         screen.switchScreens(10);
      };
      screen.clip.board.customers_btn.onPress = function()
      {
         screen.switchScreens(11);
      };
      screen.clip.board.rewards_btn.onPress = function()
      {
         screen.switchScreens(12);
      };
      screen.clip.board.saving_btn.onPress = function()
      {
         screen.switchScreens(13);
      };
      screen.clip.board.menustrip.next_btn.onPress = function()
      {
         screen.switchScreens(screen.currentscreen + 1);
      };
      screen.clip.board.menustrip.prev_btn.onPress = function()
      {
         screen.switchScreens(screen.currentscreen - 1);
      };
      screen.clip.board.menustrip.menu_btn.onPress = function()
      {
         screen.switchScreens(1);
      };
      screen.clip.board.close_btn.onPress = function()
      {
         gameObj.pauseManager.pauseGame();
      };
      screen.clip.buttonguard.onPress = function()
      {
      };
      screen.clip.buttonguard.useHandCursor = false;
   }
   function pauseUpdate(msg)
   {
   }
}
