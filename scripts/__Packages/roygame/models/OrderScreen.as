class roygame.models.OrderScreen
{
   var signclip = null;
   var active = false;
   var forceCustomerTime = 9000;
   function OrderScreen(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.gameclip = _loc2_.gameObj.clip;
      _loc2_.setupScreen();
   }
   function setupScreen()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.clip = _loc2_.gameclip.attachMovie("order_screen","order_screen",5);
      _loc2_.clip._x = -5000;
      _loc2_.signclip = _loc2_.clip.attachMovie("opensign_overlay","signlayer",10000);
   }
   function setCurrentMode()
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_.gameObj;
      _loc3_.clip._x = 0;
      _loc3_.active = true;
      _loc2_.toppingScreen.setNotCurrentMode();
      _loc2_.cuttingScreen.setNotCurrentMode();
      _loc2_.bakingScreen.setNotCurrentMode();
      _loc2_.takeOrderScreen.setNotCurrentMode();
      _loc2_.giveOrderScreen.setNotCurrentMode();
      _loc2_.pauseScreen.setNotCurrentMode();
      _loc2_.hudObj.setMode("order");
      _loc2_.soundEngine.switchMusic(1);
      _loc3_.clip.roy.gotoAndPlay(1);
      var _loc4_ = _loc2_.customerManager.orderline[0];
      if(_loc4_.orderIsPlaced && _loc4_.currentLine == "orderline")
      {
         _loc4_.moveCustomerOrderDone();
      }
      clearInterval(_loc3_.forceCustomerInterval);
      var _loc5_ = _loc2_.customerManager.orderline;
      if(_loc5_.length == 0 && !_loc2_.training)
      {
         _loc3_.forceCustomerInterval = setInterval(this,"forceNewCustomer",_loc3_.forceCustomerTime);
      }
   }
   function forceNewCustomer()
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_.gameObj;
      trace("Force a customer out!");
      var _loc4_ = getTimer();
      var _loc7_ = _loc2_.customerManager.lastSpawnTime + _loc2_.customerManager.spawnSpeed;
      var _loc8_ = _loc2_.customerManager.lastSpawnTime;
      var _loc5_ = Math.abs(_loc7_ - _loc4_);
      var _loc6_ = Math.abs(_loc4_ - _loc8_);
      if(_loc5_ > 9000 && _loc6_ > 9000)
      {
         _loc2_.customerManager.spawnCustomer();
      }
      clearInterval(_loc3_.forceCustomerInterval);
   }
   function setNotCurrentMode()
   {
      var _loc2_ = this;
      _loc2_.clip._x = -5000;
      _loc2_.active = false;
      clearInterval(_loc2_.forceCustomerInterval);
   }
   function takeOrder()
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_.gameObj;
      _loc3_.firstCustomer = _loc2_.customerManager.orderline[0];
      var _loc4_ = _loc2_.hudObj.activeTicket;
      if(_loc4_ == 0)
      {
         _loc2_.takeOrderScreen.orderInProcess = false;
         _loc2_.switchModes("takeOrder");
         _loc2_.currentOrder = _loc2_.currentOrder + 1;
      }
      else
      {
         var _loc5_ = _loc2_.ticketManager["ticket" + _loc4_];
         _loc5_.snapToLine("automove");
         _loc2_.takeOrderScreen.orderInProcess = false;
         _loc2_.switchModes("takeOrder");
         _loc2_.currentOrder = _loc2_.currentOrder + 1;
      }
   }
   function pauseUpdate(msg)
   {
   }
}
