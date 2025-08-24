class roygame.models.CustomerManager
{
   var totalCustomers = 0;
   var customers = [];
   var orderline = [];
   var waitline = [];
   var numberOfCustomers = [4,4,5,5,6,7,7,8,8,9,10];
   var customerLineup = [];
   var customerDifficulty = 1;
   var lastSpawnTime = 0;
   var lastPauseOffset = 0;
   function CustomerManager(gameobj)
   {
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.totalCustomers = 0;
      _loc3_.customers = [];
      _loc3_.orderline = [];
      _loc3_.waitline = [];
      _loc3_.customerLineup = [];
      if(_loc3_.gameObj.training)
      {
         _loc3_.trainingLineup();
      }
      else
      {
         _loc3_.decideLineup();
      }
      _loc3_.gameObj.pauseManager.addPauseListener(_loc3_);
   }
   function trainingLineup()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.customerLineup = [1,5];
   }
   function decideLineup()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      var _loc4_ = _loc3_.myRank;
      var _loc5_ = _loc4_;
      if(_loc5_ >= _loc2_.numberOfCustomers.length)
      {
         _loc5_ = _loc2_.numberOfCustomers.length - 1;
      }
      var _loc6_ = _loc2_.numberOfCustomers[_loc5_];
      var _loc7_ = 6;
      var _loc8_ = 35;
      _loc7_ += _loc4_ - 1;
      if(_loc7_ > _loc8_)
      {
         _loc7_ = _loc8_;
      }
      if(_loc4_ >= 31)
      {
         var _loc9_ = 0;
         var _loc10_ = 1;
         while(_loc10_ <= _loc8_)
         {
            _loc9_ += _loc3_.customerdata[_loc10_][6];
            _loc10_ += 1;
         }
         if(_loc9_ == _loc8_ * 3)
         {
            trace("UNLOCK PAPA!!");
            _loc7_ += 1;
            _loc3_.showNoPapa = false;
         }
         else
         {
            trace("No papa....");
            _loc3_.showNoPapa = true;
         }
      }
      else
      {
         _loc3_.showNoPapa = false;
      }
      var _loc11_ = [];
      _loc10_ = 1;
      while(_loc10_ <= _loc7_)
      {
         _loc11_.push(_loc10_);
         _loc10_ += 1;
      }
      _loc2_.customerLineup = [];
      var _loc12_ = 0;
      if(_loc4_ >= 2)
      {
         _loc2_.customerLineup.push(_loc7_);
         _loc11_.splice(_loc7_ - 1,1);
         _loc12_ = 1;
         var _loc13_ = _loc3_.customerdata[_loc7_][0];
         if(_loc13_ == 0)
         {
            trace("NEW CUSTOMER! ---> " + _loc7_ + ": " + _loc3_.customerdata[_loc7_][1]);
            _loc3_.showNewCustomer = true;
            _loc3_.newCustomerNum = _loc7_;
         }
         else
         {
            trace("Already earned this customer... " + _loc7_ + ": " + _loc3_.customerdata[_loc7_][1]);
            _loc3_.showNewCustomer = false;
         }
      }
      _loc10_ = _loc12_;
      while(_loc10_ < _loc6_)
      {
         var _loc14_ = _loc11_.length;
         var _loc15_ = random(_loc14_);
         var _loc16_ = _loc11_[_loc15_];
         _loc2_.customerLineup.push(_loc16_);
         _loc11_.splice(_loc15_,1);
         _loc10_ += 1;
      }
      var _loc17_ = 25;
      var _loc18_ = _loc4_ / _loc17_;
      if(_loc18_ > 1)
      {
         _loc18_ = 1;
      }
      var _loc19_ = Math.floor(_loc18_ * 10);
      if(_loc19_ < 1)
      {
         _loc19_ = 1;
      }
      _loc2_.customerDifficulty = _loc19_;
      trace("Chosen Customers: " + _loc2_.customerLineup);
   }
   function setupSpawn()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.totalTime = _loc3_.timePerDay;
      var _loc4_ = _loc2_.customerLineup.length;
      _loc2_.spawnSpeed = Math.floor(_loc2_.totalTime / (_loc4_ - 1));
      _loc2_.spawnCustomer();
   }
   function spawnCustomer()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      var _loc4_ = _loc2_.totalCustomers;
      if(_loc4_ < _loc2_.customerLineup.length)
      {
         var _loc5_ = _loc2_.customerLineup[_loc4_];
         var _loc6_ = false;
         if(_loc4_ == _loc2_.customerLineup.length - 1)
         {
            _loc3_.orderScreen.clip.signlayer.mainsign.sign.play();
            _loc6_ = true;
         }
         _loc2_.addCustomer(_loc5_,_loc6_);
         _loc2_.lastSpawnTime = getTimer();
         clearInterval(_loc2_.spawnInterval);
         _loc2_.spawnInterval = setInterval(this,"spawnCustomer",_loc2_.spawnSpeed);
      }
      else
      {
         trace("stop spawning.");
         clearInterval(_loc2_.spawnInterval);
      }
   }
   function addCustomer(which, last)
   {
      var _loc4_ = this;
      var _loc5_ = _loc4_.gameObj;
      _loc4_.totalCustomers += 1;
      var _loc6_ = _loc4_.totalCustomers;
      var _loc7_ = "Customer" + _loc6_;
      if(which == 1)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer1(_loc5_,_loc6_);
      }
      else if(which == 2)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer2(_loc5_,_loc6_);
      }
      else if(which == 3)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer3(_loc5_,_loc6_);
      }
      else if(which == 4)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer4(_loc5_,_loc6_);
      }
      else if(which == 5)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer5(_loc5_,_loc6_);
      }
      else if(which == 6)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer6(_loc5_,_loc6_);
      }
      else if(which == 7)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer7(_loc5_,_loc6_);
      }
      else if(which == 8)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer8(_loc5_,_loc6_);
      }
      else if(which == 9)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer9(_loc5_,_loc6_);
      }
      else if(which == 10)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer10(_loc5_,_loc6_);
      }
      else if(which == 11)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer11(_loc5_,_loc6_);
      }
      else if(which == 12)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer12(_loc5_,_loc6_);
      }
      else if(which == 13)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer13(_loc5_,_loc6_);
      }
      else if(which == 14)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer14(_loc5_,_loc6_);
      }
      else if(which == 15)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer15(_loc5_,_loc6_);
      }
      else if(which == 16)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer16(_loc5_,_loc6_);
      }
      else if(which == 17)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer17(_loc5_,_loc6_);
      }
      else if(which == 18)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer18(_loc5_,_loc6_);
      }
      else if(which == 19)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer19(_loc5_,_loc6_);
      }
      else if(which == 20)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer20(_loc5_,_loc6_);
      }
      else if(which == 21)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer21(_loc5_,_loc6_);
      }
      else if(which == 22)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer22(_loc5_,_loc6_);
      }
      else if(which == 23)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer23(_loc5_,_loc6_);
      }
      else if(which == 24)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer24(_loc5_,_loc6_);
      }
      else if(which == 25)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer25(_loc5_,_loc6_);
      }
      else if(which == 26)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer26(_loc5_,_loc6_);
      }
      else if(which == 27)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer27(_loc5_,_loc6_);
      }
      else if(which == 28)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer28(_loc5_,_loc6_);
      }
      else if(which == 29)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer29(_loc5_,_loc6_);
      }
      else if(which == 30)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer30(_loc5_,_loc6_);
      }
      else if(which == 31)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer31(_loc5_,_loc6_);
      }
      else if(which == 32)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer32(_loc5_,_loc6_);
      }
      else if(which == 33)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer33(_loc5_,_loc6_);
      }
      else if(which == 34)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer34(_loc5_,_loc6_);
      }
      else if(which == 35)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer35(_loc5_,_loc6_);
      }
      else if(which == 36)
      {
         _loc4_[_loc7_] = new roygame.models.customers.Customer36(_loc5_,_loc6_);
      }
      if(last)
      {
         _loc4_[_loc7_].shortenWaitTime();
      }
   }
   function deleteCustomer(whichcustomer)
   {
      var _loc3_ = this;
      var _loc4_ = _loc3_.gameObj;
      var _loc5_ = whichcustomer;
      var _loc6_ = _loc5_.number;
      var _loc7_ = "Customer" + _loc6_;
      var _loc8_ = 999999;
      var _loc9_ = 0;
      while(_loc9_ < _loc3_.waitline.length)
      {
         if(_loc3_.waitline[_loc9_] == _loc5_)
         {
            _loc8_ = _loc9_;
         }
         _loc9_ += 1;
      }
      if(_loc8_ != 999999)
      {
         _loc3_.waitline.splice(_loc8_,1);
      }
      _loc9_ = _loc8_;
      while(_loc9_ < _loc3_.waitline.length)
      {
         var _loc10_ = _loc3_.waitline[_loc9_];
         var _loc11_ = _loc10_.waitline_x + _loc9_ * _loc10_.waitline_offset;
         _loc10_.shiftWaitLine(_loc11_);
         _loc9_ += 1;
      }
      _loc4_.pauseManager.removePauseListener(_loc5_);
      _loc5_.clip.removeMovieClip();
      delete _loc3_[_loc7_];
      _loc3_[_loc7_] = null;
      if(_loc3_.waitline.length == 0 && _loc3_.orderline.length == 0)
      {
         if(_loc3_.totalCustomers == _loc3_.customerLineup.length)
         {
            _loc4_.dayIsOver = true;
         }
      }
   }
   function pauseUpdate(msg)
   {
      var _loc3_ = this;
      var _loc4_ = _loc3_.gameObj;
      if(!_loc4_.training)
      {
         if(msg == "pause")
         {
            _loc3_.lastPauseOffset = getTimer() - _loc3_.lastSpawnTime;
            clearInterval(_loc3_.spawnInterval);
         }
         else if(msg == "unpause")
         {
            var _loc5_ = _loc3_.lastPauseOffset;
            var _loc6_ = _loc3_.spawnSpeed - _loc5_;
            if(_loc6_ < 0)
            {
               _loc6_ = _loc3_.spawnSpeed;
            }
            else if(_loc6_ > _loc3_.spawnSpeed)
            {
               _loc6_ = _loc3_.spawnSpeed;
            }
            else
            {
               _loc3_.lastSpawnTime = getTimer() - _loc3_.lastPauseOffset;
            }
            _loc3_.spawnInterval = setInterval(this,"spawnCustomer",_loc6_);
         }
      }
   }
}
