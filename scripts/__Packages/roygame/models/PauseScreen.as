class roygame.models.PauseScreen
{
   var active = false;
   var soundWasMuted = false;
   function PauseScreen(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.gameclip = _loc2_.gameObj.clip;
      _loc2_.setupScreen();
   }
   function updateText()
   {
      var _loc3_ = this;
      var _loc6_ = _loc3_.gameObj;
      var _loc4_ = _loc6_.tipsToday;
      var _loc10_ = _loc4_ / 100;
      var _loc8_ = Math.floor(_loc10_);
      var _loc2_ = _loc4_ - _loc8_ * 100;
      var _loc11_ = _loc2_ / 100;
      if(_loc2_ < 10)
      {
         _loc2_ = "0" + _loc2_;
      }
      else if(_loc2_ == 0)
      {
         _loc2_ = "00";
      }
      var _loc9_ = "$" + _loc8_ + "." + _loc2_;
      if(_loc4_ <= 0)
      {
         _loc9_ = "$0.00 ";
      }
      var _loc5_ = _loc6_.totalTips;
      _loc10_ = _loc5_ / 100;
      _loc8_ = Math.floor(_loc10_);
      _loc2_ = _loc5_ - _loc8_ * 100;
      _loc11_ = _loc2_ / 100;
      if(_loc2_ < 10)
      {
         _loc2_ = "0" + _loc2_;
      }
      else if(_loc2_ == 0)
      {
         _loc2_ = "00";
      }
      var _loc7_ = "$" + _loc8_ + "." + _loc2_;
      if(_loc5_ <= 0)
      {
         _loc7_ = "$0.00 ";
      }
      _loc3_.clip.day_text.text = _loc6_.currentDay;
      _loc3_.clip.tips_text.text = _loc9_;
      _loc3_.clip.total_text.text = _loc7_;
   }
   function setupScreen()
   {
      var _loc2_ = this;
      var game = _loc2_.gameObj;
      _loc2_.clip = _loc2_.gameclip.attachMovie("pause_screen","pause_screen",30);
      _loc2_.clip._x = -5000;
      _loc2_.clip.quit_btn.onPress = function()
      {
         game.soundEngine.playSound("grabtopping.wav");
         game.hudObj.confirmQuit();
      };
      _loc2_.clip.continue_btn.onPress = function()
      {
         game.soundEngine.playSound("buttonclick.wav");
         game.pauseManager.pauseGame();
      };
      _loc2_.clip.help_btn.onPress = function()
      {
         game.soundEngine.playSound("grabtopping.wav");
         game.pauseManager.pauseGame(0,"helpscreen");
      };
      game.pauseManager.addPauseListener(_loc2_);
   }
   function setCurrentMode()
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_.gameObj;
      _loc3_.clip._x = 0;
      _loc3_.active = true;
      _loc3_.updateText();
      _loc2_.toppingScreen.setNotCurrentMode();
      _loc2_.orderScreen.setNotCurrentMode();
      _loc2_.cuttingScreen.setNotCurrentMode();
      _loc2_.takeOrderScreen.setNotCurrentMode();
      _loc2_.giveOrderScreen.setNotCurrentMode();
      _loc2_.hudObj.setMode("pause");
   }
   function setNotCurrentMode()
   {
      var _loc2_ = this;
      _loc2_.clip._x = -5000;
      _loc2_.active = false;
      _loc2_.clip.helpscreen.gotoAndPlay("closehelp");
   }
   function pauseUpdate(msg)
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      if(!_loc3_.showCustomerFile)
      {
         if(msg == "pause")
         {
            _loc2_.soundWasMuted = _loc3_.soundEngine.isMute;
            if(!_loc2_.soundWasMuted)
            {
               _loc3_.soundEngine.muteSound();
            }
         }
         else if(msg == "unpause")
         {
            if(!_loc2_.soundWasMuted)
            {
               _loc3_.soundEngine.muteSound();
            }
         }
      }
   }
}
