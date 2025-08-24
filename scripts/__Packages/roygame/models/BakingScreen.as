class roygame.models.BakingScreen
{
   var active = false;
   var cookTimeForPizza = 3;
   var timerstart1 = 0;
   var timerstart2 = 0;
   var timerstart3 = 0;
   var timerstart4 = 0;
   var timerpausecache1 = 0;
   var timerpausecache2 = 0;
   var timerpausecache3 = 0;
   var timerpausecache4 = 0;
   var timerpausestart1 = 0;
   var timerpausestart2 = 0;
   var timerpausestart3 = 0;
   var timerpausestart4 = 0;
   var cooktime1 = 0;
   var cooktime2 = 0;
   var cooktime3 = 0;
   var cooktime4 = 0;
   var pizzastage1 = 0;
   var pizzastage2 = 0;
   var pizzastage3 = 0;
   var pizzastage4 = 0;
   var pizzas = [0,0,0,0];
   function BakingScreen(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.gameclip = _loc2_.gameObj.clip;
      _loc2_.pizzas = [0,0,0,0];
      _loc2_.setupScreen();
   }
   function setupScreen()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.clip = _loc2_.gameclip.attachMovie("baking_screen","baking_screen",7);
      _loc2_.clip._x = -5000;
      _loc2_.TimePerDegree = _loc2_.cookTimeForPizza * 60 / 360 * 1000;
      _loc2_.setupTimers();
      _loc3_.pauseManager.addPauseListener(_loc2_);
   }
   function setupTimers()
   {
      var _loc2_ = this;
      _loc2_.timer1 = _loc2_.clip.timer1;
      _loc2_.timer2 = _loc2_.clip.timer2;
      _loc2_.timer3 = _loc2_.clip.timer3;
      _loc2_.timer4 = _loc2_.clip.timer4;
   }
   function restartTimer(which)
   {
      var screen = this;
      var _loc2_ = screen["timer" + which];
      _loc2_.needle._rotation = 0;
      screen["timerstart" + which] = getTimer();
      screen["cooktime" + which] = 0;
      screen["pizzastage" + which] = 0;
      screen["timerpausestart" + which] = 0;
      screen["timerpausecache" + which] = 0;
      delete _loc2_.onEnterFrame;
      _loc2_.onEnterFrame = function()
      {
         screen.runTimer(which);
      };
   }
   function stopTimer(which)
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_["timer" + which];
      _loc4_.needle._rotation = 0;
      _loc2_["timerstart" + which] = getTimer();
      _loc2_["cooktime" + which] = 0;
      _loc2_["pizzastage" + which] = 0;
      _loc2_["timerpausestart" + which] = 0;
      _loc2_["timerpausecache" + which] = 0;
      delete _loc4_.onEnterFrame;
   }
   function pauseTimer(which)
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_["timer" + which];
      _loc2_["timerpausestart" + which] = getTimer();
      delete _loc3_.onEnterFrame;
   }
   function unpauseTimer(which)
   {
      var screen = this;
      var _loc4_ = screen["timer" + which];
      var _loc2_ = getTimer();
      var _loc3_ = _loc2_ - screen["timerpausestart" + which];
      screen["timerpausecache" + which] += _loc3_;
      if(screen.pizzas[which - 1] != 0)
      {
         _loc4_.onEnterFrame = function()
         {
            screen.runTimer(which);
         };
      }
   }
   function runTimer(which)
   {
      var _loc2_ = this;
      var _loc6_ = _loc2_.gameObj;
      var _loc11_ = _loc2_["timer" + which];
      var _loc12_ = _loc2_["timerstart" + which];
      var _loc14_ = getTimer();
      var _loc8_ = _loc2_["timerpausecache" + which];
      var _loc10_ = _loc14_ - _loc8_ - _loc12_;
      var _loc4_ = Math.floor(_loc10_ / _loc2_.TimePerDegree);
      _loc2_["cooktime" + which] = _loc4_;
      _loc11_.needle._rotation = _loc4_;
      var _loc9_ = _loc4_ / 45;
      var _loc5_ = Math.floor(_loc9_);
      if(_loc2_["pizzastage" + which] < _loc5_)
      {
         var _loc7_ = which - 1;
         var _loc13_ = _loc2_.pizzas[_loc7_];
         _loc13_.changeCookLook(_loc5_);
      }
      _loc2_["pizzastage" + which] = _loc5_;
      if(_loc4_ >= 360)
      {
         _loc2_.stopTimer(which);
      }
      if(_loc6_.training)
      {
         if(_loc6_.trainingManager.currentStep == 18 && _loc4_ >= 45)
         {
            _loc6_.trainingManager.finishedStep(18);
         }
      }
   }
   function setCurrentMode()
   {
      var _loc4_ = this;
      var _loc5_ = _loc4_.gameObj;
      _loc4_.clip._x = 0;
      _loc4_.active = true;
      _loc5_.toppingScreen.setNotCurrentMode();
      _loc5_.orderScreen.setNotCurrentMode();
      _loc5_.cuttingScreen.setNotCurrentMode();
      _loc5_.takeOrderScreen.setNotCurrentMode();
      _loc5_.giveOrderScreen.setNotCurrentMode();
      _loc5_.pauseScreen.setNotCurrentMode();
      _loc5_.soundEngine.switchMusic(3);
      _loc5_.hudObj.setMode("baking");
      var _loc2_ = 0;
      while(_loc2_ < 4)
      {
         if(_loc4_.pizzas[_loc2_] != 0)
         {
            var _loc3_ = _loc4_.pizzas[_loc2_];
            _loc3_.drawPizza("baking");
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function setNotCurrentMode()
   {
      var _loc4_ = this;
      _loc4_.clip._x = -5000;
      _loc4_.active = false;
      var _loc2_ = 0;
      while(_loc2_ < 4)
      {
         if(_loc4_.pizzas[_loc2_] != 0)
         {
            var _loc3_ = _loc4_.pizzas[_loc2_];
            _loc3_.undrawPizza();
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function checkPizzaSlots()
   {
      var _loc4_ = this;
      var _loc3_ = 0;
      var _loc2_ = 0;
      while(_loc2_ < 4)
      {
         if(_loc4_.pizzas[_loc2_] == 0)
         {
            _loc3_ = _loc2_ + 1;
            break;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   function pauseUpdate(msg)
   {
      var _loc2_ = this;
      if(msg == "pause")
      {
         _loc2_.pauseTimer(1);
         _loc2_.pauseTimer(2);
         _loc2_.pauseTimer(3);
         _loc2_.pauseTimer(4);
      }
      else if(msg == "unpause")
      {
         _loc2_.unpauseTimer(1);
         _loc2_.unpauseTimer(2);
         _loc2_.unpauseTimer(3);
         _loc2_.unpauseTimer(4);
      }
   }
}
