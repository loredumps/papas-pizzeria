class roygame.models.StartDayScreen
{
   function StartDayScreen(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.gameclip = _loc2_.gameObj.clip;
      _loc2_.setupScreen();
   }
   function setupScreen()
   {
      var _loc2_ = this;
      _loc2_.clip = _loc2_.gameclip.attachMovie("startofday","startofday",10);
      _loc2_.gameObj.soundEngine.switchMusic(0);
      _loc2_.startAnimation();
   }
   function startAnimation()
   {
      var _loc2_ = this;
      trace("Triggered Animation!");
      var _loc3_ = _loc2_.gameObj.currentDay;
      _loc2_.clip.dayMC.clip.day_text.text = _loc3_;
      _loc2_.clip.dayMC.clip.day_shadow.text = _loc3_;
      _loc2_.gameObj.soundEngine.switchMusic(0);
      _loc2_.gameObj.soundEngine.playSound("startofday.wav");
      _loc2_.clip.play();
   }
   function endAnimation()
   {
      var _loc2_ = this;
      _loc2_.gameObj.switchModes("buildlevel","allow");
   }
   function pauseUpdate(msg)
   {
   }
}
