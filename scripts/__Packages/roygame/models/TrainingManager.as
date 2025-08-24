class roygame.models.TrainingManager
{
   var currentStep = 1;
   var switchToMode = "none";
   var canDragTicket = false;
   var cycleDelay = 600;
   function TrainingManager(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.setupTraining();
   }
   function setupTraining()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.clip = _loc3_.hudObj.clip.attachMovie("hud_navi","hud_navi",1000000);
      _loc2_.finishedStep(0);
      _loc2_.gameObj.pauseManager.addPauseListener(this);
   }
   function trainTrigger(which)
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.gameObj;
      var _loc5_ = _loc4_.hudObj;
      _loc2_.currentStep = which;
      _loc2_.clip.gotoAndStop(which);
      if(which == 1)
      {
         _loc2_.switchToMode = "topping";
      }
      else if(which == 2)
      {
         _loc2_.switchToMode = "baking";
      }
      else if(which == 3)
      {
         _loc2_.switchToMode = "cutting";
      }
      else if(which == 4)
      {
         _loc2_.switchToMode = "order";
      }
      else if(which == 9)
      {
         _loc2_.switchToMode = "topping";
      }
      else if(which == 24)
      {
         _loc2_.switchToMode = "order";
      }
      else
      {
         _loc2_.switchToMode = "none";
      }
      if(which == 5)
      {
         _loc4_.customerManager.spawnCustomer();
      }
      else if(which == 25)
      {
         _loc4_.customerManager.spawnCustomer();
         _loc4_.endTraining();
      }
      if(which == 8 || which == 10 || which == 16 || which == 17)
      {
         _loc2_.canDragTicket = true;
      }
      else
      {
         _loc2_.canDragTicket = false;
      }
      clearInterval(_loc2_.cycleInterval);
   }
   function switchedMode(which)
   {
      var _loc2_ = this;
      var _loc5_ = _loc2_.gameObj;
      var _loc6_ = _loc5_.hudObj;
      var _loc3_ = _loc2_.currentStep;
      if(which == "topping" && _loc3_ == 1)
      {
         _loc2_.finishedStep(1);
      }
      else if(which == "baking" && _loc3_ == 2)
      {
         _loc2_.finishedStep(2);
      }
      else if(which == "cutting" && _loc3_ == 3)
      {
         _loc2_.finishedStep(3);
      }
      else if(which == "order" && _loc3_ == 4)
      {
         _loc2_.finishedStep(4);
      }
      else if(which == "takeOrder" && _loc3_ == 6)
      {
         _loc2_.finishedStep(6);
      }
      else if(which == "topping" && _loc3_ == 9)
      {
         _loc2_.finishedStep(9);
      }
      else if(which == "baking" && _loc3_ == 14)
      {
         _loc2_.finishedStep(14);
      }
      else if(which == "cutting" && _loc3_ == 19)
      {
         _loc2_.finishedStep(19);
      }
      else if(which == "giveOrder" && _loc3_ == 22)
      {
         _loc2_.finishedStep(22);
      }
      else if(which == "cutting" && _loc3_ == 23)
      {
         _loc2_.finishedStep(23);
      }
      else if(which == "order" && _loc3_ == 24)
      {
         _loc2_.finishedStep(24);
      }
   }
   function finishedStep(which)
   {
      var _loc2_ = this;
      var _loc6_ = _loc2_.gameObj;
      var _loc4_ = which + 1;
      var _loc3_ = _loc2_.cycleDelay;
      if(which < 4)
      {
         _loc3_ = 100;
      }
      _loc2_.clip.gotoAndStop(100);
      _loc2_.cycleInterval = setInterval(this,"trainTrigger",_loc3_,_loc4_);
      _loc2_.currentStep = 0;
   }
   function pauseUpdate(msg)
   {
      var _loc2_ = this;
      if(msg == "pause")
      {
         _loc2_.clip._visible = false;
      }
      else if(msg == "unpause")
      {
         _loc2_.clip._visible = true;
      }
   }
}
