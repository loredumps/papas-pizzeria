class roygame.models.CuttingScreen
{
   var active = false;
   var pizzas = [];
   function CuttingScreen(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.gameclip = _loc2_.gameObj.clip;
      _loc2_.pizzas = [];
      _loc2_.setupScreen();
   }
   function setupScreen()
   {
      var _loc2_ = this;
      _loc2_.clip = _loc2_.gameclip.attachMovie("cutting_screen","cutting_screen",8);
      _loc2_.clip._x = -5000;
   }
   function setCurrentMode()
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_.gameObj;
      _loc3_.clip._x = 0;
      _loc3_.active = true;
      _loc2_.toppingScreen.setNotCurrentMode();
      _loc2_.orderScreen.setNotCurrentMode();
      _loc2_.bakingScreen.setNotCurrentMode();
      _loc2_.takeOrderScreen.setNotCurrentMode();
      _loc2_.giveOrderScreen.setNotCurrentMode();
      _loc2_.pauseScreen.setNotCurrentMode();
      _loc2_.soundEngine.switchMusic(4);
      _loc2_.hudObj.setMode("cutting");
      _loc3_.redrawCuttingPizzas();
   }
   function setNotCurrentMode()
   {
      var _loc2_ = this;
      _loc2_.clip._x = -5000;
      _loc2_.active = false;
   }
   function pizzaWasThrown()
   {
      var _loc2_ = this;
      _loc2_.pizzas.shift();
      _loc2_.redrawCuttingPizzas();
   }
   function redrawCuttingPizzas()
   {
      var _loc2_ = this;
      if(_loc2_.pizzas.length > 0)
      {
         var _loc3_ = _loc2_.pizzas[0];
         _loc3_.drawPizza("cutting");
      }
   }
   function givePizza()
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_.gameObj;
      _loc2_.giveOrderScreen.orderInProcess = false;
      _loc2_.switchModes("giveOrder");
   }
   function throwAwayPizza()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      var _loc4_ = _loc2_.pizzas[0];
      _loc4_.throwAway();
      _loc3_.hudObj.switchTicketMode("blank");
   }
   function pauseUpdate(msg)
   {
   }
}
