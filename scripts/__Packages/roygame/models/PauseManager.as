class roygame.models.PauseManager
{
   var observers = new Array();
   var isPaused = false;
   var previousScreen = null;
   var previouslyOnPause = false;
   function PauseManager(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
   }
   function pauseGame(customerfile, helpscreen)
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      if(_loc3_.inTransition == true)
      {
         _loc3_.transitionScreen.triggerAction();
      }
      trace("*****  PAUSE COMMAND:  Manager Paused: " + _loc2_.isPaused + ", customerfile: " + customerfile + ", game.showfile: " + _loc3_.showCustomerFile + ", helpscreen: " + helpscreen + ", game.showhelp: " + _loc3_.showHelpScreen + ", Previous: " + _loc2_.previousScreen + ", current: " + _loc3_.hudObj.currentMode + ", prevonpause: " + _loc2_.previouslyOnPause);
      if(_loc2_.isPaused == true && !customerfile && !helpscreen)
      {
         if(_loc2_.previouslyOnPause == true)
         {
            trace("Go back to pause? I guess?");
            _loc3_.switchModes("pause","allow");
            _loc2_.previouslyOnPause = false;
         }
         else
         {
            _loc2_.notifyListeners("unpause");
            _loc2_.isPaused = false;
            _loc3_.switchModes(_loc2_.previousScreen,"allow");
            trace("Unpause - go back to " + _loc2_.previousScreen);
            trace("---------------------");
         }
      }
      else if(customerfile && !_loc3_.showCustomerFile)
      {
         if(_loc3_.hudObj.currentMode != "pause")
         {
            _loc2_.previousScreen = _loc3_.hudObj.currentMode;
            if(_loc2_.previousScreen == "giveorder")
            {
               _loc2_.previousScreen = "giveOrder";
            }
            else if(_loc2_.previousScreen == "takeorder")
            {
               _loc2_.previousScreen = "takeOrder";
            }
            _loc2_.previouslyOnPause = false;
         }
         else
         {
            _loc2_.previouslyOnPause = true;
         }
         _loc3_.showCustomerFile = true;
         _loc3_.switchModes("customerfile","allow");
         if(!_loc2_.previouslyOnPause)
         {
            _loc2_.notifyListeners("pause");
         }
         _loc2_.isPaused = true;
         trace("Pause with Customer File");
         trace("---------------------");
      }
      else if(helpscreen && !_loc3_.showHelpScreen)
      {
         if(_loc3_.hudObj.currentMode != "pause")
         {
            _loc2_.previousScreen = _loc3_.hudObj.currentMode;
            if(_loc3_.hudObj == null || _loc3_.hudObj == undefined)
            {
               _loc2_.previousScreen = "mainmenu";
            }
            if(_loc2_.previousScreen == "giveorder")
            {
               _loc2_.previousScreen = "giveOrder";
            }
            else if(_loc2_.previousScreen == "takeorder")
            {
               _loc2_.previousScreen = "takeOrder";
            }
            _loc2_.previouslyOnPause = false;
         }
         else
         {
            _loc2_.previouslyOnPause = true;
         }
         _loc3_.showHelpScreen = true;
         _loc3_.switchModes("helpscreen","allow");
         if(!_loc2_.previouslyOnPause)
         {
            _loc2_.notifyListeners("pause");
         }
         _loc2_.isPaused = true;
         trace("Pause with Help Screen");
         trace("---------------------");
      }
      else if(_loc2_.isPaused == false)
      {
         if(_loc3_.hudObj.currentMode != "pause")
         {
            _loc2_.previousScreen = _loc3_.hudObj.currentMode;
            if(_loc2_.previousScreen == "giveorder")
            {
               _loc2_.previousScreen = "giveOrder";
            }
            else if(_loc2_.previousScreen == "takeorder")
            {
               _loc2_.previousScreen = "takeOrder";
            }
            _loc3_.switchModes("pause","allow");
            _loc2_.notifyListeners("pause");
            _loc2_.isPaused = true;
            trace("Pause");
            trace("---------------------");
         }
         else
         {
            trace("ALREADY PAUSED!  Um, tell the manager?");
            _loc3_.switchModes("pause","allow");
            _loc2_.isPaused = true;
            _loc2_.notifyListeners("pause");
            trace("---------------------");
         }
      }
   }
   function resetManager()
   {
      var _loc2_ = this;
      _loc2_.isPaused = false;
      _loc2_.clearListeners();
   }
   function addPauseListener(o)
   {
      var _loc3_ = this;
      var _loc5_ = _loc3_.gameObj;
      if(o == null)
      {
         return false;
      }
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.observers.length)
      {
         if(_loc3_.observers[_loc2_] == o)
         {
            return false;
         }
         _loc2_ = _loc2_ + 1;
      }
      _loc3_.observers.push(o);
      return true;
   }
   function removePauseListener(o)
   {
      var _loc3_ = this;
      var _loc6_ = _loc3_.gameObj;
      var _loc4_ = _loc3_.observers.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         if(_loc3_.observers[_loc2_] == o)
         {
            _loc3_.observers.splice(_loc2_,1);
            return true;
         }
         _loc2_ = _loc2_ + 1;
      }
      return false;
   }
   function clearListeners()
   {
      var _loc2_ = this;
      _loc2_.observers = new Array();
      _loc2_.isPaused = false;
   }
   function notifyListeners(msg)
   {
      var _loc5_ = this;
      if(msg == undefined)
      {
         return false;
      }
      var _loc3_ = _loc5_.observers.slice(0);
      var _loc2_ = _loc3_.length - 1;
      while(_loc2_ >= 0)
      {
         _loc3_[_loc2_].pauseUpdate(msg);
         _loc2_ = _loc2_ - 1;
      }
   }
}
