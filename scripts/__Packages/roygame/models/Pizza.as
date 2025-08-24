class roygame.models.Pizza
{
   var id = 0;
   var currentCookLook = 0;
   var cookTime = 0;
   var totalToppings = 0;
   var toppings = [];
   var whichOvenSlot = 0;
   var cuttingClip = null;
   var toppingTargetX = 83;
   var toppingTargetY = 103;
   var ovenTargetX = 450;
   var ovenTargetY = 103;
   var saveTargetX = -274;
   var saveTargetY = 103;
   var width = 274;
   var bakingTargetWidth = 158;
   var bakingTargetX1 = 60;
   var bakingTargetY1 = 118;
   var bakingTargetX2 = 226;
   var bakingTargetY2 = 118;
   var bakingTargetX3 = 60;
   var bakingTargetY3 = 282;
   var bakingTargetX4 = 226;
   var bakingTargetY4 = 282;
   var cuttingTargetX = 84;
   var cuttingTargetY = 133;
   var targetX = 0;
   var targetY = 0;
   var speedSteps = 3;
   var isMoving = false;
   var targetPosition = "topping";
   function Pizza(gameobj, where, newid)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.id = newid;
      _loc2_.toppings = [];
      _loc2_.attachNewPizza(where);
      _loc2_.gameObj.pauseManager.addPauseListener(this);
   }
   function addTopping(which, dragging)
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      var _loc5_ = _loc2_.totalToppings + 1;
      var _loc4_ = "topping" + _loc5_;
      _loc2_[_loc4_] = new roygame.models.Topping(_loc3_,which,_loc5_,dragging,_loc2_);
      _loc2_.totalToppings = _loc2_.totalToppings + 1;
      _loc2_.toppings.push(_loc4_);
      if(_loc3_.training)
      {
         if(_loc3_.trainingManager.currentStep == 13 || _loc3_.trainingManager.currentStep == 12)
         {
            if(_loc2_.toppings.length >= 4)
            {
               _loc3_.trainingManager.finishedStep(13);
            }
         }
      }
   }
   function removeTopping(whichid)
   {
      var _loc2_ = this;
      var _loc3_ = "topping" + whichid;
      _loc2_.gameObj.pauseManager.removePauseListener(_loc2_[_loc3_]);
      _loc2_[_loc3_].clip.removeMovieClip();
      delete _loc2_[_loc3_];
      _loc2_[_loc3_] = null;
      if(whichid > 0)
      {
         _loc2_.toppings[whichid - 1] = 0;
      }
   }
   function releaseTopping()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.totalToppings;
      var _loc4_ = "topping" + _loc3_;
      _loc2_[_loc4_].stopDragTopping();
   }
   function attachNewPizza(where)
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.gameObj;
      if(where == "topping")
      {
         var _loc7_ = "pizza" + _loc2_.id;
         var _loc6_ = 100 + _loc2_.id;
         _loc2_.clip = _loc4_.toppingScreen.clip.attachMovie("pizza",_loc7_,_loc6_);
         _loc2_.targetX = _loc2_.toppingTargetX;
         _loc2_.targetY = _loc2_.toppingTargetY;
         _loc2_.clip._y = _loc2_.targetY;
         _loc2_.clip._x = - _loc2_.clip._width;
         _loc2_.currentLocation = where;
         _loc2_.targetPosition = "topping";
         var _loc5_ = _loc4_.hudObj.activeTicket;
         var _loc3_ = _loc4_.ticketManager["ticket" + _loc5_];
         _loc3_.setMyPizza(_loc2_.id);
         _loc3_.pizzaIsTopping = true;
         _loc2_.whichTicket = _loc3_;
         _loc2_.startMovingPizza();
      }
   }
   function drawPizza(where)
   {
      var pizza = this;
      var _loc4_ = pizza.gameObj;
      if(where == "topping")
      {
         var _loc8_ = "pizza" + pizza.id;
         var _loc7_ = 100 + pizza.id;
         pizza.clip = _loc4_.toppingScreen.clip.attachMovie("pizza",_loc8_,_loc7_);
         pizza.targetX = pizza.toppingTargetX;
         pizza.targetY = pizza.toppingTargetY;
         pizza.clip._y = pizza.targetY;
         pizza.clip._x = - pizza.clip._width;
         pizza.currentLocation = where;
         pizza.targetPosition = "topping";
         pizza.whichTicket.pizzaIsTopping = true;
         var _loc2_ = 0;
         while(_loc2_ < pizza.toppings.length)
         {
            var _loc3_ = pizza.toppings[_loc2_];
            if(_loc3_ != 0)
            {
               pizza[_loc3_].attachTopping(false,true);
            }
            _loc2_ = _loc2_ + 1;
         }
         _loc4_.soundEngine.playSound("pizzaslide.wav",0,2);
         pizza.startMovingPizza();
      }
      else if(where == "baking")
      {
         _loc8_ = "pizza" + pizza.id;
         _loc7_ = 100 + pizza.id;
         pizza.clip = _loc4_.bakingScreen.clip.attachMovie("pizza",_loc8_,_loc7_);
         var _loc5_ = pizza.whichOvenSlot;
         pizza.targetX = pizza["bakingTargetX" + _loc5_];
         pizza.targetY = pizza["bakingTargetY" + _loc5_];
         pizza.clip._y = pizza.targetY;
         if(pizza.currentLocation == "baking")
         {
            pizza.clip._x = pizza.targetX;
            pizza.clip._y = pizza.targetY;
         }
         else
         {
            if(_loc5_ == 1 || _loc5_ == 3)
            {
               pizza.clip._x = - pizza.clip._width;
            }
            else
            {
               pizza.clip._x = 450;
            }
            _loc4_.soundEngine.playSound("pizzaslide.wav",0,2);
         }
         pizza.clip._width = pizza.bakingTargetWidth;
         pizza.clip._height = pizza.bakingTargetWidth;
         pizza.currentLocation = where;
         pizza.targetPosition = "ovenslot";
         _loc2_ = 0;
         while(_loc2_ < pizza.toppings.length)
         {
            _loc3_ = pizza.toppings[_loc2_];
            if(_loc3_ != 0)
            {
               pizza[_loc3_].attachTopping(false,false);
            }
            _loc2_ = _loc2_ + 1;
         }
         pizza.clip.onRelease = function()
         {
            pizza.removeFromOven();
         };
         pizza.changeCookLook(pizza.currentCookLook);
         pizza.startMovingPizza();
      }
      else if(where == "cutting")
      {
         _loc8_ = "pizza" + pizza.id;
         _loc7_ = 100 + pizza.id;
         pizza.clip = _loc4_.cuttingScreen.clip.attachMovie("pizza",_loc8_,_loc7_);
         pizza.targetX = pizza.cuttingTargetX;
         pizza.targetY = pizza.cuttingTargetY;
         pizza.clip._y = pizza.targetY;
         if(pizza.currentLocation == "cutting")
         {
            pizza.clip._x = pizza.targetX;
            pizza.clip._y = pizza.targetY;
         }
         else
         {
            pizza.clip._x = 450;
            _loc4_.soundEngine.playSound("pizzaslide.wav",0,2);
         }
         pizza.currentLocation = where;
         pizza.targetPosition = "cutting";
         _loc2_ = 0;
         while(_loc2_ < pizza.toppings.length)
         {
            _loc3_ = pizza.toppings[_loc2_];
            if(_loc3_ != 0)
            {
               pizza[_loc3_].attachTopping(false,false);
            }
            _loc2_ = _loc2_ + 1;
         }
         pizza.changeCookLook(pizza.currentCookLook);
         if(pizza.cuttingClip == null)
         {
            pizza.cuttingClip = new roygame.models.PizzaCutter(pizza);
         }
         else
         {
            pizza.cuttingClip.redrawPizzaCutter();
         }
         pizza.startMovingPizza();
      }
   }
   function changeCookLook(which)
   {
      var _loc4_ = this;
      _loc4_.currentCookLook = which;
      _loc4_.clip.shell.gotoAndStop(which + 1);
      var _loc2_ = 0;
      while(_loc2_ < _loc4_.toppings.length)
      {
         var _loc3_ = _loc4_.toppings[_loc2_];
         if(_loc3_ != 0)
         {
            _loc4_[_loc3_].changeCookLook(which);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function undrawPizza()
   {
      var _loc2_ = this;
      _loc2_.clip.removeMovieClip();
   }
   function retopPizza()
   {
      var _loc2_ = this;
      _loc2_.drawPizza("topping");
      _loc2_.setPizzaTarget("topping");
   }
   function setPizzaTarget(where)
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.gameObj;
      if(where == "save")
      {
         _loc2_.targetX = _loc2_.saveTargetX;
         _loc2_.targetY = _loc2_.saveTargetY;
         _loc2_.targetPosition = "save";
      }
      else if(where == "oven")
      {
         _loc2_.targetX = _loc2_.ovenTargetX;
         _loc2_.targetY = _loc2_.ovenTargetY;
         _loc2_.targetPosition = "oven";
      }
      else if(where == "topping")
      {
         _loc2_.targetX = _loc2_.toppingTargetX;
         _loc2_.targetY = _loc2_.toppingTargetY;
         _loc2_.targetPosition = "topping";
      }
      else if(where == "outofoven")
      {
         if(_loc2_.whichOvenSlot == 1 || _loc2_.whichOvenSlot == 3)
         {
            _loc2_.targetX = - _loc2_.clip._width;
            _loc2_.targetY = _loc2_.clip._y;
         }
         else
         {
            _loc2_.targetX = 450;
            _loc2_.targetY = _loc2_.clip._y;
         }
         _loc2_.targetPosition = "outofoven";
      }
      else if(where == "throwaway")
      {
         _loc2_.targetX = - _loc2_.clip._width;
         _loc2_.targetY = _loc2_.clip._y;
         _loc2_.targetPosition = "throwaway";
      }
      _loc4_.soundEngine.playSound("pizzaslide.wav",0,2);
      _loc2_.startMovingPizza();
   }
   function startMovingPizza()
   {
      var pizza = this;
      var _loc2_ = pizza.gameObj;
      pizza.isMoving = true;
      pizza.clip.onEnterFrame = function()
      {
         pizza.movePizza();
      };
   }
   function stopMovingPizza()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.isMoving = false;
      delete _loc2_.clip.onEnterFrame;
      if(_loc2_.targetPosition == "topping")
      {
         _loc3_.hudObj.switchTicketMode("pizza");
      }
      else if(_loc2_.targetPosition == "oven")
      {
         _loc2_.undrawPizza();
         if(_loc3_.hudObj.activeTicket > 0)
         {
            _loc3_.hudObj.switchTicketMode("topping");
         }
         _loc3_.switchModes("baking","allow");
      }
      else if(_loc2_.targetPosition == "save")
      {
         _loc2_.undrawPizza();
         if(_loc3_.hudObj.activeTicket > 0)
         {
            _loc3_.hudObj.switchTicketMode("ticket");
         }
      }
      else if(_loc2_.targetPosition == "outofoven")
      {
         _loc2_.undrawPizza();
         _loc3_.switchModes("cutting","allow");
      }
      else if(_loc2_.targetPosition == "cutting")
      {
         if(_loc3_.hudObj.activeTicket > 0)
         {
            _loc3_.hudObj.switchTicketMode("ticket");
         }
         else
         {
            _loc3_.hudObj.switchTicketMode("pizza");
         }
      }
      else if(_loc2_.targetPosition == "throwaway")
      {
         _loc2_.undrawPizza();
         _loc3_.hudObj.switchTicketMode("blank");
         _loc3_.cuttingScreen.pizzaWasThrown();
      }
   }
   function movePizza()
   {
      var _loc2_ = this;
      var _loc7_ = _loc2_.gameObj;
      if(!_loc7_.pauseManager.isPaused)
      {
         var _loc6_ = _loc2_.targetX - _loc2_.clip._x;
         var _loc5_ = _loc2_.targetY - _loc2_.clip._y;
         var _loc4_ = _loc6_ / _loc2_.speedSteps;
         var _loc3_ = _loc5_ / _loc2_.speedSteps;
         if(Math.abs(_loc4_) < 1 && Math.abs(_loc3_) < 1)
         {
            _loc2_.clip._x = _loc2_.targetX;
            _loc2_.clip._y = _loc2_.targetY;
            _loc2_.stopMovingPizza();
         }
         else
         {
            _loc2_.clip._x += _loc4_;
            _loc2_.clip._y += _loc3_;
         }
      }
   }
   function saveForLater()
   {
      var _loc2_ = this;
      _loc2_.setPizzaTarget("save");
      _loc2_.whichTicket.pizzaIsTopping = false;
   }
   function throwAway()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.setPizzaTarget("throwaway");
   }
   function putInOven()
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.gameObj;
      var _loc3_ = _loc4_.bakingScreen.checkPizzaSlots();
      if(_loc3_ != 0)
      {
         _loc2_.setPizzaTarget("oven");
         _loc2_.whichTicket.removeMyPizza();
         _loc2_.whichTicket = null;
         _loc2_.whichOvenSlot = _loc3_;
         _loc4_.bakingScreen.pizzas[_loc3_ - 1] = _loc2_;
         _loc4_.bakingScreen.restartTimer(_loc3_);
      }
      else
      {
         trace("oven is full!");
      }
   }
   function removeFromOven()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      var _loc4_ = false;
      if(_loc3_.training)
      {
         if(_loc3_.trainingManager.currentStep == 19)
         {
            _loc4_ = true;
         }
      }
      var _loc5_ = _loc3_.pauseManager.isPaused;
      if((!_loc3_.training || _loc4_) && !_loc5_)
      {
         var _loc6_ = _loc3_.bakingScreen["cooktime" + _loc2_.whichOvenSlot];
         _loc2_.cookTime = _loc6_;
         trace("Total Baking Time: " + _loc2_.cookTime + " degrees:  Doneness Level " + Math.floor(_loc2_.cookTime / 45));
         _loc3_.bakingScreen.pizzas[_loc2_.whichOvenSlot - 1] = 0;
         _loc3_.cuttingScreen.pizzas.push(_loc2_);
         _loc2_.setPizzaTarget("outofoven");
         _loc3_.bakingScreen.stopTimer(_loc2_.whichOvenSlot);
      }
   }
   function pauseUpdate(msg)
   {
   }
}
