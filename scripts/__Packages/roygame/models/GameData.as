class roygame.models.GameData
{
   var training = false;
   var whichSaveSlot = 1;
   var savedata = {playerid:"a9a9a9a9",rank:1,currentday:1,totaltips:0,username:"demo"};
   var blankcustomerdata = [[],[1,"Cooper","Pepperoni",0,0,0,0],[1,"Wally","Anchovies",0,0,0,0],[1,"Rita","Mushrooms",0,0,0,0],[1,"Marty","Olives",0,0,0,0],[1,"Kingsley","Pepperoni",0,0,0,0],[1,"Timm","Peppers",0,0,0,0],[0,"Big Pauly","Sausage and Onions",0,0,0,0],[0,"Penny","Sausage and Mushrooms",0,0,0,0],[0,"Maggie","Peppers and Olives",0,0,0,0],[0,"Taylor","Peppers and Onions",0,0,0,0],[0,"Sue","Pepperoni and Mushrooms",0,0,0,0],[0,"Allan","Pepperoni and Sausage",0,0,0,0],[0,"Mindy","Mushroom and Anchovies",0,0,0,0],[0,"Chuck","Pepperoni and Sausage",0,0,0,0],[0,"Greg","Pepperoni and Mushrooms",0,0,0,0],[0,"Robby","Mushroom and Peppers",0,0,0,0],[0,"Mary","Pepperoni",0,0,0,0],[0,"Mitch","Pepperoni, Olive, Anchovies",0,0,0,0],[0,"Prudence","Mushroom and Onions",0,0,0,0],[0,"James","Sausage and Olives",0,0,0,0],[0,"Cecilia","Mushroom, Peppers, Onions",0,0,0,0],[0,"Mandi","Pepperoni and Mushrooms",0,0,0,0],[0,"Sasha","Peppers and Olives",0,0,0,0],[0,"Olga","Sausage, Mushroom, Onions",0,0,0,0],[0,"Franco","Pepperoni and Olives",0,0,0,0],[0,"Tohru","Mushroom, Peppers, Anchovies",0,0,0,0],[0,"Clair","Pepperoni, Mushroom, Peppers",0,0,0,0],[0,"Clover","Pepperoni",0,0,0,0],[0,"Hugo","Sausage and Peppers",0,0,0,0],[0,"Peggy","Onions and Olives",0,0,0,0],[0,"Carlo Romano","Sausage, Mushrooms, Peppers",0,0,0,0],[0,"Little Edoardo","Onion, Olives, Anchovies",0,0,0,0],[0,"Gino Romano","Pepperoni, Onions, Olives",0,0,0,0],[0,"Bruna Romano","Pepperoni, Sausage, Olives",0,0,0,0],[0,"SargeFan!","Onions Only!",0,0,0,0],[0,"PAPA LOUIE!","The Works!",0,0,0,0]];
   var currentDay = 1;
   var currentOrder = 1;
   var timePerDay = 180000;
   var prepTimePerOrder = 45000;
   var cookTimeForPizza = 3;
   var tipsToday = 0;
   var totalTips = 0;
   var myRank = 1;
   var rankTitles = ["!","Newbie","Trainee","Cashier","Delivery Boy","Part-Time Cook","Line Cook","Pizza Topper","Head Cook","Chef Trainee","Assistant Chef","Sous Chef","Pizza Chef","Head Chef","Master Chef","Pizza Master","Pepperoni Lover","Sausage Specialist","Mushroom Master","Pepper Pro","Onion Wrangler","Olive Expert","Anchovy Flinger","Dough Tosser","Cheese Grater","Oven Expert","Slicer and Dicer","Pizzeria Manager","Pizza Commander","Master of Pizzas","Ultimate Chef","Better Than Papa!"];
   var rankLimits = [0,500,2000,3500,5000,7000,9000,11000,13500,16000,18500,22000,25500,29000,33000,37000,41000,45000,50000,55000,60000,70000,80000,90000,100000,110000,120000,130000];
   var rankBaseNumber = 1000;
   var rankMultiplier = 500;
   var lastRankLimit = 0;
   var waitingToday = 0;
   var toppingToday = 0;
   var bakingToday = 0;
   var cuttingToday = 0;
   var customersToday = 0;
   var dayIsOver = false;
   var showNoPapa = false;
   var showNewCustomer = false;
   var newCustomerNum = 1;
   var showCustomerFile = false;
   var showHelpScreen = false;
   var inTransition = false;
   function GameData()
   {
      var _loc3_ = this;
      _loc3_.clip = _root.createEmptyMovieClip("gameclip",1);
      _loc3_.leveldata = new roygame.models.LevelData(_loc3_);
      _loc3_.soundEngine = new roygame.models.SoundEngine(_loc3_);
      _loc3_.pauseManager = new roygame.models.PauseManager(_loc3_);
   }
   function createNewCustomerData()
   {
      var _loc4_ = this;
      _loc4_.customerdata = [];
      var _loc3_ = 0;
      while(_loc3_ < _loc4_.blankcustomerdata.length)
      {
         _loc4_.customerdata.push([]);
         var _loc2_ = 0;
         while(_loc2_ < _loc4_.blankcustomerdata[_loc3_].length)
         {
            _loc4_.customerdata[_loc3_][_loc2_] = _loc4_.blankcustomerdata[_loc3_][_loc2_];
            _loc2_ = _loc2_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function startGame()
   {
      var _loc2_ = this;
      _loc2_.endDayScreen.clip.removeMovieClip();
      delete _loc2_.endDayScreen;
      _loc2_.endDayScreen = null;
      _loc2_.hudObj.clip.removeMovieClip();
      delete _loc2_.hudObj;
      _loc2_.hudObj = null;
      _loc2_.customersToday = 0;
      _loc2_.waitingToday = 0;
      _loc2_.toppingToday = 0;
      _loc2_.bakingToday = 0;
      _loc2_.cuttingToday = 0;
      _loc2_.dayIsOver = false;
      _loc2_.inTransition = false;
      _loc2_.showNoPapa = false;
      _loc2_.showNewCustomer = false;
      _loc2_.newCustomerNum = 1;
      _loc2_.startLevel(_loc2_.currentDay);
   }
   function quitGame()
   {
      var _loc2_ = this;
      _loc2_.soundEngine.switchMusic(0);
      _loc2_.pauseManager.isPaused = false;
      _loc2_.switchModes("mainmenu","allow");
   }
   function submitScore()
   {
      var _loc2_ = this;
      _loc2_.switchModes("highscores","allow");
   }
   function nextLevel()
   {
      var _loc2_ = this;
      _loc2_.training = false;
      _loc2_.currentDay = _loc2_.currentDay + 1;
      _loc2_.tipsToday = 0;
      _loc2_.customersToday = 0;
      _loc2_.waitingToday = 0;
      _loc2_.bakingToday = 0;
      _loc2_.toppingToday = 0;
      _loc2_.cuttingToday = 0;
      _loc2_.dayIsOver = false;
      _loc2_.soundEngine.switchMusic(0);
      _loc2_.startLevel(_loc2_.currentDay);
   }
   function startLevel(which)
   {
      var _loc2_ = this;
      delete _loc2_.ticketManager;
      delete _loc2_.pizzaManager;
      delete _loc2_.customerManager;
      delete _loc2_.startDayScreen;
      _loc2_.pauseManager.resetManager();
      _loc2_.ticketManager = new roygame.models.TicketManager(_loc2_);
      _loc2_.pizzaManager = new roygame.models.PizzaManager(_loc2_);
      _loc2_.customerManager = new roygame.models.CustomerManager(_loc2_);
      if(_loc2_.training)
      {
         _loc2_.switchModes("intro","allow");
      }
      else if(_loc2_.showNewCustomer || _loc2_.showNoPapa)
      {
         _loc2_.switchModes("newcustomer","allow");
      }
      else
      {
         _loc2_.switchModes("startofday","allow");
      }
   }
   function buildLevelInterface()
   {
      var _loc2_ = this;
      _loc2_.hudObj.clip.removeMovieClip();
      delete _loc2_.hudObj;
      _loc2_.hudObj = null;
      _loc2_.hudObj = new roygame.models.HUD(_loc2_);
      _loc2_.startDayScreen.clip.removeMovieClip();
      delete _loc2_.startDayScreen;
      _loc2_.startDayScreen = null;
      _loc2_.endDayScreen.clip.removeMovieClip();
      delete _loc2_.endDayScreen;
      _loc2_.endDayScreen = null;
      _loc2_.clip.attachMovie("fader","bggrey",2);
      delete _loc2_.orderScreen;
      _loc2_.orderScreen = new roygame.models.OrderScreen(_loc2_);
      _loc2_.toppingScreen = new roygame.models.ToppingScreen(_loc2_);
      _loc2_.bakingScreen = new roygame.models.BakingScreen(_loc2_);
      _loc2_.cuttingScreen = new roygame.models.CuttingScreen(_loc2_);
      _loc2_.takeOrderScreen = new roygame.models.TakeOrderScreen(_loc2_);
      _loc2_.giveOrderScreen = new roygame.models.GiveOrderScreen(_loc2_);
      _loc2_.pauseScreen = new roygame.models.PauseScreen(_loc2_);
   }
   function startLevelInterface()
   {
      var _loc2_ = this;
      _loc2_.soundEngine.startGameMusic();
      _loc2_.switchModes("order","allow");
      if(_loc2_.training)
      {
         _loc2_.trainingManager = new roygame.models.TrainingManager(_loc2_);
      }
      else
      {
         _loc2_.customerManager.setupSpawn();
      }
   }
   function switchModes(which, allow)
   {
      var _loc2_ = this;
      trace("Switching Modes To: " + which);
      trace("HUD Current Mode:   " + _loc2_.hudObj.currentMode);
      _loc2_.inTransition = true;
      if(_loc2_.training)
      {
         if(which == "takeOrder" && _loc2_.trainingManager.currentStep == 6)
         {
            allow = "allow";
         }
         else if(which == "giveOrder" && _loc2_.trainingManager.currentStep == 22)
         {
            allow = "allow";
         }
         if(which == _loc2_.trainingManager.switchToMode || allow)
         {
            if(!_loc2_.pauseManager.isPaused)
            {
               if(_loc2_.hudObj.currentMode != "giveorder" && _loc2_.hudObj.currentMode != "takeorder" || allow)
               {
                  if(which != _loc2_.currentMode)
                  {
                     _loc2_.hudObj.clip.buttons.gotoAndStop("blank");
                     _loc2_.killTransition();
                     _loc2_.transitionScreen = new roygame.models.Transition(_loc2_,which);
                  }
               }
            }
            else if(_loc2_.pauseManager.isPaused && (which == "customerfile" || which == "helpscreen" || which == "pause"))
            {
               _loc2_.hudObj.clip.buttons.gotoAndStop("blank");
               _loc2_.killTransition();
               _loc2_.transitionScreen = new roygame.models.Transition(_loc2_,which);
            }
         }
      }
      else if(_loc2_.hudObj.currentMode != "giveorder" && _loc2_.hudObj.currentMode != "takeorder" || allow)
      {
         if(!_loc2_.pauseManager.isPaused)
         {
            if(which != _loc2_.currentMode)
            {
               _loc2_.hudObj.clip.buttons.gotoAndStop("blank");
               _loc2_.killTransition();
               _loc2_.transitionScreen = new roygame.models.Transition(_loc2_,which);
            }
         }
         else if(_loc2_.pauseManager.isPaused && (which == "customerfile" || which == "helpscreen" || which == "pause"))
         {
            _loc2_.hudObj.clip.buttons.gotoAndStop("blank");
            _loc2_.killTransition();
            _loc2_.transitionScreen = new roygame.models.Transition(_loc2_,which);
         }
      }
   }
   function killTransition(which)
   {
      var _loc2_ = this;
      _loc2_.transitionScreen.clip.removeMovieClip();
      delete _loc2_.transitionScreen;
      _loc2_.transitionScreen = null;
      if(which == "buildlevel")
      {
         _loc2_.startLevelInterface();
      }
   }
   function playIntro()
   {
      var game = this;
      game.clip.attachMovie("intro_master","intro",2);
      game.clip.intro._x = 300;
      game.clip.intro._y = 225;
      game.soundEngine.switchMusic(0);
      game.soundEngine.playSound("gameintro.wav",0,2);
      game.clip.intro.skip_btn.onPress = function()
      {
         game.endIntro();
      };
   }
   function endIntro()
   {
      var _loc2_ = this;
      _loc2_.soundEngine.SoundFX2.stop();
      _loc2_.switchModes("startofday","allow");
   }
   function finishSwitchModes(which)
   {
      var _loc2_ = this;
      if(which == "endofday")
      {
         _loc2_.endDayScreen = new roygame.models.EndDayScreen(_loc2_);
      }
      else if(which == "startofday")
      {
         _loc2_.clip.mainmenu.removeMovieClip();
         _loc2_.endDayScreen.clip.removeMovieClip();
         delete _loc2_.endDayScreen;
         _loc2_.endDayScreen = null;
         _loc2_.newCustomerScreen.clip.removeMovieClip();
         delete _loc2_.newCustomerScreen;
         _loc2_.newCustomerScreen = null;
         _loc2_.hudObj.clip.removeMovieClip();
         delete _loc2_.hudObj;
         _loc2_.hudObj = null;
         _loc2_.highScores.clip.removeMovieClip();
         delete _loc2_.highScores;
         _loc2_.highScores = null;
         _loc2_.clip.intro.removeMovieClip();
         _loc2_.startDayScreen = new roygame.models.StartDayScreen(_loc2_);
      }
      else if(which == "newcustomer")
      {
         _loc2_.clip.mainmenu.removeMovieClip();
         _loc2_.endDayScreen.clip.removeMovieClip();
         delete _loc2_.endDayScreen;
         _loc2_.endDayScreen = null;
         _loc2_.hudObj.clip.removeMovieClip();
         delete _loc2_.hudObj;
         _loc2_.hudObj = null;
         _loc2_.highScores.clip.removeMovieClip();
         delete _loc2_.highScores;
         _loc2_.highScores = null;
         _loc2_.clip.intro.removeMovieClip();
         _loc2_.newCustomerScreen = new roygame.models.NewCustomerScreen(_loc2_);
      }
      else if(which == "intro")
      {
         _loc2_.clip.mainmenu.removeMovieClip();
         _loc2_.endDayScreen.clip.removeMovieClip();
         delete _loc2_.endDayScreen;
         _loc2_.endDayScreen = null;
         _loc2_.hudObj.clip.removeMovieClip();
         delete _loc2_.hudObj;
         _loc2_.hudObj = null;
         _loc2_.highScores.clip.removeMovieClip();
         delete _loc2_.highScores;
         _loc2_.highScores = null;
         _loc2_.playIntro();
      }
      else if(which == "highscores")
      {
         _loc2_.clip.mainmenu.removeMovieClip();
         _loc2_.endDayScreen.clip.removeMovieClip();
         delete _loc2_.endDayScreen;
         _loc2_.endDayScreen = null;
         _loc2_.hudObj.clip.removeMovieClip();
         delete _loc2_.hudObj;
         _loc2_.hudObj = null;
         _loc2_.highScores = new roygame.models.HighScores(_loc2_);
      }
      else if(which == "mainmenu")
      {
         _loc2_.endDayScreen.clip.removeMovieClip();
         delete _loc2_.endDayScreen;
         _loc2_.endDayScreen = null;
         _loc2_.hudObj.clip.removeMovieClip();
         delete _loc2_.hudObj;
         _loc2_.hudObj = null;
         _loc2_.highScores.clip.removeMovieClip();
         delete _loc2_.highScores;
         _loc2_.highScores = null;
         if(_loc2_.showHelpScreen)
         {
            _loc2_.showHelpScreen = false;
            _loc2_.helpScreen.clip.removeMovieClip();
            delete _loc2_.helpScreen;
            _loc2_.helpScreen = null;
         }
         _loc2_.mainMenu();
      }
      else if(which == "customerfile")
      {
         _loc2_.currentMode = which;
         _loc2_.customerFileScreen = new roygame.models.CustomerFileScreen(_loc2_);
      }
      else if(which == "helpscreen")
      {
         _loc2_.currentMode = which;
         _loc2_.helpScreen = new roygame.models.HelpScreen(_loc2_);
      }
      else if(which == "buildlevel")
      {
         _loc2_.startDayScreen.clip.removeMovieClip();
         delete _loc2_.startDayScreen;
         _loc2_.startDayScreen = null;
         _loc2_.buildLevelInterface();
      }
      else
      {
         if(_loc2_.showCustomerFile)
         {
            _loc2_.showCustomerFile = false;
            _loc2_.customerFileScreen.clip.removeMovieClip();
            delete _loc2_.customerFileScreen;
            _loc2_.customerFileScreen = null;
         }
         if(_loc2_.showHelpScreen)
         {
            _loc2_.showHelpScreen = false;
            _loc2_.helpScreen.clip.removeMovieClip();
            delete _loc2_.helpScreen;
            _loc2_.helpScreen = null;
         }
         var _loc4_ = which + "Screen";
         _loc2_[_loc4_].setCurrentMode();
         _loc2_.currentMode = which;
      }
      if(_loc2_.training)
      {
         _loc2_.trainingManager.switchedMode(which);
      }
      _loc2_.inTransition = false;
   }
   function endTraining()
   {
      var _loc2_ = this;
      _loc2_.trainingManager.clip.removeMovieClip();
      delete _loc2_.trainingManager;
      _loc2_.trainingManager = null;
      _loc2_.training = false;
      _loc2_.dayIsOver = true;
   }
   function sendScreenAction(which)
   {
      var _loc2_ = this;
      if(!_loc2_.pauseManager.isPaused)
      {
         if(which == "takeorder")
         {
            _loc2_.orderScreen.takeOrder();
         }
         else if(which == "makepizza")
         {
            _loc2_.toppingScreen.makePizza();
         }
         else if(which == "putinoven")
         {
            _loc2_.toppingScreen.putInOven();
         }
         else if(which == "saveforlater")
         {
            _loc2_.toppingScreen.saveForLater();
         }
         else if(which == "givepizza")
         {
            _loc2_.cuttingScreen.givePizza();
         }
         else if(which == "throwaway")
         {
            _loc2_.cuttingScreen.throwAwayPizza();
         }
      }
   }
   function mainMenu()
   {
      var game = this;
      game.pauseManager.clearListeners();
      game.orderScreen.clip.removeMovieClip();
      game.toppingScreen.clip.removeMovieClip();
      game.bakingScreen.clip.removeMovieClip();
      game.cuttingScreen.clip.removeMovieClip();
      game.giveOrderScreen.clip.removeMovieClip();
      game.takeOrderScreen.clip.removeMovieClip();
      game.pauseScreen.clip.removeMovieClip();
      game.clip.bggrey.removeMovieClip();
      delete game.orderScreen;
      delete game.toppingScreen;
      delete game.bakingScreen;
      delete game.cuttingScreen;
      delete game.giveOrderScreen;
      delete game.takeOrderScreen;
      delete game.pauseScreen;
      delete game.customerManager;
      delete game.pizzaManager;
      delete game.ticketManager;
      delete game.trainingManager;
      game.customerManager = null;
      game.pizzaManager = null;
      game.ticketManager = null;
      game.trainingManager = null;
      game.orderScreen = null;
      game.toppingScreen = null;
      game.bakingScreen = null;
      game.cuttingScreen = null;
      game.giveOrderScreen = null;
      game.takeOrderScreen = null;
      game.pauseScreen = null;
      game.tipsToday = 0;
      game.totalTips = 0;
      game.currentDay = 1;
      game.currentOrder = 1;
      game.myRank = 1;
      game.lastRankLimit = 0;
      game.soundEngine.startMainMenuMusic();
      game.currentMode = "mainMenu";
      game.clip.attachMovie("mainmenu","mainmenu",1);
      game.clip.mainmenu.buttons.gotoAndPlay("show");
      game.clip.mainmenu.buttons.start_btn.onRelease = function()
      {
         game.soundEngine.playSound("buttonclick.wav");
         game.menuShowSlots();
      };
      game.clip.mainmenu.buttons.help_btn.onRelease = function()
      {
         game.soundEngine.playSound("buttonclick.wav");
         game.pauseManager.pauseGame(0,"helpscreen");
      };
      game.clip.mainmenu.buttons.credits_btn.onRelease = function()
      {
         game.soundEngine.playSound("buttonclick.wav");
         game.menuShowCredits();
      };
   }
   function menuShowCredits()
   {
      var _loc2_ = this;
      _loc2_.clip.mainmenu.credits.gotoAndPlay("show");
      if(_loc2_.clip.mainmenu.buttons._currentframe > 1)
      {
         _loc2_.clip.mainmenu.buttons.gotoAndPlay("hide");
      }
   }
   function menuShowHelp()
   {
      var _loc2_ = this;
      _loc2_.clip.mainmenu.help.gotoAndPlay("show");
      if(_loc2_.clip.mainmenu.buttons._currentframe > 1)
      {
         _loc2_.clip.mainmenu.buttons.gotoAndPlay("hide");
      }
   }
   function menuShowButtons()
   {
      var _loc2_ = this;
      if(_loc2_.clip.mainmenu.buttons._currentframe == 1)
      {
         _loc2_.clip.mainmenu.buttons.gotoAndPlay("show");
      }
   }
   function menuShowSlots()
   {
      var game = this;
      game.clip.mainmenu.gotoAndStop("slots");
      if(game.clip.mainmenu.buttons._currentframe > 1)
      {
         game.clip.mainmenu.buttons.gotoAndPlay("hide");
      }
      game.clip.mainmenu.slots.gotoAndPlay(2);
      var _loc2_ = SharedObject.getLocal("RoyPizzeriaSlot1","/");
      var _loc4_ = SharedObject.getLocal("RoyPizzeriaSlot2","/");
      var _loc5_ = SharedObject.getLocal("RoyPizzeriaSlot3","/");
      game.clip.mainmenu.slots.slot1.selector.onRollOver = function()
      {
         game.clip.mainmenu.slots.slot1.flash.gotoAndPlay(2);
         game.soundEngine.playSound("grabticket.wav");
      };
      game.clip.mainmenu.slots.slot2.selector.onRollOver = function()
      {
         game.clip.mainmenu.slots.slot2.flash.gotoAndPlay(2);
         game.soundEngine.playSound("grabticket.wav");
      };
      game.clip.mainmenu.slots.slot3.selector.onRollOver = function()
      {
         game.clip.mainmenu.slots.slot3.flash.gotoAndPlay(2);
         game.soundEngine.playSound("grabticket.wav");
      };
      game.clip.mainmenu.slots.slot1.selector.onRollOut = function()
      {
         game.clip.mainmenu.slots.slot1.flash.gotoAndStop(1);
      };
      game.clip.mainmenu.slots.slot2.selector.onRollOut = function()
      {
         game.clip.mainmenu.slots.slot2.flash.gotoAndStop(1);
      };
      game.clip.mainmenu.slots.slot3.selector.onRollOut = function()
      {
         game.clip.mainmenu.slots.slot3.flash.gotoAndStop(1);
      };
      if(_loc2_.data.savedata != undefined)
      {
         var _loc3_ = _loc2_.data.savedata.rank;
         var _loc7_ = _loc2_.data.savedata.username;
         var _loc6_ = game.rankTitles[_loc3_];
         if(_loc3_ >= game.rankTitles.length)
         {
            _loc6_ = game.rankTitles[game.rankTitles.length - 1];
         }
         game.clip.mainmenu.slots.slot1.gotoAndStop(1);
         game.clip.mainmenu.slots.slot1.saverank.text = _loc3_;
         game.clip.mainmenu.slots.slot1.savename.text = _loc7_;
         game.clip.mainmenu.slots.slot1.savetitle.text = _loc6_;
         game.clip.mainmenu.slots.slot1.selector.onPress = function()
         {
            game.startSavedGame(1);
         };
         game.clip.mainmenu.slots.slot1.erase_btn.onPress = function()
         {
            game.clip.mainmenu.slots.slot1.gotoAndStop(2);
            game.clip.mainmenu.slots.slot1.yes_btn.onPress = function()
            {
               game.eraseSaveSlot(1);
            };
            game.clip.mainmenu.slots.slot1.no_btn.onPress = function()
            {
               game.menuShowSlots();
            };
         };
      }
      else
      {
         game.clip.mainmenu.slots.slot1.gotoAndStop(3);
         game.clip.mainmenu.slots.slot1.selector.onPress = function()
         {
            game.enterUserName(1);
         };
      }
      if(_loc4_.data.savedata != undefined)
      {
         _loc3_ = _loc4_.data.savedata.rank;
         _loc7_ = _loc4_.data.savedata.username;
         _loc6_ = game.rankTitles[_loc3_];
         if(_loc3_ >= game.rankTitles.length)
         {
            _loc6_ = game.rankTitles[game.rankTitles.length - 1];
         }
         game.clip.mainmenu.slots.slot2.gotoAndStop(1);
         game.clip.mainmenu.slots.slot2.saverank.text = _loc3_;
         game.clip.mainmenu.slots.slot2.savename.text = _loc7_;
         game.clip.mainmenu.slots.slot2.savetitle.text = _loc6_;
         game.clip.mainmenu.slots.slot2.selector.onPress = function()
         {
            game.startSavedGame(2);
         };
         game.clip.mainmenu.slots.slot2.erase_btn.onPress = function()
         {
            game.clip.mainmenu.slots.slot2.gotoAndStop(2);
            game.clip.mainmenu.slots.slot2.yes_btn.onPress = function()
            {
               game.eraseSaveSlot(2);
            };
            game.clip.mainmenu.slots.slot2.no_btn.onPress = function()
            {
               game.menuShowSlots();
            };
         };
      }
      else
      {
         game.clip.mainmenu.slots.slot2.gotoAndStop(3);
         game.clip.mainmenu.slots.slot2.selector.onPress = function()
         {
            game.enterUserName(2);
         };
      }
      if(_loc5_.data.savedata != undefined)
      {
         _loc3_ = _loc5_.data.savedata.rank;
         _loc7_ = _loc5_.data.savedata.username;
         _loc6_ = game.rankTitles[_loc3_];
         if(_loc3_ >= game.rankTitles.length)
         {
            _loc6_ = game.rankTitles[game.rankTitles.length - 1];
         }
         game.clip.mainmenu.slots.slot3.gotoAndStop(1);
         game.clip.mainmenu.slots.slot3.saverank.text = _loc3_;
         game.clip.mainmenu.slots.slot3.savename.text = _loc7_;
         game.clip.mainmenu.slots.slot3.savetitle.text = _loc6_;
         game.clip.mainmenu.slots.slot3.selector.onPress = function()
         {
            game.startSavedGame(3);
         };
         game.clip.mainmenu.slots.slot3.erase_btn.onPress = function()
         {
            game.clip.mainmenu.slots.slot3.gotoAndStop(2);
            game.clip.mainmenu.slots.slot3.yes_btn.onPress = function()
            {
               game.eraseSaveSlot(3);
            };
            game.clip.mainmenu.slots.slot3.no_btn.onPress = function()
            {
               game.menuShowSlots();
            };
         };
      }
      else
      {
         game.clip.mainmenu.slots.slot3.gotoAndStop(3);
         game.clip.mainmenu.slots.slot3.selector.onPress = function()
         {
            game.enterUserName(3);
         };
      }
   }
   function eraseSaveSlot(whichslot)
   {
      var _loc2_ = this;
      var _loc3_ = "RoyPizzeriaSlot" + whichslot;
      var _loc4_ = SharedObject.getLocal(_loc3_,"/");
      _loc4_.clear();
      _loc2_.menuShowSlots();
   }
   function startSavedGame(whichslot)
   {
      var _loc2_ = this;
      var _loc5_ = "RoyPizzeriaSlot" + whichslot;
      _loc2_.whichSaveSlot = whichslot;
      _loc2_.soundEngine.playSound("buttonclick.wav");
      var _loc6_ = SharedObject.getLocal(_loc5_,"/");
      _loc2_.savedata = _loc6_.data.savedata;
      _loc2_.currentDay = _loc2_.savedata.currentday;
      _loc2_.totalTips = _loc2_.savedata.totaltips;
      _loc2_.myRank = _loc2_.savedata.rank;
      _loc2_.username = _loc2_.savedata.username;
      _loc2_.playerid = _loc2_.savedata.playerid;
      var _loc4_ = 0;
      var _loc3_ = 2;
      while(_loc3_ <= _loc2_.myRank)
      {
         _loc4_ += _loc3_;
         _loc3_ = _loc3_ + 1;
      }
      _loc2_.lastRankLimit = _loc4_ * _loc2_.rankMultiplier;
      trace("Loaded - myRank: " + _loc2_.myRank);
      trace("MyRankLimit: " + _loc2_.lastRankLimit);
      if(_loc2_.savedata.customerdata != undefined)
      {
         _loc2_.customerdata = _loc2_.savedata.customerdata;
      }
      else
      {
         _loc2_.createNewCustomerData();
      }
      if(_loc2_.savedata.currentday == 1)
      {
         _loc2_.training = true;
      }
      else
      {
         _loc2_.training = false;
      }
      _loc2_.startGame();
   }
   function enterUserName(whichslot)
   {
      var _loc2_ = this;
      _loc2_.username = "Slot " + whichslot;
      _loc2_.startNewGame(whichslot);
   }
   function cheatCodes(whichslot)
   {
      var _loc2_ = this;
      var _loc4_ = false;
      if(_loc2_.savedata.username == "almostpapa")
      {
         trace("*****  CHEAT CODE:  almostpapa *******");
         var _loc3_ = 1;
         while(_loc3_ <= 34)
         {
            _loc2_.savedata.customerdata[_loc3_][6] = 3;
            _loc2_.savedata.customerdata[_loc3_][0] = 1;
            _loc2_.savedata.customerdata[_loc3_][3] = 1;
            _loc2_.savedata.customerdata[_loc3_][4] = 15;
            _loc2_.savedata.customerdata[_loc3_][5] = 4;
            _loc3_ = _loc3_ + 1;
         }
         _loc2_.savedata.customerdata[35][6] = 2;
         _loc2_.savedata.customerdata[35][0] = 1;
         _loc2_.savedata.customerdata[35][3] = 1;
         _loc2_.savedata.customerdata[35][4] = 13;
         _loc2_.savedata.customerdata[35][5] = 3;
         _loc2_.savedata.totaltips = 247000;
         _loc2_.savedata.rank = 30;
         _loc2_.savedata.lastranklimit = 232000;
         _loc2_.savedata.currentday = 99;
         _loc4_ = true;
      }
      if(_loc4_)
      {
         var _loc6_ = "RoyPizzeriaSlot" + whichslot;
         var _loc5_ = SharedObject.getLocal(_loc6_,"/");
         _loc5_.data.savedata = _loc2_.savedata;
         _loc5_.data.flush();
         _loc2_.training = false;
         _loc2_.currentDay = _loc2_.savedata.currentday;
         _loc2_.totalTips = _loc2_.savedata.totaltips;
         _loc2_.myRank = _loc2_.savedata.rank;
         _loc2_.lastRankLimit = _loc2_.savedata.lastranklimit;
         _loc2_.username = _loc2_.savedata.username;
         _loc2_.playerid = _loc2_.savedata.playerid;
         if(_loc2_.savedata.customerdata != undefined)
         {
            _loc2_.customerdata = _loc2_.savedata.customerdata;
         }
      }
   }
   function startNewGame(whichslot)
   {
      var _loc2_ = this;
      var _loc5_ = "RoyPizzeriaSlot" + whichslot;
      _loc2_.whichSaveSlot = whichslot;
      var _loc3_ = SharedObject.getLocal(_loc5_,"/");
      _loc2_.playerid = _loc2_.generatePlayerID();
      _loc2_.savedata.totaltips = 0;
      _loc2_.savedata.rank = 1;
      _loc2_.savedata.currentday = 1;
      _loc2_.savedata.playerid = _loc2_.playerid;
      _loc2_.savedata.username = _loc2_.username;
      _loc2_.createNewCustomerData();
      _loc2_.savedata.customerdata = _loc2_.customerdata;
      _loc3_.data.savedata = _loc2_.savedata;
      _loc3_.data.flush();
      _loc2_.training = true;
      _loc2_.cheatCodes(whichslot);
      _loc2_.startGame();
   }
   function saveProgress()
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.whichSaveSlot;
      var _loc5_ = "RoyPizzeriaSlot" + _loc4_;
      var _loc3_ = SharedObject.getLocal(_loc5_,"/");
      _loc2_.savedata.totaltips = _loc2_.totalTips;
      _loc2_.savedata.rank = _loc2_.myRank;
      _loc2_.savedata.currentday = _loc2_.currentDay + 1;
      _loc2_.savedata.customerdata = _loc2_.customerdata;
      _loc3_.data.savedata = _loc2_.savedata;
      _loc3_.data.flush();
   }
   function generatePlayerID()
   {
      var _loc8_ = this;
      var _loc5_ = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
      var _loc7_ = 8;
      var _loc4_ = "";
      var _loc6_ = _loc5_.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc7_)
      {
         var _loc3_ = _loc5_[random(_loc6_)];
         _loc4_ += _loc3_;
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   function pauseUpdate(msg)
   {
   }
}
