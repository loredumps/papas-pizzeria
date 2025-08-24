class roygame.models.GiveOrderScreen
{
   var currentTipAmount;
   var currentTipText;
   var active = false;
   var orderInProcess = false;
   var lookSpeed = 1980;
   var reactSpeed = 1485;
   var returnSpeed = 3300;
   var tipSpeed = 1300;
   var endSpeed = 600;
   var lastIntervalTime = 0;
   var lastPauseOffset = 0;
   var coinFrame = 1;
   var coinJarFrame = 1;
   var earnStarNumber = 0;
   var loseStarNumber = 0;
   function GiveOrderScreen(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.gameclip = _loc2_.gameObj.clip;
      _loc2_.setupScreen();
   }
   function setupScreen()
   {
      var _loc2_ = this;
      _loc2_.clip = _loc2_.gameclip.attachMovie("giveorder_screen","giveorder_screen",10);
      _loc2_.clip._x = -5000;
      _loc2_.orderInProcess = false;
      _loc2_.gameObj.pauseManager.addPauseListener(this);
   }
   function presentPizza()
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.gameObj;
      _loc2_.orderInProcess = true;
      _loc2_.earnStarNumber = 0;
      _loc2_.loseStarNumber = 0;
      var _loc7_ = _loc4_.hudObj.activeTicket;
      _loc2_.currentTicket = _loc4_.ticketManager["ticket" + _loc7_];
      _loc2_.currentCustomer = _loc2_.currentTicket.whichCustomer;
      _loc2_.currentPizza = _loc4_.cuttingScreen.pizzas[0];
      _loc2_.currentCustomer.drawCustomerPresenting();
      _loc2_.clip.attachMovie("giveorder_fg","giveorder_fg",20);
      _loc2_.checkAccuracy();
      _loc2_.clip.giveorder_fg.roy.play();
      _loc4_.soundEngine.playSound("giveorder_drumroll.wav",0,2);
      _loc2_.cycleInterval = setInterval(this,"lookAtPizza",_loc2_.lookSpeed);
      _loc2_.whichInterval = "lookAtPizza";
      _loc2_.lastIntervalTime = getTimer();
      _loc2_.clip.giveorder_fg.customername.text = _loc4_.customerdata[_loc2_.currentCustomer.customertype][1];
      var _loc5_ = _loc4_.customerdata[_loc2_.currentCustomer.customertype][5];
      var _loc3_ = 1;
      while(_loc3_ <= _loc5_)
      {
         _loc2_.clip.giveorder_fg.stars["star" + _loc3_].gotoAndStop(2);
         _loc3_ = _loc3_ + 1;
      }
      var _loc6_ = _loc4_.customerdata[_loc2_.currentCustomer.customertype][6];
      if(_loc6_ > 0)
      {
         _loc2_.clip.giveorder_fg.stars.currentseal._visible = true;
         _loc2_.clip.giveorder_fg.stars.currentseal.gotoAndStop(_loc6_);
      }
      else
      {
         _loc2_.clip.giveorder_fg.stars.currentseal._visible = false;
      }
      trace("draw how many in jar?: " + _loc2_.coinJarFrame);
      _loc2_.clip.giveorder_fg.tipjar.clip.tipclip.coins.gotoAndStop(_loc2_.coinJarFrame);
      _loc2_.clip.giveorder_fg.stars.award.gotoAndStop(1);
   }
   function checkAccuracy()
   {
      var _loc2_ = this;
      var _loc5_ = _loc2_.gameObj;
      var _loc10_ = _loc2_.checkBakingAccuracy();
      var _loc12_ = _loc2_.checkWaitAccuracy();
      var _loc9_ = _loc2_.checkToppingAccuracy();
      var _loc13_ = _loc2_.checkCuttingAccuracy();
      var _loc3_ = (_loc10_ + _loc12_ + _loc9_ + _loc13_) / 400;
      _loc3_ = Math.floor(_loc3_ * 100);
      if(_loc3_ >= 90)
      {
         _loc2_.customerReaction = "overjoyed";
      }
      else if(_loc3_ >= 80)
      {
         _loc2_.customerReaction = "happy";
      }
      else if(_loc3_ >= 70)
      {
         _loc2_.customerReaction = "decent";
      }
      else if(_loc3_ >= 60)
      {
         _loc2_.customerReaction = "worried";
      }
      else if(_loc3_ >= 50)
      {
         _loc2_.customerReaction = "upset";
      }
      else if(_loc3_ < 50)
      {
         _loc2_.customerReaction = "pissed";
      }
      else
      {
         _loc2_.customerReaction = "decent";
      }
      _loc2_.clip.giveorder_fg.accuracyclip.waitingscore.score.text = _loc12_;
      _loc2_.clip.giveorder_fg.accuracyclip.toppingscore.score.text = _loc9_;
      _loc2_.clip.giveorder_fg.accuracyclip.bakingscore.score.text = _loc10_;
      _loc2_.clip.giveorder_fg.accuracyclip.cuttingscore.score.text = _loc13_;
      _loc5_.waitingToday += _loc12_;
      _loc5_.toppingToday += _loc9_;
      _loc5_.bakingToday += _loc10_;
      _loc5_.cuttingToday += _loc13_;
      _loc5_.customersToday = _loc5_.customersToday + 1;
      var _loc8_ = _loc5_.customerdata[_loc2_.currentCustomer.customertype][5];
      if(_loc3_ >= 80)
      {
         if(_loc8_ < 5)
         {
            _loc2_.earnStarNumber = _loc8_ + 1;
         }
      }
      else if(_loc3_ < 60)
      {
         if(_loc8_ > 0)
         {
            _loc2_.loseStarNumber = _loc8_;
         }
      }
      var _loc11_ = _loc2_.currentCustomer.maxTip;
      var _loc17_ = _loc5_.customerdata[_loc2_.currentCustomer.customertype][6];
      var _loc16_ = _loc17_ * _loc2_.currentCustomer.extraTipPerBadge;
      _loc11_ += _loc16_;
      var _loc4_ = Math.round(_loc3_ / 100 * _loc11_ - (100 - _loc3_) / 100 * _loc11_);
      if(_loc4_ < 0)
      {
         _loc4_ = 0;
      }
      if(_loc2_.earnStarNumber == 5)
      {
         _loc4_ = 900;
      }
      var _loc18_ = _loc4_ / 100;
      _loc5_.tipsToday += _loc4_;
      var _loc6_ = undefined;
      if(_loc3_ < 50)
      {
         _loc6_ = 1;
      }
      else if(_loc3_ < 60)
      {
         _loc6_ = 2;
      }
      else if(_loc3_ < 70)
      {
         _loc6_ = 3;
      }
      else if(_loc3_ < 80)
      {
         _loc6_ = 4;
      }
      else if(_loc3_ < 90)
      {
         _loc6_ = 5;
      }
      else if(_loc3_ < 100)
      {
         _loc6_ = 6;
      }
      else if(_loc3_ >= 100)
      {
         _loc6_ = 6;
      }
      var _loc14_ = Math.floor(_loc18_);
      var _loc7_ = _loc4_ - _loc14_ * 100;
      var _loc19_ = _loc7_ / 100;
      if(_loc7_ < 10)
      {
         _loc7_ = "0" + _loc7_;
      }
      else if(_loc7_ == 0)
      {
         _loc7_ = "00";
      }
      var _loc15_ = "$" + _loc14_ + "." + _loc7_;
      if(_loc4_ <= 0)
      {
         _loc4_ = 0;
         _loc15_ = " $0.00 ";
      }
      _loc2_.coinFrame = _loc6_;
      _loc2_.currentTipAmount = _loc4_;
      _loc2_.currentTipText = _loc15_;
      trace("-- The tip (c): " + this.currentTipAmount);
      trace("-- The tip ($): " + this.currentTipText);
      trace(" ");
   }
   function checkBakingAccuracy()
   {
      var _loc2_ = this;
      var _loc10_ = _loc2_.currentPizza;
      var _loc5_ = _loc2_.currentTicket;
      var _loc3_ = _loc5_.cookTime;
      var _loc9_ = _loc10_.cookTime;
      var _loc11_ = _loc3_ * 45;
      var _loc8_ = Math.abs(_loc11_ - _loc9_);
      var _loc6_ = 90;
      var _loc4_ = _loc8_ / _loc6_;
      var _loc7_ = Math.max(0,Math.floor(100 - _loc4_ * 100));
      return _loc7_;
   }
   function checkWaitAccuracy()
   {
      var _loc3_ = this;
      var _loc19_ = _loc3_.gameObj;
      var _loc29_ = _loc3_.currentPizza;
      var _loc4_ = _loc3_.currentTicket;
      var _loc15_ = _loc3_.currentCustomer;
      trace(" ");
      trace("-----    WAITING ACCURACY   -----");
      var _loc2_ = _loc4_.timeTaken;
      trace("time start: " + _loc2_);
      var _loc10_ = getTimer();
      trace("time now: " + _loc10_);
      var _loc11_ = _loc15_.timeEntered;
      trace("time entered: " + _loc11_);
      var _loc23_ = _loc4_.cookTime;
      var _loc20_ = _loc19_.bakingScreen.cookTimeForPizza * 60 * 1000;
      var _loc26_ = _loc23_ / 8 * _loc20_;
      var _loc24_ = _loc4_.ordersAheadOfMe;
      var _loc27_ = _loc24_ * (_loc20_ / 2) / 4;
      var _loc21_ = _loc19_.prepTimePerOrder;
      trace("preptime: " + _loc21_);
      var _loc5_ = _loc4_.pauseCache;
      var _loc7_ = _loc15_.pauseCache;
      trace("orderpausetime: " + _loc5_);
      trace("waitpausetime: " + _loc7_);
      var _loc12_ = _loc10_ - _loc2_ - _loc5_;
      var _loc17_ = _loc26_ + _loc21_ + _loc27_;
      var _loc14_ = _loc2_ - _loc11_ - _loc7_;
      trace("waitlength = timenow - timestart - orderpausetime");
      trace(_loc12_ + " = " + _loc10_ + " - " + _loc2_ + " - " + _loc5_);
      trace("waitinline = timestart - timeentered - waitpausetime");
      trace(_loc14_ + " = " + _loc2_ + " - " + _loc11_ + " - " + _loc7_);
      var _loc9_ = _loc15_.idealLineWait;
      trace("idealwaitinline: " + _loc9_);
      var _loc8_ = _loc14_ - _loc9_;
      var _loc13_ = 0;
      var _loc28_ = 0.3;
      if(_loc8_ > 0)
      {
         _loc13_ = _loc8_ / 1000 * _loc28_;
      }
      trace("linepercentoff: " + _loc13_);
      var _loc6_ = _loc12_ - _loc17_;
      trace("timeoff: " + _loc6_);
      var _loc16_ = 0;
      var _loc25_ = 0.3;
      var _loc22_ = false;
      if(_loc6_ > 0)
      {
         _loc22_ = true;
         _loc16_ = _loc6_ / 1000 * _loc25_;
      }
      trace("percentoff: " + _loc16_);
      var _loc18_ = Math.max(0,Math.floor(100 - _loc16_ - _loc13_));
      trace(" ");
      trace("--  Ideal Wait Time (secs):  " + _loc17_ / 1000);
      trace("--  Order Wait Time (secs):  " + _loc12_ / 1000);
      trace("--  Order Pause Time (secs): " + _loc5_ / 1000);
      trace("--  Difference (secs):       " + _loc6_ / 1000);
      trace("--  Was the order late?:     " + _loc22_);
      trace("--");
      trace("--  Ideal Line Wait Time (secs):  " + _loc9_ / 1000);
      trace("--  Line Wait Time (secs):  " + _loc14_ / 1000);
      trace("--  Wait Pause Time (secs): " + _loc7_ / 1000);
      trace("--  Difference (secs):       " + _loc8_ / 1000);
      trace("--");
      trace("--  ACCURACY:                " + _loc18_);
      return _loc18_;
   }
   function checkToppingAccuracy()
   {
      var _loc17_ = this;
      var _loc15_ = _loc17_.currentPizza;
      var _loc30_ = _loc17_.currentTicket;
      var _loc14_ = _loc30_.orderData;
      var _loc10_ = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]];
      var _loc16_ = [];
      _loc16_ = _loc15_.toppings;
      var _loc20_ = 0;
      var _loc8_ = 0;
      while(_loc8_ < _loc16_.length)
      {
         var _loc3_ = _loc15_[_loc16_[_loc8_]];
         if(!(_loc3_ == 0 || _loc3_ == null || _loc3_ == undefined))
         {
            var _loc6_ = _loc3_.x;
            var _loc5_ = _loc3_.y;
            var _loc12_ = _loc3_.whichTopping;
            var _loc7_ = _loc12_ - 1;
            var _loc13_ = _loc14_[_loc7_];
            var _loc9_ = true;
            if(_loc13_[0] == 0)
            {
               _loc9_ = false;
            }
            if(_loc9_)
            {
               var _loc11_ = _loc15_.width;
               var _loc2_ = _loc11_ / 2;
               var _loc4_ = 0;
               if(_loc6_ > _loc2_ && _loc5_ < _loc2_)
               {
                  _loc4_ = 1;
               }
               else if(_loc6_ > _loc2_ && _loc5_ > _loc2_)
               {
                  _loc4_ = 2;
               }
               else if(_loc6_ < _loc2_ && _loc5_ > _loc2_)
               {
                  _loc4_ = 3;
               }
               else if(_loc6_ < _loc2_ && _loc5_ < _loc2_)
               {
                  _loc4_ = 4;
               }
               _loc10_[_loc7_][0] = _loc10_[_loc7_][0] + 1;
               _loc10_[_loc7_][_loc4_] = _loc10_[_loc7_][_loc4_] + 1;
            }
            else
            {
               _loc20_ = _loc20_ + 1;
            }
         }
         _loc8_ = _loc8_ + 1;
      }
      var _loc23_ = _loc17_.checkSingleToppingAccuracy(_loc14_[0],_loc10_[0],"pepperoni");
      var _loc26_ = _loc17_.checkSingleToppingAccuracy(_loc14_[1],_loc10_[1],"sausage");
      var _loc29_ = _loc17_.checkSingleToppingAccuracy(_loc14_[2],_loc10_[2],"mushroom");
      var _loc28_ = _loc17_.checkSingleToppingAccuracy(_loc14_[3],_loc10_[3],"peppers");
      var _loc25_ = _loc17_.checkSingleToppingAccuracy(_loc14_[4],_loc10_[4],"onions");
      var _loc27_ = _loc17_.checkSingleToppingAccuracy(_loc14_[5],_loc10_[5],"olives");
      var _loc22_ = _loc17_.checkSingleToppingAccuracy(_loc14_[6],_loc10_[6],"anchovies");
      var _loc18_ = 0;
      var _loc19_ = 0;
      if(!isNaN(_loc23_))
      {
         _loc18_ += _loc23_;
         _loc19_ += 100;
      }
      if(!isNaN(_loc26_))
      {
         _loc18_ += _loc26_;
         _loc19_ += 100;
      }
      if(!isNaN(_loc29_))
      {
         _loc18_ += _loc29_;
         _loc19_ += 100;
      }
      if(!isNaN(_loc28_))
      {
         _loc18_ += _loc28_;
         _loc19_ += 100;
      }
      if(!isNaN(_loc25_))
      {
         _loc18_ += _loc25_;
         _loc19_ += 100;
      }
      if(!isNaN(_loc27_))
      {
         _loc18_ += _loc27_;
         _loc19_ += 100;
      }
      if(!isNaN(_loc22_))
      {
         _loc18_ += _loc22_;
         _loc19_ += 100;
      }
      var _loc24_ = _loc18_ / _loc19_ * 100;
      var _loc31_ = _loc20_ * (0.2 * _loc24_);
      var _loc21_ = Math.max(0,Math.floor(_loc24_ - _loc31_));
      if(isNaN(_loc21_))
      {
         _loc21_ = 0;
      }
      return _loc21_;
   }
   function checkSingleToppingAccuracy(targetArray, currentArray, typename)
   {
      var _loc16_ = this;
      var _loc11_ = targetArray[0];
      var _loc13_ = currentArray[0];
      var _loc14_ = Math.abs(_loc11_ - _loc13_);
      var _loc9_ = 0;
      var _loc8_ = 0;
      var _loc2_ = 1;
      while(_loc2_ <= 4)
      {
         if(currentArray[_loc2_] > 0 && targetArray[_loc2_] == 1)
         {
            _loc9_ += currentArray[_loc2_];
         }
         else if(currentArray[_loc2_] > 0 && targetArray[_loc2_] == 0)
         {
            _loc8_ += currentArray[_loc2_];
         }
         _loc2_ = _loc2_ + 1;
      }
      var _loc15_ = targetArray[1] + targetArray[2] + targetArray[3] + targetArray[4];
      var _loc6_ = _loc11_ / _loc15_;
      var _loc7_ = 0;
      _loc2_ = 1;
      while(_loc2_ <= 4)
      {
         if(targetArray[_loc2_] == 1 && currentArray[_loc2_] != _loc6_)
         {
            var _loc5_ = Math.abs(currentArray[_loc2_] - _loc6_);
            _loc7_ += _loc5_;
         }
         _loc2_ = _loc2_ + 1;
      }
      var _loc12_ = undefined;
      if(_loc13_ >= _loc11_)
      {
         _loc12_ = 100 / _loc13_;
      }
      else if(_loc13_ < _loc11_)
      {
         _loc12_ = 100 / _loc11_;
      }
      var _loc10_ = 100;
      _loc10_ -= _loc14_ * _loc12_;
      _loc10_ -= _loc8_ * (_loc12_ / 2);
      _loc10_ -= _loc7_ * (_loc12_ / 4);
      _loc10_ = Math.max(0,_loc10_);
      return _loc10_;
   }
   function checkCuttingAccuracy()
   {
      var _loc32_ = this;
      var _loc26_ = _loc32_.currentPizza;
      var _loc36_ = _loc32_.currentTicket;
      var _loc42_ = _loc26_.cuttingClip;
      var _loc8_ = _loc42_.cutLines;
      var _loc30_ = _loc36_.cutNumber;
      var _loc23_ = _loc30_ / 2;
      var _loc39_ = _loc8_.length;
      var _loc33_ = Math.abs(_loc23_ - _loc39_);
      var _loc35_ = [0,90];
      var _loc34_ = [0,60,120];
      var _loc40_ = [0,45,90,135];
      var _loc24_ = undefined;
      if(_loc30_ == 4)
      {
         _loc24_ = _loc35_;
      }
      else if(_loc30_ == 6)
      {
         _loc24_ = _loc34_;
      }
      else if(_loc30_ == 8)
      {
         _loc24_ = _loc40_;
      }
      var _loc25_ = 0;
      var _loc28_ = 0;
      var _loc4_ = [];
      var _loc3_ = 0;
      while(_loc3_ < _loc8_.length)
      {
         _loc4_.push(_loc8_[_loc3_]);
         _loc3_ = _loc3_ + 1;
      }
      var _loc7_ = 0;
      while(_loc7_ < _loc24_.length)
      {
         var _loc5_ = _loc24_[_loc7_];
         var _loc6_ = 5000;
         var _loc12_ = undefined;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            var _loc21_ = _loc4_[_loc3_][0];
            var _loc19_ = _loc4_[_loc3_][1];
            var _loc20_ = _loc4_[_loc3_][2];
            var _loc17_ = _loc4_[_loc3_][3];
            var _loc16_ = _loc20_ - _loc21_;
            var _loc15_ = _loc17_ - _loc19_;
            var _loc22_ = Math.sqrt(_loc16_ * _loc16_ + _loc15_ * _loc15_);
            var _loc11_ = Math.atan2(_loc15_,_loc16_);
            var _loc2_ = _loc11_ * 57.29577951308232;
            if(_loc2_ < 0)
            {
               _loc2_ += 180;
            }
            _loc2_ += 90;
            if(_loc2_ > 180)
            {
               _loc2_ -= 180;
            }
            if(_loc2_ > 135 && _loc5_ == 0)
            {
               _loc2_ -= 180;
            }
            _loc2_ = Math.round(_loc2_);
            var _loc10_ = Math.abs(_loc6_ - _loc5_);
            var _loc9_ = Math.abs(_loc2_ - _loc5_);
            if(_loc9_ < _loc10_)
            {
               _loc6_ = _loc2_;
               _loc12_ = _loc3_;
            }
            _loc3_ = _loc3_ + 1;
         }
         if(_loc6_ == 5000)
         {
            _loc25_ += 45;
         }
         else
         {
            var _loc18_ = Math.abs(_loc6_ - _loc5_);
            _loc25_ += _loc18_;
            _loc28_ += 45;
            _loc4_.splice(_loc12_,1);
         }
         _loc7_ = _loc7_ + 1;
      }
      var _loc37_ = Math.max(0,(_loc28_ - _loc25_) / _loc28_ * 100);
      var _loc14_ = 0;
      var _loc29_ = 0;
      _loc7_ = 0;
      while(_loc7_ < _loc8_.length)
      {
         _loc21_ = _loc8_[_loc7_][0];
         _loc19_ = _loc8_[_loc7_][1];
         _loc20_ = _loc8_[_loc7_][2];
         _loc17_ = _loc8_[_loc7_][3];
         _loc16_ = _loc20_ - _loc21_;
         _loc15_ = _loc17_ - _loc19_;
         _loc22_ = Math.sqrt(_loc16_ * _loc16_ + _loc15_ * _loc15_);
         var _loc13_ = Math.max(0,(_loc22_ - _loc26_.width / 1.5) * 3 / _loc26_.width * 100);
         _loc13_ = Math.round(_loc13_);
         if(_loc14_ < _loc23_ * 100)
         {
            _loc29_ += _loc13_;
            _loc14_ += 100;
         }
         else if(_loc14_ >= _loc23_ * 100)
         {
            _loc14_ += 100;
         }
         _loc7_ = _loc7_ + 1;
      }
      if(_loc14_ < _loc23_ * 100)
      {
         _loc14_ = _loc23_ * 100;
      }
      var _loc41_ = Math.floor(_loc29_ / _loc14_ * 100);
      var _loc31_ = 100;
      var _loc38_ = 15;
      _loc31_ -= _loc33_ * _loc38_;
      _loc31_ = Math.max(0,_loc31_);
      var _loc27_ = (_loc41_ * 0.5 + _loc37_ * 0.5) * (_loc31_ / 100);
      _loc27_ = Math.floor(_loc27_) + 1;
      _loc27_ = Math.min(100,_loc27_);
      _loc27_ = Math.max(0,Math.floor(_loc27_));
      if(isNaN(_loc27_))
      {
         _loc27_ = 0;
      }
      if(_loc33_ == _loc23_)
      {
         _loc27_ = 0;
      }
      return _loc27_;
   }
   function lookAtPizza()
   {
      var _loc2_ = this;
      _loc2_.currentCustomer.giveorder_clip.gotoAndPlay("look");
      _loc2_.clip.giveorder_fg.accuracyclip.gotoAndPlay(2);
      clearInterval(_loc2_.cycleInterval);
      _loc2_.cycleInterval = setInterval(this,"reactToPizza",_loc2_.reactSpeed);
      _loc2_.whichInterval = "reactToPizza";
      _loc2_.lastIntervalTime = getTimer();
   }
   function reactToPizza()
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.gameObj;
      var _loc7_ = _loc2_.customerReaction;
      _loc2_.currentCustomer.giveorder_clip.gotoAndPlay(_loc7_);
      if(_loc2_.earnStarNumber > 0)
      {
         _loc2_.clip.giveorder_fg.stars["star" + _loc2_.earnStarNumber].gotoAndStop(3);
         _loc4_.soundEngine.playSound("getstar.wav",0,1);
         _loc4_.customerdata[_loc2_.currentCustomer.customertype][5] = _loc2_.earnStarNumber;
         var _loc5_ = _loc4_.customerdata[_loc2_.currentCustomer.customertype][6];
         if(_loc2_.earnStarNumber == 5 && _loc5_ < 3)
         {
            var _loc6_ = _loc5_ + 1;
            _loc4_.customerdata[_loc2_.currentCustomer.customertype][6] = _loc6_;
            _loc4_.customerdata[_loc2_.currentCustomer.customertype][5] = 0;
            _loc2_.clip.giveorder_fg.stars.fireworks.gotoAndPlay(2);
            _loc2_.clip.giveorder_fg.stars.award.seal.gotoAndStop(_loc6_);
            _loc2_.clip.giveorder_fg.stars.award.gotoAndPlay(2);
         }
         else if(_loc2_.earnStarNumber == 5 && _loc5_ == 3)
         {
            _loc4_.customerdata[_loc2_.currentCustomer.customertype][5] = 0;
            _loc2_.clip.giveorder_fg.stars.fireworks.gotoAndPlay(2);
         }
      }
      else if(_loc2_.loseStarNumber > 0)
      {
         var _loc3_ = 1;
         while(_loc3_ <= _loc2_.loseStarNumber)
         {
            _loc2_.clip.giveorder_fg.stars["star" + _loc3_].gotoAndStop(4);
            _loc3_ = _loc3_ + 1;
         }
         _loc4_.soundEngine.playSound("grabtopping.wav",0,1);
         _loc4_.customerdata[_loc2_.currentCustomer.customertype][5] = 0;
      }
      var _loc8_ = "customer_" + _loc7_ + ".wav";
      _loc4_.soundEngine.playSound(_loc8_,0,2);
      clearInterval(_loc2_.cycleInterval);
      _loc2_.cycleInterval = setInterval(this,"depositTip",_loc2_.tipSpeed);
      _loc2_.whichInterval = "depositTip";
      _loc2_.lastIntervalTime = getTimer();
   }
   function depositTip()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.clip.giveorder_fg.tipjar.clip.starburst.burst.money.text = _loc2_.currentTipText;
      _loc2_.clip.giveorder_fg.tips.gotoAndStop(_loc2_.coinFrame);
      _loc2_.clip.giveorder_fg.tipjar.clip.play();
      _loc2_.clip.giveorder_fg.tipjar.clip.starburst.play();
      clearInterval(_loc2_.cycleInterval);
      _loc2_.cycleInterval = setInterval(this,"returnToCutting",_loc2_.returnSpeed);
      _loc2_.whichInterval = "returnToCutting";
      _loc2_.lastIntervalTime = getTimer();
      if(_loc2_.coinFrame > 1)
      {
         if(_loc2_.coinFrame < 4)
         {
            _loc3_.soundEngine.playSound("singlecoin.wav");
         }
         else
         {
            _loc3_.soundEngine.playSound("multicoin.wav");
         }
      }
   }
   function adjustJarCoins()
   {
      var _loc3_ = this;
      var _loc6_ = _loc3_.gameObj;
      var _loc5_ = _loc6_.tipsToday;
      var _loc7_ = 3000;
      var _loc4_ = _loc5_ / _loc7_;
      if(_loc4_ > 1)
      {
         _loc4_ = 1;
      }
      var _loc2_ = Math.ceil(_loc4_ * 10);
      if(_loc2_ < 2 && _loc5_ > 0)
      {
         _loc2_ = 2;
      }
      else if(_loc2_ > 10)
      {
         _loc2_ = 10;
      }
      _loc3_.coinJarFrame = _loc2_;
      _loc3_.clip.giveorder_fg.tipjar.clip.tipclip.coins.gotoAndStop(_loc2_);
   }
   function endOfDay()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      clearInterval(_loc2_.cycleInterval);
      _loc3_.switchModes("endofday","allow");
      _loc2_.whichInterval = "done";
      _loc2_.lastIntervalTime = getTimer();
   }
   function returnToCutting()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      clearInterval(_loc2_.cycleInterval);
      _loc2_.pizzaWasGiven();
      if(_loc3_.dayIsOver)
      {
         _loc2_.clip.giveorder_fg.roy.gotoAndPlay("endofday");
         _loc3_.soundEngine.playSound("endofday.wav",0,2);
         clearInterval(_loc2_.cycleInterval);
         _loc2_.cycleInterval = setInterval(this,"endOfDay",_loc2_.endSpeed);
         _loc2_.whichInterval = "endOfDay";
         _loc2_.lastIntervalTime = getTimer();
      }
      else
      {
         _loc3_.switchModes("cutting","allow");
         _loc2_.whichInterval = "done";
         _loc2_.lastIntervalTime = getTimer();
      }
   }
   function pizzaWasGiven()
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_.gameObj;
      var _loc6_ = _loc2_.cuttingScreen;
      var _loc4_ = _loc3_.currentTicket.whichPizza;
      _loc2_.customerManager.deleteCustomer(_loc3_.currentCustomer);
      _loc2_.ticketManager.deleteTicket(_loc3_.currentTicket);
      _loc2_.pizzaManager.deletePizza(_loc3_.currentPizza);
      if(_loc4_ > 0)
      {
         var _loc5_ = _loc2_.pizzaManager["pizza" + _loc4_];
         _loc2_.pizzaManager.deletePizza(_loc5_);
      }
      _loc2_.cuttingScreen.pizzas.shift();
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
      _loc2_.takeOrderScreen.setNotCurrentMode();
      _loc2_.pauseScreen.setNotCurrentMode();
      _loc2_.soundEngine.switchMusic(0);
      _loc2_.hudObj.setMode("giveorder");
      if(!_loc3_.orderInProcess)
      {
         _loc3_.presentPizza();
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
      var _loc7_ = _loc2_.gameObj;
      if(msg == "pause")
      {
         if(_loc2_.whichInterval != "done")
         {
            _loc2_.lastPauseOffset = getTimer() - _loc2_.lastIntervalTime;
            clearInterval(_loc2_.cycleInterval);
         }
      }
      else if(msg == "unpause")
      {
         if(_loc2_.whichInterval != "done")
         {
            var _loc5_ = _loc2_.lastPauseOffset;
            var _loc4_ = undefined;
            if(_loc2_.whichInterval == "lookAtPizza")
            {
               _loc4_ = _loc2_.lookSpeed;
            }
            else if(_loc2_.whichInterval == "reactToPizza")
            {
               _loc4_ = _loc2_.reactSpeed;
            }
            else if(_loc2_.whichInterval == "depositTip")
            {
               _loc4_ = _loc2_.tipSpeed;
            }
            else if(_loc2_.whichInterval == "returnToCutting")
            {
               _loc4_ = _loc2_.returnSpeed;
            }
            else if(_loc2_.whichInterval == "endOfDay")
            {
               _loc4_ = _loc2_.endSpeed;
            }
            var _loc3_ = _loc4_ - _loc5_;
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
            if(_loc2_.whichInterval == "lookAtPizza")
            {
               _loc2_.cycleInterval = setInterval(this,"lookAtPizza",_loc3_);
            }
            else if(_loc2_.whichInterval == "reactToPizza")
            {
               _loc2_.cycleInterval = setInterval(this,"reactToPizza",_loc3_);
            }
            else if(_loc2_.whichInterval == "depositTip")
            {
               _loc2_.cycleInterval = setInterval(this,"depositTip",_loc3_);
            }
            else if(_loc2_.whichInterval == "returnToCutting")
            {
               _loc2_.cycleInterval = setInterval(this,"returnToCutting",_loc3_);
            }
            else if(_loc2_.whichInterval == "endOfDay")
            {
               _loc2_.cycleInterval = setInterval(this,"endOfDay",_loc3_);
            }
         }
      }
   }
}
