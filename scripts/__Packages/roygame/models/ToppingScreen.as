class roygame.models.ToppingScreen
{
   var active = false;
   function ToppingScreen(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.gameclip = _loc2_.gameObj.clip;
      _loc2_.setupScreen();
   }
   function setupScreen()
   {
      var screen = this;
      var game = screen.gameObj;
      screen.clip = screen.gameclip.attachMovie("topping_screen","topping_screen",6);
      screen.clip._x = -5000;
      if(game.training)
      {
         screen.clip.cup_pepperoni.onPress = function()
         {
            screen.chooseTopping(1);
         };
         screen.clip.cup_sausage.gotoAndStop(2);
         screen.clip.cup_mushroom.gotoAndStop(2);
         screen.clip.cup_pepper.gotoAndStop(2);
         screen.clip.cup_onion.gotoAndStop(2);
         screen.clip.cup_olive.gotoAndStop(2);
         screen.clip.cup_anchovy.gotoAndStop(2);
      }
      else
      {
         screen.clip.cup_pepperoni.onPress = function()
         {
            screen.chooseTopping(1);
         };
         screen.clip.cup_sausage.onPress = function()
         {
            screen.chooseTopping(2);
         };
         screen.clip.cup_mushroom.onPress = function()
         {
            screen.chooseTopping(3);
         };
         screen.clip.cup_pepper.onPress = function()
         {
            screen.chooseTopping(4);
         };
         screen.clip.cup_onion.onPress = function()
         {
            screen.chooseTopping(5);
         };
         screen.clip.cup_olive.onPress = function()
         {
            screen.chooseTopping(6);
         };
         screen.clip.cup_anchovy.onPress = function()
         {
            screen.chooseTopping(7);
         };
      }
      screen.clip.cup_pepperoni.onRollOver = function()
      {
         game.hudObj.setTooltip("Pepperoni",true);
      };
      screen.clip.cup_sausage.onRollOver = function()
      {
         game.hudObj.setTooltip("Sausage",true);
      };
      screen.clip.cup_mushroom.onRollOver = function()
      {
         game.hudObj.setTooltip("Mushrooms",true);
      };
      screen.clip.cup_pepper.onRollOver = function()
      {
         game.hudObj.setTooltip("Peppers",true);
      };
      screen.clip.cup_onion.onRollOver = function()
      {
         game.hudObj.setTooltip("Onions",true);
      };
      screen.clip.cup_olive.onRollOver = function()
      {
         game.hudObj.setTooltip("Olives",true);
      };
      screen.clip.cup_anchovy.onRollOver = function()
      {
         game.hudObj.setTooltip("Anchovies",true);
      };
      screen.clip.cup_pepperoni.onRollOut = function()
      {
         game.hudObj.setLastTooltip();
      };
      screen.clip.cup_sausage.onRollOut = function()
      {
         game.hudObj.setLastTooltip();
      };
      screen.clip.cup_mushroom.onRollOut = function()
      {
         game.hudObj.setLastTooltip();
      };
      screen.clip.cup_pepper.onRollOut = function()
      {
         game.hudObj.setLastTooltip();
      };
      screen.clip.cup_olive.onRollOut = function()
      {
         game.hudObj.setLastTooltip();
      };
      screen.clip.cup_onion.onRollOut = function()
      {
         game.hudObj.setLastTooltip();
      };
      screen.clip.cup_anchovy.onRollOut = function()
      {
         game.hudObj.setLastTooltip();
      };
      screen.clip.cup_pepperoni.onReleaseOutside = function()
      {
         screen.releaseTopping();
      };
      screen.clip.cup_sausage.onReleaseOutside = function()
      {
         screen.releaseTopping();
      };
      screen.clip.cup_mushroom.onReleaseOutside = function()
      {
         screen.releaseTopping();
      };
      screen.clip.cup_pepper.onReleaseOutside = function()
      {
         screen.releaseTopping();
      };
      screen.clip.cup_onion.onReleaseOutside = function()
      {
         screen.releaseTopping();
      };
      screen.clip.cup_olive.onReleaseOutside = function()
      {
         screen.releaseTopping();
      };
      screen.clip.cup_anchovy.onReleaseOutside = function()
      {
         screen.releaseTopping();
      };
   }
   function releaseTopping()
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_.gameObj;
      if(!_loc2_.pauseManager.isPaused)
      {
         var _loc4_ = _loc2_.hudObj.activeTicket;
         var _loc5_ = _loc2_.ticketManager["ticket" + _loc4_].whichPizza;
         var _loc6_ = _loc2_.pizzaManager["pizza" + _loc5_];
         _loc6_.releaseTopping();
      }
   }
   function chooseTopping(which)
   {
      var _loc5_ = this;
      var _loc2_ = _loc5_.gameObj;
      if(!_loc2_.pauseManager.isPaused)
      {
         var _loc3_ = _loc2_.hudObj.activeTicket;
         if(_loc3_ > 0)
         {
            var _loc4_ = _loc2_.ticketManager["ticket" + _loc3_];
            if(_loc4_.pizzaIsTopping)
            {
               var _loc6_ = _loc4_.whichPizza;
               var _loc7_ = _loc2_.pizzaManager["pizza" + _loc6_];
               _loc7_.addTopping(which,true);
            }
         }
      }
   }
   function setCurrentMode()
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_.gameObj;
      _loc3_.clip._x = 0;
      _loc3_.active = true;
      _loc2_.cuttingScreen.setNotCurrentMode();
      _loc2_.orderScreen.setNotCurrentMode();
      _loc2_.bakingScreen.setNotCurrentMode();
      _loc2_.takeOrderScreen.setNotCurrentMode();
      _loc2_.giveOrderScreen.setNotCurrentMode();
      _loc2_.pauseScreen.setNotCurrentMode();
      _loc2_.soundEngine.switchMusic(2);
      _loc2_.hudObj.setMode("topping");
   }
   function setNotCurrentMode()
   {
      var _loc2_ = this;
      _loc2_.clip._x = -5000;
      _loc2_.active = false;
   }
   function makePizza()
   {
      var _loc5_ = this;
      var _loc2_ = _loc5_.gameObj;
      var _loc6_ = _loc2_.hudObj.activeTicket;
      var _loc3_ = _loc2_.ticketManager["ticket" + _loc6_];
      if(_loc3_.whichPizza > 0)
      {
         var _loc4_ = _loc2_.pizzaManager["pizza" + _loc3_.whichPizza];
         if(_loc4_.currentLocation == "topping")
         {
            _loc4_.retopPizza();
         }
         else
         {
            _loc2_.pizzaManager.addPizza("topping");
         }
      }
      else
      {
         if(_loc2_.training)
         {
            if(_loc2_.trainingManager.currentStep == 11)
            {
               _loc2_.trainingManager.finishedStep(11);
            }
         }
         _loc2_.pizzaManager.addPizza("topping");
      }
      _loc2_.hudObj.switchTicketMode("blank");
   }
   function putInOven()
   {
      var _loc4_ = this;
      var _loc2_ = _loc4_.gameObj;
      var _loc3_ = false;
      if(_loc2_.training)
      {
         if(_loc2_.trainingManager.currentStep == 14)
         {
            _loc3_ = true;
         }
      }
      if(!_loc2_.training || _loc3_)
      {
         var _loc8_ = _loc2_.bakingScreen.checkPizzaSlots();
         if(_loc8_ != 0)
         {
            var _loc5_ = _loc2_.hudObj.activeTicket;
            var _loc6_ = _loc2_.ticketManager["ticket" + _loc5_].whichPizza;
            var _loc7_ = _loc2_.pizzaManager["pizza" + _loc6_];
            _loc7_.putInOven();
            _loc2_.hudObj.switchTicketMode("blank");
         }
      }
   }
   function saveForLater()
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_.gameObj;
      if(!_loc2_.training)
      {
         var _loc4_ = _loc2_.hudObj.activeTicket;
         var _loc5_ = _loc2_.ticketManager["ticket" + _loc4_].whichPizza;
         var _loc6_ = _loc2_.pizzaManager["pizza" + _loc5_];
         _loc6_.saveForLater();
         _loc2_.hudObj.switchTicketMode("blank");
      }
   }
   function pauseUpdate(msg)
   {
   }
}
