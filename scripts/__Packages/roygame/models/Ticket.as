class roygame.models.Ticket
{
   var gameObj;
   var orderNumber = 0;
   var whichPizza = 0;
   var pizzaIsTopping = false;
   var orderIsTaken = false;
   var currentDrawLine = 0;
   var detailX = 522;
   var detailY = 134;
   var detailWidth = 152;
   var detailHeight = 288;
   var lineY = 13;
   var lineWidth = 43;
   var lineHeight = 85;
   var lineMinX = 32;
   var lineMaxX = 352;
   var lastDepth = 1000;
   var tweenSteps = 2;
   var targetX = 0;
   var targetY = 0;
   var targetWidth = 1;
   var targetHeight = 1;
   var pauseCache = 0;
   var lastPauseStart = 0;
   var ordersAheadOfMe = 0;
   function Ticket(gameobj, ordernum, orderdata, customer)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.orderNumber = ordernum;
      _loc2_.orderData = orderdata;
      _loc2_.whichCustomer = customer;
      _loc2_.attachNewTicket();
   }
   function attachNewTicket()
   {
      var ticket = this;
      var _loc4_ = ticket.gameObj;
      var _loc5_ = "ticket" + ticket.orderNumber;
      var _loc3_ = _loc4_.hudObj.clip.getNextHighestDepth();
      _loc3_ = Math.max(_loc3_,1001);
      ticket.clip = _loc4_.hudObj.clip.attachMovie("ticket",_loc5_,_loc3_);
      ticket.clip._x = ticket.detailX;
      ticket.clip._y = ticket.detailY;
      ticket.clip._width = ticket.detailWidth;
      ticket.clip._height = ticket.detailHeight;
      var _loc2_ = ticket.orderNumber;
      if(_loc2_ < 10)
      {
         _loc2_ = "00" + _loc2_;
      }
      else if(_loc2_ < 100)
      {
         _loc2_ = "0" + _loc2_;
      }
      ticket.clip.number.text = _loc2_;
      this.gameObj.hudObj.setActiveTicket(ticket.orderNumber);
      this.gameObj.takeOrderScreen.setActiveTicket(ticket);
      ticket.clearTicketLines();
      ticket.clip.onPress = function()
      {
         ticket.dragTicket();
      };
      ticket.clip.onRelease = function()
      {
         ticket.stopDragTicket();
      };
      ticket.clip.onReleaseOutside = function()
      {
         ticket.stopDragTicket();
      };
      _loc4_.pauseManager.addPauseListener(this);
   }
   function dragTicket()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      var _loc6_ = _loc3_.hudObj.currentMode;
      var _loc4_ = true;
      if(_loc3_.training)
      {
         if(_loc3_.trainingManager.canDragTicket)
         {
            _loc4_ = true;
         }
         else
         {
            _loc4_ = false;
         }
      }
      var _loc5_ = true;
      if(_loc3_.pauseManager.isPaused)
      {
         _loc5_ = false;
      }
      _loc2_.clip.ticketflash.gotoAndStop(1);
      if(_loc2_.orderIsTaken && _loc6_ != "giveorder" && _loc4_ && _loc5_)
      {
         if(_loc3_.hudObj.activeTicket == _loc2_.orderNumber)
         {
            _loc2_.gameObj.hudObj.setTooltip("Drag to ticket line");
         }
         else
         {
            _loc2_.gameObj.hudObj.setTooltip("Drag to viewing area");
         }
         _loc2_.clip._width = _loc2_.lineWidth;
         _loc2_.clip._height = _loc2_.lineHeight;
         _loc2_.lastDepth = _loc2_.clip.getDepth();
         _loc2_.clip.swapDepths(1500);
         delete _loc2_.clip.onEnterFrame;
         _loc3_.soundEngine.playSound("grabticket.wav");
         _loc2_.clip.startDrag(true);
      }
      else
      {
         _loc2_.gameObj.hudObj.setTooltip("WAIT!");
      }
   }
   function stopDragTicket()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      var _loc4_ = true;
      if(_loc3_.pauseManager.isPaused)
      {
         _loc4_ = false;
      }
      if(_loc4_)
      {
         _loc2_.clip.stopDrag();
         _loc3_.hudObj.setTooltip(" ... ");
         _loc2_.clip.swapDepths(_loc3_.hudObj.clip.getNextHighestDepth());
         _loc3_.ticketManager.sortDepths();
         _loc3_.soundEngine.playSound("dropticket.wav");
         if(_loc2_.clip.hitTest(_loc3_.hudObj.clip.ticketarea))
         {
            _loc2_.snapToPanel();
         }
         else if(_loc2_.clip.hitTest(_loc3_.hudObj.clip.ticketline))
         {
            _loc2_.snapToLine();
         }
         else if(_loc3_.hudObj.activeTicket == _loc2_.orderNumber)
         {
            _loc2_.snapToPanel();
         }
         else
         {
            _loc2_.snapToLine();
         }
      }
   }
   function tweenTicket()
   {
      var _loc2_ = this;
      var _loc11_ = Math.floor;
      var _loc7_ = _loc2_.targetX - _loc2_.clip._x;
      var _loc6_ = _loc2_.targetY - _loc2_.clip._y;
      var _loc3_ = _loc7_ / _loc2_.tweenSteps;
      var _loc4_ = _loc6_ / _loc2_.tweenSteps;
      var _loc9_ = _loc2_.targetWidth - _loc2_.clip._width;
      var _loc8_ = _loc2_.targetHeight - _loc2_.clip._height;
      var _loc5_ = _loc9_ / _loc2_.tweenSteps;
      var _loc10_ = _loc8_ / _loc2_.tweenSteps;
      if(Math.abs(_loc3_) < 1 && Math.abs(_loc4_) < 1)
      {
         _loc2_.clip._x = _loc2_.targetX;
         _loc2_.clip._y = _loc2_.targetY;
         _loc2_.clip._width = _loc2_.targetWidth;
         _loc2_.clip._height = _loc2_.targetHeight;
         delete _loc2_.clip.onEnterFrame;
      }
      else
      {
         _loc2_.clip._x += _loc3_;
         _loc2_.clip._y += _loc4_;
         if(_loc2_.clip._width < _loc2_.targetWidth)
         {
            _loc2_.clip._width += _loc5_;
            _loc2_.clip._height += _loc10_;
         }
         else
         {
            _loc2_.clip._width = _loc2_.targetWidth;
            _loc2_.clip._height = _loc2_.targetHeight;
         }
      }
   }
   function snapToLine(automove)
   {
      var ticket = this;
      var _loc2_ = ticket.gameObj;
      var _loc3_ = ticket.clip._x;
      if(automove)
      {
         _loc3_ = ticket.lineMaxX - random(15);
      }
      else if(_loc3_ < ticket.lineMinX)
      {
         _loc3_ = ticket.lineMinX;
      }
      else if(_loc3_ > ticket.lineMaxX)
      {
         _loc3_ = ticket.lineMaxX;
      }
      ticket.targetX = _loc3_;
      ticket.targetY = ticket.lineY;
      ticket.targetWidth = ticket.lineWidth;
      ticket.targetHeight = ticket.lineHeight;
      if(_loc2_.training)
      {
         if(_loc2_.trainingManager.currentStep == 16)
         {
            _loc2_.trainingManager.finishedStep(16);
         }
         else if(_loc2_.trainingManager.currentStep == 8)
         {
            _loc2_.trainingManager.finishedStep(8);
         }
      }
      if(_loc2_.hudObj.activeTicket == ticket.orderNumber)
      {
         if(ticket.whichPizza > 0)
         {
            if(ticket.pizzaIsTopping)
            {
               var _loc4_ = ticket.whichPizza;
               var _loc5_ = "pizza" + _loc4_;
               _loc2_.pizzaManager[_loc5_].saveForLater();
            }
         }
         if(_loc2_.currentMode == "takeOrder")
         {
         }
         _loc2_.hudObj.setActiveTicket(0);
      }
      ticket.clip.onEnterFrame = function()
      {
         ticket.tweenTicket();
      };
   }
   function setMyPizza(which)
   {
      var _loc2_ = this;
      _loc2_.whichPizza = which;
   }
   function removeMyPizza()
   {
      var _loc2_ = this;
      _loc2_.whichPizza = 0;
   }
   function snapToPanel()
   {
      var ticket = this;
      var _loc2_ = ticket.gameObj;
      ticket.targetX = ticket.detailX;
      ticket.targetY = ticket.detailY;
      ticket.targetWidth = ticket.detailWidth;
      ticket.targetHeight = ticket.detailHeight;
      if(_loc2_.training)
      {
         if(_loc2_.trainingManager.currentStep == 17)
         {
            _loc2_.trainingManager.finishedStep(17);
         }
      }
      if(_loc2_.hudObj.activeTicket == 0)
      {
         _loc2_.hudObj.setActiveTicket(ticket.orderNumber);
      }
      else if(_loc2_.hudObj.activeTicket != ticket.orderNumber)
      {
         var _loc4_ = _loc2_.hudObj.activeTicket;
         var _loc3_ = _loc2_.ticketManager["ticket" + _loc4_];
         if(_loc3_.orderIsTaken)
         {
            _loc3_.snapToLine("automove");
            _loc2_.hudObj.setActiveTicket(ticket.orderNumber);
         }
         else
         {
            ticket.snapToLine();
         }
      }
      ticket.clip.onEnterFrame = function()
      {
         ticket.tweenTicket();
      };
   }
   function finishTakingOrder()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.orderIsTaken = true;
      if(_loc2_.timeTaken == 0 || _loc2_.timeTaken == undefined)
      {
         _loc2_.timeTaken = getTimer();
      }
      trace("TIME TAKEN: " + _loc2_.timeTaken);
      _loc2_.ordersAheadOfMe = _loc3_.customerManager.waitline.length;
      if(_loc3_.training)
      {
         if(_loc3_.trainingManager.currentStep == 7)
         {
            _loc3_.trainingManager.finishedStep(7);
         }
      }
   }
   function drawTicketLine(whichtopping, toppingamount, getslice1, getslice2, getslice3, getslice4)
   {
      var _loc3_ = this;
      var _loc4_ = _loc3_.currentDrawLine + 1;
      var _loc2_ = _loc3_.clip["line" + _loc4_];
      _loc2_.gotoAndStop(1);
      _loc2_.number.gotoAndStop(toppingamount);
      _loc2_.topping.gotoAndStop(whichtopping + 1);
      if(getslice1)
      {
         _loc2_.chart.slice1.gotoAndStop(1);
      }
      else
      {
         _loc2_.chart.slice1.gotoAndStop(2);
      }
      if(getslice2)
      {
         _loc2_.chart.slice2.gotoAndStop(1);
      }
      else
      {
         _loc2_.chart.slice2.gotoAndStop(2);
      }
      if(getslice3)
      {
         _loc2_.chart.slice3.gotoAndStop(1);
      }
      else
      {
         _loc2_.chart.slice3.gotoAndStop(2);
      }
      if(getslice4)
      {
         _loc2_.chart.slice4.gotoAndStop(1);
      }
      else
      {
         _loc2_.chart.slice4.gotoAndStop(2);
      }
      _loc3_.currentDrawLine = _loc3_.currentDrawLine + 1;
   }
   function drawTicketTime(whattime)
   {
      var _loc2_ = this;
      _loc2_.cookTime = whattime;
      _loc2_.clip.clock.gotoAndStop(_loc2_.cookTime + 1);
   }
   function drawTicketCut(whatcut)
   {
      var _loc2_ = this;
      _loc2_.cutNumber = whatcut;
      if(_loc2_.cutNumber == 4)
      {
         _loc2_.clip.cut.gotoAndStop(2);
      }
      else if(_loc2_.cutNumber == 6)
      {
         _loc2_.clip.cut.gotoAndStop(3);
      }
      else if(_loc2_.cutNumber == 8)
      {
         _loc2_.clip.cut.gotoAndStop(4);
      }
      else
      {
         trace("what is this cut?: " + _loc2_.cutNumber);
      }
   }
   function clearTicketLines()
   {
      var _loc3_ = this;
      var _loc2_ = 1;
      while(_loc2_ < 8)
      {
         _loc3_.clip["line" + _loc2_].gotoAndStop(2);
         _loc2_ = _loc2_ + 1;
      }
      _loc3_.clip.clock.gotoAndStop(1);
      _loc3_.clip.cut.gotoAndStop(1);
   }
   function drawTicket()
   {
      var _loc5_ = this;
      var _loc6_ = 1;
      var _loc3_ = _loc5_.orderData;
      var _loc4_ = 0;
      while(_loc4_ < 7)
      {
         if(_loc3_[_loc4_][0] > 0)
         {
            var _loc2_ = _loc5_.clip["line" + _loc6_];
            _loc2_.number.gotoAndStop(_loc3_[_loc4_][0]);
            _loc2_.topping.gotoAndStop(_loc4_ + 1);
            if(_loc3_[_loc4_][1] == 1)
            {
               _loc2_.chart.slice1.gotoAndStop(1);
            }
            else
            {
               _loc2_.chart.slice1.gotoAndStop(2);
            }
            if(_loc3_[_loc4_][2] == 1)
            {
               _loc2_.chart.slice2.gotoAndStop(1);
            }
            else
            {
               _loc2_.chart.slice2.gotoAndStop(2);
            }
            if(_loc3_[_loc4_][3] == 1)
            {
               _loc2_.chart.slice3.gotoAndStop(1);
            }
            else
            {
               _loc2_.chart.slice3.gotoAndStop(2);
            }
            if(_loc3_[_loc4_][4] == 1)
            {
               _loc2_.chart.slice4.gotoAndStop(1);
            }
            else
            {
               _loc2_.chart.slice4.gotoAndStop(2);
            }
            _loc6_ = _loc6_ + 1;
         }
         _loc4_ = _loc4_ + 1;
      }
      if(_loc6_ < 8)
      {
         _loc4_ = _loc6_;
         while(_loc4_ < 8)
         {
            _loc5_.clip["line" + _loc4_].gotoAndStop(2);
            _loc4_ = _loc4_ + 1;
         }
      }
      _loc5_.cookTime = _loc3_[7];
      _loc5_.clip.clock.gotoAndStop(_loc5_.cookTime + 1);
      _loc5_.cutNumber = _loc3_[8];
      if(_loc5_.cutNumber == 4)
      {
         _loc5_.clip.cut.gotoAndStop(2);
      }
      else if(_loc5_.cutNumber == 6)
      {
         _loc5_.clip.cut.gotoAndStop(3);
      }
      else if(_loc5_.cutNumber == 8)
      {
         _loc5_.clip.cut.gotoAndStop(4);
      }
      else
      {
         trace("what is this cut?: " + _loc5_.cutNumber);
      }
   }
   function pauseUpdate(msg)
   {
      var _loc2_ = this;
      if(msg == "pause")
      {
         _loc2_.lastPauseStart = getTimer();
      }
      else if(msg == "unpause")
      {
         var _loc3_ = getTimer() - _loc2_.lastPauseStart;
         if(_loc2_.orderIsTaken)
         {
            _loc2_.pauseCache += _loc3_;
         }
      }
   }
}
