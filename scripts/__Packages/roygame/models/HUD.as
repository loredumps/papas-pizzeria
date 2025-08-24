class roygame.models.HUD
{
   var activeTicket = 0;
   var lastToolTip = "";
   function HUD(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.gameclip = _loc2_.gameObj.clip;
      _loc2_.attachHUD();
   }
   function attachHUD()
   {
      var hud = this;
      var game = hud.gameObj;
      hud.clip = hud.gameclip.attachMovie("hud","hud",50000);
      hud.clip.order_btn.button.onRelease = function()
      {
         game.switchModes("order");
         game.soundEngine.playSound("buttonclick.wav");
      };
      hud.clip.topping_btn.button.onRelease = function()
      {
         game.switchModes("topping");
         game.soundEngine.playSound("buttonclick.wav");
      };
      hud.clip.baking_btn.button.onRelease = function()
      {
         game.switchModes("baking");
         game.soundEngine.playSound("buttonclick.wav");
      };
      hud.clip.cutting_btn.button.onRelease = function()
      {
         game.switchModes("cutting");
         game.soundEngine.playSound("buttonclick.wav");
      };
      hud.clip.sound_btn.onRelease = function()
      {
         if(!game.pauseManager.isPaused)
         {
            game.soundEngine.muteSound();
         }
      };
      if(game.soundEngine.isMute)
      {
         hud.clip.sound_btn.gotoAndStop("off");
      }
      hud.clip.pause_btn.onRelease = function()
      {
         game.soundEngine.playSound("buttonclick.wav");
         game.pauseManager.pauseGame();
      };
      if(game.training)
      {
         hud.clip.file_btn._visible = false;
      }
      else
      {
         hud.clip.file_btn._visible = true;
      }
      hud.clip.file_btn.onRelease = function()
      {
         game.soundEngine.playSound("buttonclick.wav");
         game.pauseManager.pauseGame("customerfile");
      };
      hud.clip.help_btn.onRelease = function()
      {
         game.soundEngine.playSound("buttonclick.wav");
         game.pauseManager.pauseGame(0,"helpscreen");
      };
      hud.clip.quit_btn.onRelease = function()
      {
         game.soundEngine.playSound("grabtopping.wav");
      };
      hud.clip.quitMC.window.yes_btn.onRelease = function()
      {
         if(!game.pauseScreen.soundWasMuted)
         {
            game.soundEngine.muteSound();
         }
         game.soundEngine.playSound("buttonclick.wav");
         game.quitGame();
      };
      hud.clip.quitMC.window.no_btn.onRelease = function()
      {
         game.soundEngine.playSound("buttonclick.wav");
         hud.cancelQuit();
      };
      hud.clip.buttons.takeorder_btn.button.onRelease = function()
      {
         game.sendScreenAction("takeorder");
         game.soundEngine.playSound("buttonclick.wav");
      };
      hud.clip.buttons.makepizza_btn.button.onRelease = function()
      {
         game.sendScreenAction("makepizza");
         game.soundEngine.playSound("buttonclick.wav");
      };
      hud.clip.buttons.givepizza_btn.button.onRelease = function()
      {
         game.sendScreenAction("givepizza");
         game.soundEngine.playSound("buttonclick.wav");
      };
      hud.clip.buttons.putinoven_btn.button.onRelease = function()
      {
         game.sendScreenAction("putinoven");
         game.soundEngine.playSound("buttonclick.wav");
      };
      hud.clip.buttons.saveforlater_btn.button.onRelease = function()
      {
         game.sendScreenAction("saveforlater");
         game.soundEngine.playSound("buttonclick.wav");
      };
      hud.clip.buttons.throwaway_btn.button.onRelease = function()
      {
         game.sendScreenAction("throwaway");
         game.soundEngine.playSound("buttonclick.wav");
      };
      hud.setTooltip("** Welcome, Roy **",false);
      game.pauseManager.addPauseListener(this);
   }
   function setTooltip(message, rollover)
   {
      var _loc2_ = this;
      _loc2_.clip.tooltip.text = message;
      _loc2_.clip.marquee.flash.gotoAndPlay(2);
      if(!rollover)
      {
         _loc2_.lastToolTip = message;
      }
   }
   function setLastTooltip()
   {
      var _loc2_ = this;
      _loc2_.clip.tooltip.text = _loc2_.lastToolTip;
   }
   function setMode(which)
   {
      var _loc2_ = this;
      _loc2_.currentMode = which;
      if(which == "order")
      {
         _loc2_.clip.buttons.gotoAndStop("order");
      }
      else if(which == "topping")
      {
         _loc2_.clip.buttons.gotoAndStop("topping");
      }
      else if(which == "baking")
      {
         _loc2_.clip.buttons.gotoAndStop("baking");
      }
      else if(which == "cutting")
      {
         _loc2_.clip.buttons.gotoAndStop("cutting");
      }
      else if(which == "takeorder")
      {
         _loc2_.clip.buttons.gotoAndStop("order");
      }
      else if(which == "giveorder")
      {
         _loc2_.clip.buttons.gotoAndStop("order");
      }
      else if(which == "pause")
      {
         _loc2_.clip.buttons.gotoAndStop("blank");
      }
      _loc2_.setActiveTicket(_loc2_.activeTicket);
   }
   function switchTicketMode(which)
   {
      var _loc2_ = this;
      if(_loc2_.currentMode == "topping")
      {
         if(which == "ticket")
         {
            _loc2_.clip.buttons.gotoAndStop("topping_ticket");
         }
         else if(which == "pizza")
         {
            _loc2_.clip.buttons.gotoAndStop("topping_pizza");
         }
         else if(which == "blank")
         {
            _loc2_.clip.buttons.gotoAndStop("topping");
         }
      }
      else if(_loc2_.currentMode == "cutting")
      {
         if(which == "ticket")
         {
            _loc2_.clip.buttons.gotoAndStop("cutting_ticket");
         }
         else if(which == "pizza")
         {
            _loc2_.clip.buttons.gotoAndStop("cutting_pizza");
         }
         else if(which == "blank")
         {
            _loc2_.clip.buttons.gotoAndStop("cutting");
         }
      }
   }
   function confirmQuit()
   {
      var _loc2_ = this;
      _loc2_.clip.quitMC.gotoAndPlay(2);
   }
   function cancelQuit()
   {
      var _loc2_ = this;
      _loc2_.clip.quitMC.gotoAndStop(1);
   }
   function setActiveTicket(which)
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.activeTicket = which;
      if(_loc2_.activeTicket > 0)
      {
         if(_loc2_.currentMode == "topping")
         {
            var _loc4_ = false;
            var _loc9_ = "ticket" + _loc2_.activeTicket;
            var _loc5_ = _loc3_.ticketManager[_loc9_];
            if(_loc5_.whichPizza > 0 && _loc5_.pizzaIsTopping)
            {
               _loc4_ = true;
            }
            if(!_loc4_)
            {
               _loc2_.clip.buttons.gotoAndStop("topping_ticket");
               if(_loc3_.training)
               {
                  if(_loc3_.trainingManager.currentStep == 10)
                  {
                     _loc3_.trainingManager.finishedStep(10);
                  }
               }
            }
            else
            {
               _loc2_.clip.buttons.gotoAndStop("topping_pizza");
            }
         }
         else if(_loc2_.currentMode == "order")
         {
            var _loc8_ = _loc3_.customerManager.orderline.length;
            if(_loc8_ > 0)
            {
               var _loc7_ = _loc3_.customerManager.orderline[0];
               if(_loc7_.isWalking == false)
               {
                  _loc2_.clip.buttons.gotoAndStop("order_customer");
                  if(_loc3_.training)
                  {
                     if(_loc3_.trainingManager.currentStep == 5)
                     {
                        _loc3_.trainingManager.finishedStep(5);
                     }
                  }
               }
               else
               {
                  _loc2_.clip.buttons.gotoAndStop("order");
               }
            }
            else
            {
               _loc2_.clip.buttons.gotoAndStop("order");
            }
         }
         else if(_loc2_.currentMode == "cutting")
         {
            var _loc6_ = _loc3_.cuttingScreen.pizzas.length;
            if(_loc6_ > 0)
            {
               _loc2_.clip.buttons.gotoAndStop("cutting_ticket");
            }
            else
            {
               _loc2_.clip.buttons.gotoAndStop("cutting");
            }
         }
      }
      else if(_loc2_.currentMode == "topping")
      {
         _loc2_.clip.buttons.gotoAndStop("topping");
      }
      else if(_loc2_.currentMode == "cutting")
      {
         _loc6_ = _loc3_.cuttingScreen.pizzas.length;
         if(_loc6_ > 0)
         {
            _loc2_.clip.buttons.gotoAndStop("cutting_pizza");
         }
         else
         {
            _loc2_.clip.buttons.gotoAndStop("cutting");
         }
      }
      else if(_loc2_.currentMode == "order")
      {
         _loc8_ = _loc3_.customerManager.orderline.length;
         if(_loc8_ > 0)
         {
            _loc7_ = _loc3_.customerManager.orderline[0];
            if(_loc7_.isWalking == false)
            {
               _loc2_.clip.buttons.gotoAndStop("order_customer");
               if(_loc3_.training)
               {
                  if(_loc3_.trainingManager.currentStep == 5)
                  {
                     _loc3_.trainingManager.finishedStep(5);
                  }
               }
            }
            else
            {
               _loc2_.clip.buttons.gotoAndStop("order");
            }
         }
         else
         {
            _loc2_.clip.buttons.gotoAndStop("order");
         }
      }
   }
   function pauseUpdate(msg)
   {
   }
}
