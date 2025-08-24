class roygame.models.TakeOrderScreen
{
   var active = false;
   var currentOrderLine = -1;
   var lineIntervalSpeed = 2000;
   var startIntervalSpeed = 700;
   var lastIntervalTime = 0;
   var lastPauseOffset = 0;
   var totalOrders = 0;
   var orderInProcess = false;
   function TakeOrderScreen(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.gameclip = _loc2_.gameObj.clip;
      _loc2_.setupScreen();
   }
   function setupScreen()
   {
      var _loc2_ = this;
      _loc2_.clip = _loc2_.gameclip.attachMovie("takeorder_screen","takeorder_screen",9);
      _loc2_.clip._x = -5000;
      _loc2_.orderInProcess = false;
      _loc2_.gameObj.pauseManager.addPauseListener(this);
   }
   function takeNewOrder(whichorder)
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.gameObj;
      _loc2_.orderInProcess = true;
      var _loc9_ = _loc4_.currentDay;
      var _loc8_ = _loc2_.totalOrders + 1;
      var _loc10_ = _loc4_.leveldata;
      _loc2_.currentOrderLine = -1;
      var _loc7_ = _loc4_.customerManager.orderline[0];
      _loc2_.currentCustomer = _loc7_;
      _loc2_.currentCustomer.drawCustomerOrdering();
      _loc2_.currentCustomer.takeorder_clip.gotoAndStop("stand");
      _loc2_.newOrder = _loc2_.currentCustomer.orders[_loc2_.currentCustomer.difficulty][_loc2_.currentCustomer.currentOrder];
      _loc4_.ticketManager.AddTicket(_loc8_,_loc2_.newOrder,_loc2_.currentCustomer);
      _loc2_.clip.attachMovie("takeorder_fg","takeorder_fg",20);
      _loc2_.clip.bubble.gotoAndStop("open");
      _loc2_.lineInterval = setInterval(this,"setupLineInterval",_loc2_.startIntervalSpeed);
      _loc2_.whichInterval = "setup";
      _loc2_.lastIntervalTime = getTimer();
      _loc2_.totalOrders = _loc2_.totalOrders + 1;
      _loc2_.clip.takeorder_fg.customername.text = _loc4_.customerdata[_loc2_.currentCustomer.customertype][1];
      var _loc5_ = _loc4_.customerdata[_loc2_.currentCustomer.customertype][5];
      var _loc3_ = 1;
      while(_loc3_ <= _loc5_)
      {
         _loc2_.clip.takeorder_fg.stars["star" + _loc3_].gotoAndStop(2);
         _loc3_ = _loc3_ + 1;
      }
      var _loc6_ = _loc4_.customerdata[_loc2_.currentCustomer.customertype][6];
      if(_loc6_ > 0)
      {
         _loc2_.clip.takeorder_fg.stars.currentseal._visible = true;
         _loc2_.clip.takeorder_fg.stars.currentseal.gotoAndStop(_loc6_);
      }
      else
      {
         _loc2_.clip.takeorder_fg.stars.currentseal._visible = false;
      }
   }
   function setupLineInterval()
   {
      var _loc2_ = this;
      clearInterval(_loc2_.lineInterval);
      _loc2_.currentCustomer.takeorder_clip.gotoAndPlay("takeorder");
      _loc2_.drawNewOrderLine();
      _loc2_.whichInterval = "draw";
      _loc2_.lastIntervalTime = getTimer();
   }
   function setActiveTicket(ticket)
   {
      var _loc2_ = this;
      _loc2_.currentTicket = ticket;
   }
   function drawNewOrderLine()
   {
      var _loc4_ = this;
      var _loc8_ = _loc4_.gameObj;
      var _loc5_ = _loc4_.newOrder;
      var _loc16_ = _loc4_.currentOrderLine;
      var _loc6_ = _loc4_.currentTicket;
      clearInterval(_loc4_.lineInterval);
      _loc4_.lineInterval = setInterval(this,"drawNewOrderLine",_loc4_.lineIntervalSpeed);
      var _loc3_ = _loc16_ + 1;
      var _loc2_ = _loc3_;
      while(_loc2_ <= 9)
      {
         if(_loc2_ >= 7)
         {
            _loc3_ = _loc2_;
            break;
         }
         if(_loc5_[_loc2_][0] > 0)
         {
            _loc3_ = _loc2_;
            break;
         }
         _loc2_ = _loc2_ + 1;
      }
      if(_loc3_ < 7)
      {
         _loc4_.clip.bubble.gotoAndStop("topping");
         var _loc14_ = _loc3_;
         var _loc11_ = _loc5_[_loc3_][0];
         var _loc12_ = _loc5_[_loc3_][1];
         var _loc9_ = _loc5_[_loc3_][2];
         var _loc10_ = _loc5_[_loc3_][3];
         var _loc15_ = _loc5_[_loc3_][4];
         _loc4_.drawBalloonLine(_loc14_,_loc11_,_loc12_,_loc9_,_loc10_,_loc15_);
         _loc6_.drawTicketLine(_loc14_,_loc11_,_loc12_,_loc9_,_loc10_,_loc15_);
      }
      else if(_loc3_ == 7)
      {
         _loc4_.clip.bubble.gotoAndStop("time");
         var _loc13_ = _loc5_[7];
         _loc4_.clip.bubble.clock.gotoAndStop(_loc13_ + 1);
         _loc6_.drawTicketTime(_loc13_);
      }
      else if(_loc3_ == 8)
      {
         _loc4_.clip.bubble.gotoAndStop("cut");
         var _loc7_ = _loc5_[8];
         if(_loc7_ == 4)
         {
            _loc4_.clip.bubble.cut.gotoAndStop(2);
         }
         else if(_loc7_ == 6)
         {
            _loc4_.clip.bubble.cut.gotoAndStop(3);
         }
         else if(_loc7_ == 8)
         {
            _loc4_.clip.bubble.cut.gotoAndStop(4);
         }
         _loc6_.drawTicketCut(_loc7_);
      }
      else if(_loc3_ == 9)
      {
         _loc4_.clip.bubble.gotoAndStop("invisible");
         _loc4_.currentCustomer.takeorder_clip.gotoAndStop("stand");
         _loc6_.finishTakingOrder();
         _loc4_.currentCustomer.orderIsPlaced = true;
         _loc8_.switchModes("order","allow");
         clearInterval(_loc4_.lineInterval);
         _loc4_.whichInterval = "done";
      }
      if(_loc3_ < 9)
      {
         _loc4_.clip.takeorder_fg.roy.play();
         _loc8_.soundEngine.playSound("writepencil.wav");
         _loc8_.soundEngine.playSound("talkbubble.wav",0,2);
      }
      _loc4_.lastIntervalTime = getTimer();
      _loc4_.currentOrderLine = _loc3_;
   }
   function drawBalloonLine(whichtopping, toppingamount, getslice1, getslice2, getslice3, getslice4)
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_.clip.bubble;
      _loc2_.amount.text = toppingamount;
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
   }
   function setCurrentMode()
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_.gameObj;
      _loc3_.clip._x = 0;
      _loc3_.active = true;
      _loc2_.toppingScreen.setNotCurrentMode();
      _loc2_.orderScreen.setNotCurrentMode();
      _loc2_.cuttingScreen.setNotCurrentMode();
      _loc2_.bakingScreen.setNotCurrentMode();
      _loc2_.pauseScreen.setNotCurrentMode();
      _loc2_.soundEngine.switchMusic(1);
      _loc2_.hudObj.setMode("takeorder");
      if(!_loc3_.orderInProcess)
      {
         _loc3_.takeNewOrder();
      }
   }
   function setNotCurrentMode()
   {
      var _loc2_ = this;
      _loc2_.clip._x = -5000;
      _loc2_.active = false;
   }
   function pauseUpdate(msg)
   {
      var _loc2_ = this;
      var _loc5_ = _loc2_.gameObj;
      if(msg == "pause")
      {
         if(_loc2_.whichInterval != "done")
         {
            _loc2_.lastPauseOffset = getTimer() - _loc2_.lastIntervalTime;
            clearInterval(_loc2_.lineInterval);
         }
      }
      else if(msg == "unpause")
      {
         if(_loc2_.whichInterval != "done")
         {
            var _loc6_ = _loc2_.lastPauseOffset;
            var _loc4_ = undefined;
            if(_loc2_.whichInterval == "setup")
            {
               _loc4_ = _loc2_.startIntervalSpeed;
            }
            else if(_loc2_.whichInterval == "draw")
            {
               _loc4_ = _loc2_.lineIntervalSpeed;
            }
            var _loc3_ = _loc4_ - _loc6_;
            if(_loc3_ < 0)
            {
               _loc3_ = _loc4_;
            }
            else if(_loc3_ > _loc4_)
            {
               _loc3_ = _loc4_;
            }
            else
            {
               _loc2_.lastIntervalTime = getTimer() - _loc2_.lastPauseOffset;
            }
            if(_loc2_.whichInterval == "setup")
            {
               _loc2_.lineInterval = setInterval(this,"setupLineInterval",_loc3_);
            }
            else if(_loc2_.whichInterval == "draw")
            {
               _loc2_.lineInterval = setInterval(this,"drawNewOrderLine",_loc3_);
            }
         }
         else
         {
            _loc2_.currentTicket.finishTakingOrder();
            _loc2_.currentCustomer.orderIsPlaced = true;
            _loc5_.switchModes("order","allow");
         }
      }
   }
}
