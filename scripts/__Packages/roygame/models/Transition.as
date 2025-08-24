class roygame.models.Transition
{
   var cycleSpeed = 33;
   var fadeAmount = 35;
   var fadedIn = false;
   var adServed = false;
   function Transition(gameobj, which)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.gameclip = _loc2_.gameObj.clip;
      _loc2_.whichMode = which;
      _loc2_.setupTransition();
   }
   function setupTransition()
   {
      var _loc2_ = this;
      var _loc3_ = 4000;
      var _loc4_ = _loc2_.gameObj.showCustomerFile;
      var _loc5_ = _loc2_.gameObj.showHelpScreen;
      _loc2_.adServed = false;
      if(_loc2_.whichMode == "endofday")
      {
         _loc3_ = 100001;
         _loc2_.fadeAmount = 10;
      }
      else if(_loc2_.whichMode == "startofday")
      {
         _loc3_ = 100001;
         _loc2_.fadeAmount = 25;
      }
      else if(_loc2_.whichMode == "newcustomer")
      {
         _loc3_ = 100001;
         _loc2_.fadeAmount = 25;
      }
      else if(_loc2_.whichMode == "highscores")
      {
         _loc3_ = 100001;
         _loc2_.fadeAmount = 25;
      }
      else if(_loc2_.whichMode == "customerfile")
      {
         _loc3_ = 100001;
         _loc2_.fadeAmount = 25;
      }
      else if(_loc2_.whichMode == "helpscreen")
      {
         _loc3_ = 100001;
         _loc2_.fadeAmount = 25;
      }
      else if(_loc5_)
      {
         _loc3_ = 100001;
         _loc2_.fadeAmount = 25;
      }
      else if(_loc4_)
      {
         _loc3_ = 100001;
         _loc2_.fadeAmount = 25;
      }
      else if(_loc2_.whichMode == "buildlevel")
      {
         _loc3_ = 100001;
         _loc2_.fadeAmount = 25;
      }
      _loc2_.clip = _loc2_.gameclip.attachMovie("fader","fader",_loc3_);
      _loc2_.clip._alpha = 0;
      _loc2_.fadedIn = false;
      _loc2_.cycleInterval = setInterval(this,"transitionCycle",_loc2_.cycleSpeed);
   }
   function continueTransition()
   {
      var _loc2_ = this;
      trace("continuing transition");
      _loc2_.adServed = true;
      _loc2_.cycleInterval = setInterval(this,"transitionCycle",_loc2_.cycleSpeed);
   }
   function transitionCycle()
   {
      var _loc2_ = this;
      if(_loc2_.clip._alpha < 100 && _loc2_.fadedIn == false)
      {
         _loc2_.clip._alpha += _loc2_.fadeAmount;
      }
      else if(_loc2_.clip._alpha >= 100 && _loc2_.fadedIn == false)
      {
         _loc2_.fadedIn = true;
         _loc2_.triggerAction();
      }
      else if(_loc2_.clip._alpha > 0 && _loc2_.fadedIn == true)
      {
         _loc2_.clip._alpha -= _loc2_.fadeAmount;
      }
      else if(_loc2_.clip._alpha <= 0 && _loc2_.fadedIn == true)
      {
         _loc2_.endTransition();
      }
   }
   function triggerAction()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      if(_loc2_.whichMode == "startofday" && !_loc2_.adServed)
      {
         _loc2_.serveAd();
      }
      else
      {
         _loc3_.finishSwitchModes(_loc2_.whichMode);
      }
   }
   function serveAd()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.fadedIn = false;
      clearInterval(_loc2_.cycleInterval);
      trace("Serve ad");
      CoolmathSDK2.commercialBreak();
      _loc2_.continueTransition();
   }
   function endTransition()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.clip.removeMovieClip();
      clearInterval(_loc2_.cycleInterval);
      _loc2_.gameObj.killTransition(_loc2_.whichMode);
   }
   function pauseUpdate(msg)
   {
   }
}
