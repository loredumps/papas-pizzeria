class roygame.models.EndDayScreen
{
   var getupSpeed = 1000;
   var tipSpeed = 1000;
   var reactSpeed = 1600;
   var hideSpeed = 3400;
   var rankSpeed = 500;
   var titleSpeed = 700;
   var shouldUpgrade = false;
   function EndDayScreen(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.gameclip = _loc2_.gameObj.clip;
      _loc2_.setupScreen();
   }
   function setupScreen()
   {
      var screen = this;
      var _loc2_ = screen.gameObj;
      screen.clip = screen.gameclip.attachMovie("endofday","endofday",100000);
      var _loc4_ = Math.floor(_loc2_.waitingToday / _loc2_.customersToday);
      var _loc3_ = Math.floor(_loc2_.toppingToday / _loc2_.customersToday);
      var _loc5_ = Math.floor(_loc2_.bakingToday / _loc2_.customersToday);
      var _loc6_ = Math.floor(_loc2_.cuttingToday / _loc2_.customersToday);
      var _loc7_ = Math.floor((_loc4_ + _loc3_ + _loc5_ + _loc6_) / 4);
      screen.clip.board.customers_txt.text = _loc2_.customersToday;
      screen.clip.board.quality_txt.text = _loc7_ + "%";
      screen.clip.board.waiting_txt.text = _loc4_ + "%";
      screen.clip.board.topping_txt.text = _loc3_ + "%";
      screen.clip.board.baking_txt.text = _loc5_ + "%";
      screen.clip.board.cutting_txt.text = _loc6_ + "%";
      _loc2_.soundEngine.switchMusic(6);
      _loc2_.hudObj.setMode("endofday");
      screen.clip.okclip.start_btn.onRelease = function()
      {
         screen.moveScreen();
      };
      screen.clip.buttonguard.onPress = function()
      {
      };
      screen.clip.buttonguard.useHandCursor = false;
   }
   function moveScreen()
   {
      var _loc2_ = this;
      _loc2_.clip.play();
      clearInterval(_loc2_.cycleInterval);
      _loc2_.cycleInterval = setInterval(this,"royGetUp",_loc2_.getupSpeed);
   }
   function royGetUp()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.clip.counter.roy.gotoAndPlay("getup");
      trace("roy...");
      _loc3_.soundEngine.switchMusic(2);
      clearInterval(_loc2_.cycleInterval);
      _loc2_.cycleInterval = setInterval(this,"showTips",_loc2_.tipSpeed);
   }
   function showTips()
   {
      var _loc3_ = this;
      var _loc4_ = _loc3_.gameObj;
      var _loc6_ = _loc4_.tipsToday;
      _loc4_.totalTips += _loc6_;
      var _loc7_ = _loc4_.totalTips;
      var _loc12_ = _loc6_ / 100;
      var _loc15_ = _loc7_ / 100;
      var _loc5_ = Math.floor(_loc12_);
      var _loc2_ = _loc6_ - _loc5_ * 100;
      var _loc14_ = _loc2_ / 100;
      if(_loc2_ < 10)
      {
         _loc2_ = "0" + _loc2_;
      }
      else if(_loc2_ == 0)
      {
         _loc2_ = "00";
      }
      var _loc8_ = "$" + _loc5_ + "." + _loc2_;
      _loc5_ = Math.floor(_loc15_);
      _loc2_ = _loc7_ - _loc5_ * 100;
      _loc14_ = _loc2_ / 100;
      if(_loc2_ < 10)
      {
         _loc2_ = "0" + _loc2_;
      }
      else if(_loc2_ == 0)
      {
         _loc2_ = "00";
      }
      var _loc11_ = "$" + _loc5_ + "." + _loc2_;
      if(_loc6_ <= 0)
      {
         _loc8_ = "$0.00";
      }
      if(_loc7_ <= 0)
      {
         _loc11_ = "$0.00";
      }
      _loc3_.clip.counter.tipdata.tipstoday.burst.money.text = _loc8_;
      _loc3_.clip.counter.tipdata.tipstotal.burst.money.text = _loc11_;
      _loc3_.clip.counter.tipdata.tipstoday.play();
      _loc3_.clip.counter.tipdata.tipstodaytext.play();
      _loc3_.clip.counter.tipdata.tipstotal.play();
      _loc3_.clip.counter.tipdata.totaltipstext.play();
      _loc3_.clip.counter.tipjar.clip.play();
      clearInterval(_loc3_.cycleInterval);
      _loc3_.cycleInterval = setInterval(this,"royReact",_loc3_.reactSpeed);
      var _loc13_ = _loc7_;
      var _loc9_ = _loc4_.myRank;
      var _loc10_ = _loc4_.lastRankLimit + (_loc9_ + 1) * _loc4_.rankMultiplier;
      trace("Will Hit Rank #" + (_loc9_ + 1) + " at " + _loc10_);
      if(_loc13_ > _loc10_)
      {
         _loc3_.shouldUpgrade = true;
         trace("Going to upgrade.");
      }
      else
      {
         trace("No upgrade.");
      }
   }
   function royReact()
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.gameObj;
      var _loc5_ = _loc4_.tipsToday;
      var _loc6_ = 300 * _loc4_.customersToday;
      var _loc3_ = Math.floor(_loc5_ / _loc6_ * 100);
      trace("tips today: " + _loc5_);
      trace("total customers: " + _loc4_.customersToday);
      trace("max tips: " + _loc6_);
      trace("Percentage of tips: " + _loc3_);
      if(_loc3_ > 80)
      {
         _loc2_.clip.counter.roy.gotoAndPlay("proud");
      }
      else if(_loc3_ > 60)
      {
         _loc2_.clip.counter.roy.gotoAndPlay("happy");
      }
      else if(_loc3_ > 40)
      {
         _loc2_.clip.counter.roy.gotoAndPlay("okay");
      }
      else
      {
         _loc2_.clip.counter.roy.gotoAndPlay("sad");
      }
      clearInterval(_loc2_.cycleInterval);
      _loc2_.cycleInterval = setInterval(this,"hideTips",_loc2_.hideSpeed);
   }
   function hideTips()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      trace("tipstoday frame: " + _loc2_.clip.counter.tipdata.tipstoday._currentframe);
      trace("tipstotal frame: " + _loc2_.clip.counter.topdata.tipstotal._currentframe);
      _loc2_.clip.counter.tipdata.tipstoday.play();
      _loc2_.clip.counter.tipdata.tipstodaytext.play();
      _loc2_.clip.counter.tipdata.tipstotal.play();
      _loc2_.clip.counter.tipdata.totaltipstext.play();
      clearInterval(_loc2_.cycleInterval);
      _loc2_.cycleInterval = setInterval(this,"showRank",_loc2_.rankSpeed);
   }
   function showRank()
   {
      var _loc2_ = this;
      var _loc5_ = _loc2_.gameObj;
      var _loc7_ = _loc5_.myRank;
      var _loc4_ = _loc7_.toString();
      var _loc6_ = _loc4_.length;
      var _loc3_ = undefined;
      if(_loc6_ == 1)
      {
         _loc2_.clip.counter.rank.clip.num.gotoAndStop(1);
         _loc3_ = int(_loc4_.charAt(0));
         _loc2_.clip.counter.rank.clip.num.num1.gotoAndStop(_loc3_ + 1);
      }
      else if(_loc6_ == 2)
      {
         _loc2_.clip.counter.rank.clip.num.gotoAndStop(2);
         _loc3_ = int(_loc4_.charAt(0));
         _loc2_.clip.counter.rank.clip.num.num1.gotoAndStop(_loc3_ + 1);
         _loc3_ = int(_loc4_.charAt(1));
         _loc2_.clip.counter.rank.clip.num.num2.gotoAndStop(_loc3_ + 1);
      }
      else if(_loc6_ == 3)
      {
         _loc2_.clip.counter.rank.clip.num.gotoAndStop(3);
         _loc3_ = int(_loc4_.charAt(0));
         _loc2_.clip.counter.rank.clip.num.num1.gotoAndStop(_loc3_ + 1);
         _loc3_ = int(_loc4_.charAt(1));
         _loc2_.clip.counter.rank.clip.num.num2.gotoAndStop(_loc3_ + 1);
         _loc3_ = int(_loc4_.charAt(2));
         _loc2_.clip.counter.rank.clip.num.num3.gotoAndStop(_loc3_ + 1);
      }
      else if(_loc6_ > 3)
      {
         _loc2_.clip.counter.rank.clip.num.gotoAndStop(3);
         _loc2_.clip.counter.rank.clip.num.num1.gotoAndStop(10);
         _loc2_.clip.counter.rank.clip.num.num2.gotoAndStop(10);
         _loc2_.clip.counter.rank.clip.num.num3.gotoAndStop(10);
      }
      var _loc8_ = _loc5_.rankTitles[_loc7_];
      if(_loc7_ >= _loc5_.rankTitles.length)
      {
         _loc8_ = _loc5_.rankTitles[_loc5_.rankTitles.length - 1];
      }
      _loc2_.clip.counter.rank.clip.rankname.titlemc.title.text = _loc8_;
      if(!_loc2_.shouldUpgrade)
      {
         _loc2_.clip.counter.rank.clip.rankname.gotoAndStop(30);
      }
      _loc2_.clip.counter.rank.play();
      clearInterval(_loc2_.cycleInterval);
      _loc2_.cycleInterval = setInterval(this,"determineUpgrade",_loc2_.titleSpeed);
   }
   function determineUpgrade()
   {
      var _loc2_ = this;
      var _loc5_ = _loc2_.gameObj;
      if(_loc2_.shouldUpgrade)
      {
         _loc5_.myRank = _loc5_.myRank + 1;
         _loc5_.lastRankLimit += _loc5_.myRank * _loc5_.rankMultiplier;
         var _loc7_ = _loc5_.myRank;
         var _loc4_ = _loc7_.toString();
         var _loc6_ = _loc4_.length;
         var _loc3_ = undefined;
         if(_loc6_ == 1)
         {
            _loc2_.clip.counter.rank.clip.num.gotoAndStop(1);
            _loc3_ = int(_loc4_.charAt(0));
            _loc2_.clip.counter.rank.clip.num.num1.gotoAndStop(_loc3_ + 1);
         }
         else if(_loc6_ == 2)
         {
            _loc2_.clip.counter.rank.clip.num.gotoAndStop(2);
            _loc3_ = int(_loc4_.charAt(0));
            _loc2_.clip.counter.rank.clip.num.num1.gotoAndStop(_loc3_ + 1);
            _loc3_ = int(_loc4_.charAt(1));
            _loc2_.clip.counter.rank.clip.num.num2.gotoAndStop(_loc3_ + 1);
         }
         else if(_loc6_ == 3)
         {
            _loc2_.clip.counter.rank.clip.num.gotoAndStop(3);
            _loc3_ = int(_loc4_.charAt(0));
            _loc2_.clip.counter.rank.clip.num.num1.gotoAndStop(_loc3_ + 1);
            _loc3_ = int(_loc4_.charAt(1));
            _loc2_.clip.counter.rank.clip.num.num2.gotoAndStop(_loc3_ + 1);
            _loc3_ = int(_loc4_.charAt(2));
            _loc2_.clip.counter.rank.clip.num.num3.gotoAndStop(_loc3_ + 1);
         }
         else if(_loc6_ > 3)
         {
            _loc2_.clip.counter.rank.clip.num.gotoAndStop(3);
            _loc2_.clip.counter.rank.clip.num.num1.gotoAndStop(10);
            _loc2_.clip.counter.rank.clip.num.num2.gotoAndStop(10);
            _loc2_.clip.counter.rank.clip.num.num3.gotoAndStop(10);
         }
         _loc2_.clip.counter.rank.clip.rankname.titlemc.title.text = _loc5_.rankTitles[_loc7_];
         _loc2_.clip.counter.rank.clip.upgrade.play();
         _loc5_.soundEngine.playSound("customer_overjoyed.wav");
         _loc2_.clip.counter.roy.gotoAndPlay("levelup");
         clearInterval(_loc2_.cycleInterval);
         _loc2_.cycleInterval = setInterval(this,"showRankTitle",_loc2_.titleSpeed);
      }
      else
      {
         _loc2_.showButtons();
      }
   }
   function showRankTitle()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.clip.counter.rank.clip.rankname.play();
      clearInterval(_loc2_.cycleInterval);
      _loc2_.cycleInterval = setInterval(this,"showButtons",_loc2_.titleSpeed);
   }
   function showNextRank()
   {
      var _loc4_ = this;
      var _loc5_ = _loc4_.gameObj;
      var _loc6_ = _loc5_.totalTips;
      var _loc9_ = _loc5_.myRank;
      var _loc8_ = _loc5_.lastRankLimit + (_loc9_ + 1) * _loc5_.rankMultiplier;
      var _loc3_ = _loc8_ - _loc6_;
      if(_loc3_ < 0)
      {
         _loc3_ = 100;
      }
      var _loc11_ = _loc3_ / 100;
      var _loc7_ = Math.floor(_loc11_);
      var _loc2_ = _loc3_ - _loc7_ * 100;
      var _loc12_ = _loc2_ / 100;
      if(_loc2_ < 10)
      {
         _loc2_ = "0" + _loc2_;
      }
      else if(_loc2_ == 0)
      {
         _loc2_ = "00";
      }
      var _loc10_ = "$" + _loc7_ + "." + _loc2_;
      trace("the current tips?: " + _loc6_);
      trace("The limit?: " + _loc8_);
      trace("The diff?: " + _loc3_);
      _loc4_.clip.counter.tipjar.clip.nextrankburst.burst.money.text = _loc10_;
      _loc4_.clip.counter.tipjar.clip.gotoAndPlay(2);
      _loc4_.clip.counter.tipjar.clip.nextrankburst.play();
   }
   function showButtons()
   {
      var screen = this;
      var _loc2_ = screen.gameObj;
      screen.clip.counter.buttons.quit_btn.onPress = function()
      {
         screen.QuitGame();
      };
      screen.clip.counter.buttons.score_btn._visible = false;
      screen.clip.counter.buttons.score_btn.onPress = function()
      {
         screen.SubmitScore();
      };
      screen.clip.counter.buttons.continue_btn.onPress = function()
      {
         screen.ContinueGame();
      };
      screen.clip.counter.buttons.play();
      clearInterval(screen.cycleInterval);
      screen.showNextRank();
      _loc2_.saveProgress();
   }
   function QuitGame()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc3_.quitGame();
   }
   function SubmitScore()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc3_.submitScore();
   }
   function ContinueGame()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc3_.nextLevel();
   }
   function pauseUpdate(msg)
   {
   }
}
