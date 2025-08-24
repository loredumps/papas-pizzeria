class roygame.models.Customer
{
   var gameObj;
   var clipname = "customer";
   var customertype = 1;
   var customername = "Customer!";
   var maxTip = 300;
   var extraTipPerBadge = 100;
   var idealLineWait = 25000;
   var takeorder_x = 270;
   var takeorder_y = 101;
   var giveorder_x = 230;
   var giveorder_y = 101;
   var cycleSpeed = 33;
   var orderline_x = 110;
   var orderline_y = 208;
   var orderline_width = 91;
   var orderline_height = 197;
   var orderline_offset = 86;
   var orderline_sizepercent = 0.6;
   var orderline_offscreen_x = 450;
   var leaveline_x = 274;
   var leaveline_y = 145;
   var leaveline_width = 91;
   var leaveline_height = 197;
   var leaveline_offscreen_x = 550;
   var leaveline_sizepercent = 0.6;
   var waitline_x = 207;
   var waitline_y = 97;
   var waitline_width = 75;
   var waitline_height = 162;
   var waitline_offset = 66;
   var waitline_sizepercent = 0.5;
   var orderIsPlaced = false;
   var isWalking = false;
   var isDrawn = false;
   var walkspeed = 4;
   var lastPauseStart = 0;
   var pauseCache = 0;
   var orders = [[],[[[0],[0],[0],[0],[0],[2,0,0,1,0],[0],2,4]]];
   var difficulty = 1;
   function Customer(gameobj, num)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.number = num;
      _loc2_.setupCustomer();
      _loc2_.startCustomerEntering();
   }
   function setupCustomer()
   {
      var _loc2_ = this;
      _loc2_.gameObj.pauseManager.addPauseListener(this);
      _loc2_.timeEntered = getTimer();
      _loc2_.difficulty = 1;
      _loc2_.currentOrder = 0;
   }
   function shortenWaitTime()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.difficulty;
      var _loc4_ = _loc2_.currentOrder;
      _loc2_.orders[_loc3_][_loc4_][7] = 1;
   }
   function drawCustomerOrdering()
   {
      var customer = this;
      var _loc2_ = customer.gameObj.takeOrderScreen;
      customer.instancename = customer.clipname + "_" + customer.number;
      customer.takeorder_clip = _loc2_.clip.attachMovie(customer.clipname,customer.instancename,5);
      customer.drawBodyParts(customer.takeorder_clip);
      customer.takeorder_clip._x = customer.takeorder_x;
      customer.takeorder_clip._y = customer.takeorder_y;
      customer.takeorder_clip.gotoAndStop("stand");
      customer.takeorder_clip.number.text = "" + customer.number;
      customer.takeorder_clip.onRollOver = function()
      {
         customer.gameObj.hudObj.setTooltip(customer.customername,true);
      };
      customer.takeorder_clip.onRollOut = function()
      {
         customer.gameObj.hudObj.setLastTooltip();
      };
      customer.takeorder_clip.useHandCursor = false;
      _loc2_.gameObj.customerdata[customer.customertype][4] = _loc2_.gameObj.customerdata[customer.customertype][4] + 1;
   }
   function drawCustomerPresenting()
   {
      var customer = this;
      var _loc2_ = customer.gameObj.giveOrderScreen;
      customer.instancename = customer.clipname + "_" + customer.number;
      customer.giveorder_clip = _loc2_.clip.attachMovie(customer.clipname,customer.instancename,5);
      customer.drawBodyParts(customer.giveorder_clip);
      customer.giveorder_clip._x = customer.giveorder_x;
      customer.giveorder_clip._y = customer.giveorder_y;
      customer.giveorder_clip.gotoAndStop("stand");
      customer.giveorder_clip.onRollOver = function()
      {
         customer.gameObj.hudObj.setTooltip(customer.customername,true);
      };
      customer.giveorder_clip.onRollOut = function()
      {
         customer.gameObj.hudObj.setLastTooltip();
      };
      customer.giveorder_clip.useHandCursor = false;
   }
   function drawBodyParts(clip)
   {
      var _loc4_ = this;
      var _loc2_ = _loc4_.customertype;
      clip.body.attachMovie("customer" + _loc2_ + "_body","clip",1);
      clip.head.attachMovie("customer" + _loc2_ + "_head","clip",1);
      clip.eyes.attachMovie("customer" + _loc2_ + "_eyes","clip",1);
      clip.mouth.attachMovie("customer" + _loc2_ + "_mouth","clip",1);
      clip.neck.attachMovie("customer" + _loc2_ + "_neck","clip",1);
      clip.hair.attachMovie("customer" + _loc2_ + "_hair","clip",1);
      clip.back_hair.attachMovie("customer" + _loc2_ + "_back_hair","clip",1);
      clip.front_shoe.attachMovie("customer" + _loc2_ + "_foot","clip",1);
      clip.back_shoe.attachMovie("customer" + _loc2_ + "_foot","clip",1);
      clip.fronthand.attachMovie("customer" + _loc2_ + "_hand","clip",1);
      clip.backhand.attachMovie("customer" + _loc2_ + "_hand2","clip",1);
      clip.front_upperarm.attachMovie("customer" + _loc2_ + "_upperarm","clip",1);
      clip.back_upperarm.attachMovie("customer" + _loc2_ + "_upperarm","clip",1);
      clip.front_forearm.attachMovie("customer" + _loc2_ + "_forearm","clip",1);
      clip.back_forearm.attachMovie("customer" + _loc2_ + "_forearm","clip",1);
   }
   function drawCustomer()
   {
      var customer = this;
      var _loc2_ = customer.gameObj.orderScreen;
      customer.instancename = customer.clipname + "_" + customer.number;
      var _loc3_ = 300 + customer.number;
      customer.clip = _loc2_.clip.attachMovie(customer.clipname,customer.instancename,_loc3_);
      customer.clip.myclass = customer;
      customer.drawBodyParts(customer.clip);
      customer.base_width = customer.clip._width;
      customer.base_height = customer.clip._height;
      customer.orderline_width = Math.floor(customer.base_width * customer.orderline_sizepercent);
      customer.orderline_height = Math.floor(customer.base_height * customer.orderline_sizepercent);
      customer.waitline_width = Math.floor(customer.base_width * customer.waitline_sizepercent);
      customer.waitline_height = Math.floor(customer.base_height * customer.waitline_sizepercent);
      customer.leaveline_width = Math.floor(customer.base_width * customer.leaveline_sizepercent);
      customer.leaveline_height = Math.floor(customer.base_height * customer.leaveline_sizepercent);
      customer.clip._x = customer.x;
      customer.clip._y = customer.y;
      if(customer.currentLine == "orderline")
      {
         customer.clip._width = customer.orderline_width;
         customer.clip._height = customer.orderline_height;
         customer.clip._xscale = Math.abs(customer.clip._xscale);
      }
      else if(customer.currentLine == "leaveline")
      {
         customer.clip._width = customer.leaveline_width;
         customer.clip._height = customer.leaveline_height;
         customer.clip._xscale = Math.abs(customer.clip._xscale) * -1;
      }
      else if(customer.currentLine == "waitline")
      {
         customer.clip._width = customer.waitline_width;
         customer.clip._height = customer.waitline_height;
         customer.clip._xscale = Math.abs(customer.clip._xscale);
      }
      if(customer.isWalking)
      {
         customer.clip.gotoAndPlay("walk");
      }
      else
      {
         customer.clip.gotoAndPlay("stand");
      }
      customer.isDrawn = true;
      customer.clip.onRollOver = function()
      {
         customer.gameObj.hudObj.setTooltip(customer.customername,true);
      };
      customer.clip.onRollOut = function()
      {
         customer.gameObj.hudObj.setLastTooltip();
      };
      customer.clip.useHandCursor = false;
   }
   function undrawCustomer()
   {
      var _loc2_ = this;
      _loc2_.clip.removeMovieClip();
      _loc2_.isDrawn = false;
   }
   function updateCustomerClip()
   {
      var _loc2_ = this;
      _loc2_.clip._x = _loc2_.x;
      _loc2_.clip._y = _loc2_.y;
   }
   function startCustomerEntering()
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.gameObj.orderScreen;
      var _loc3_ = _loc2_.gameObj.customerManager.orderline.length;
      var _loc5_ = _loc3_ + 1;
      _loc2_.x = _loc2_.orderline_offscreen_x;
      _loc2_.y = _loc2_.orderline_y;
      _loc2_.targetx = _loc2_.orderline_x + _loc3_ * _loc2_.orderline_offset;
      _loc2_.walkdir = -1;
      _loc2_.clip.gotoAndPlay("walk");
      _loc2_.currentLine = "orderline";
      _loc2_.gameObj.customerManager.orderline.push(_loc2_);
      clearInterval(_loc2_.cycleInterval);
      _loc2_.cycleInterval = setInterval(this,"walkCustomer",_loc2_.cycleSpeed);
      if(this.gameObj.customerdata[_loc2_.customertype][3] == 0)
      {
         this.gameObj.customerdata[_loc2_.customertype][3] = _loc2_.gameObj.currentDay;
      }
   }
   function moveCustomerOrderDone()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj.orderScreen;
      _loc2_.x = _loc2_.leaveline_x;
      _loc2_.y = _loc2_.leaveline_y;
      _loc2_.clip._width = _loc2_.leaveline_width;
      _loc2_.clip._height = _loc2_.leaveline_height;
      _loc2_.clip._xscale = Math.abs(_loc2_.clip._xscale) * -1;
      _loc2_.clip.body.clip.logo.gotoAndStop(2);
      _loc2_.targetx = _loc2_.leaveline_offscreen_x;
      _loc2_.walkdir = 1;
      _loc2_.clip.gotoAndPlay("walk");
      _loc2_.currentLine = "leaveline";
      _loc2_.gameObj.customerManager.orderline.shift();
      _loc2_.tellOthersToShift();
      clearInterval(_loc2_.cycleInterval);
      _loc2_.cycleInterval = setInterval(this,"walkCustomer",_loc2_.cycleSpeed);
   }
   function moveCustomerWaitLine()
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.gameObj.orderScreen;
      var _loc3_ = _loc2_.gameObj.customerManager.waitline.length;
      _loc2_.clip._width = _loc2_.waitline_width;
      _loc2_.clip._height = _loc2_.waitline_height;
      _loc2_.clip._xscale = Math.abs(_loc2_.clip._xscale);
      _loc2_.clip.body.clip.logo.gotoAndStop(1);
      _loc2_.x = _loc2_.orderline_offscreen_x;
      _loc2_.y = _loc2_.waitline_y;
      _loc2_.targetx = _loc2_.waitline_x + _loc3_ * _loc2_.waitline_offset;
      _loc2_.walkdir = -1;
      _loc2_.clip.gotoAndPlay("walk");
      _loc2_.currentLine = "waitline";
      _loc2_.gameObj.customerManager.waitline.push(_loc2_);
      clearInterval(_loc2_.cycleInterval);
      _loc2_.cycleInterval = setInterval(this,"walkCustomer",_loc2_.cycleSpeed);
   }
   function tellOthersToShift()
   {
      var _loc5_ = this;
      var _loc8_ = _loc5_.gameObj;
      var _loc6_ = _loc8_.customerManager;
      var _loc9_ = _loc8_.orderScreen;
      var _loc7_ = _loc6_.orderline.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc7_)
      {
         var _loc3_ = _loc6_.orderline[_loc2_];
         var _loc4_ = _loc5_.orderline_x + _loc2_ * _loc5_.orderline_offset;
         _loc3_.shiftOrderLine(_loc4_);
         _loc2_ = _loc2_ + 1;
      }
      _loc8_.hudObj.setActiveTicket(_loc8_.hudObj.activeTicket);
   }
   function shiftOrderLine(newtarget)
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      var _loc4_ = _loc3_.customerManager;
      var _loc5_ = _loc3_.orderScreen;
      var _loc6_ = _loc4_.orderline.length;
      _loc2_.targetx = newtarget;
      if(!_loc2_.isWalking)
      {
         _loc2_.x = _loc2_.targetx;
         _loc2_.clip._x = _loc2_.x;
         if(_loc2_.x < 450 && !_loc2_.isDrawn)
         {
            _loc2_.drawCustomer();
         }
      }
   }
   function shiftWaitLine(newtarget)
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      var _loc4_ = _loc3_.customerManager;
      var _loc5_ = _loc3_.orderScreen;
      var _loc6_ = _loc4_.waitline.length;
      _loc2_.targetx = newtarget;
      if(!_loc2_.isWalking)
      {
         _loc2_.x = _loc2_.targetx;
         _loc2_.clip._x = _loc2_.x;
         if(_loc2_.x < 450 && !_loc2_.isDrawn)
         {
            _loc2_.drawCustomer();
         }
      }
   }
   function walkCustomer()
   {
      var _loc2_ = this;
      var _loc6_ = _loc2_.gameObj;
      var _loc7_ = _loc2_.x;
      var _loc4_ = _loc2_.targetx;
      var _loc5_ = _loc2_.walkspeed;
      var _loc3_ = _loc2_.walkdir;
      if(!_loc6_.pauseManager.isPaused)
      {
         if(_loc3_ == -1 && _loc7_ + _loc3_ * _loc5_ <= _loc4_)
         {
            trace("He\'s there, stop walk animation");
            _loc2_.x = _loc4_;
            _loc2_.clip.gotoAndPlay("stand");
            _loc2_.isWalking = false;
            if(_loc2_.currentLine == "orderline")
            {
               _loc6_.hudObj.setActiveTicket(_loc6_.hudObj.activeTicket);
            }
            clearInterval(_loc2_.cycleInterval);
         }
         else if(_loc3_ == 1 && _loc7_ + _loc3_ * _loc5_ >= _loc4_)
         {
            trace("He\'s there, stop walk animation");
            _loc2_.x = _loc4_;
            _loc2_.clip.gotoAndPlay("stand");
            if(_loc2_.currentLine == "leaveline")
            {
               _loc2_.moveCustomerWaitLine();
            }
            else
            {
               _loc2_.isWalking = false;
               clearInterval(_loc2_.cycleInterval);
            }
         }
         else
         {
            _loc2_.isWalking = true;
            _loc2_.x += _loc3_ * _loc5_;
            _loc2_.clip._x = _loc2_.x;
         }
         if(_loc3_ == -1 && _loc2_.x < 450 || _loc3_ == 1 && _loc2_.x < 550)
         {
            if(!_loc2_.isDrawn)
            {
               _loc2_.drawCustomer();
            }
            else
            {
               _loc2_.updateCustomerClip();
            }
         }
         else if(_loc2_.isDrawn)
         {
            _loc2_.undrawCustomer();
         }
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
         if(_loc2_.currentLine == "orderline")
         {
            _loc2_.pauseCache += _loc3_;
         }
      }
   }
}
