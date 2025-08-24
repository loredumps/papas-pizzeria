class roygame.models.CustomerFileScreen
{
   var mynum;
   var _x;
   var _y;
   var customernum = 1;
   function CustomerFileScreen(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.gameclip = _loc2_.gameObj.clip;
      _loc2_.setupScreen();
   }
   function buildCustomerPoloroid(num, starred)
   {
      var _loc2_ = this;
      var _loc4_ = "customer" + num;
      _loc2_.clip.profilecard.poloroid_bg.customerMC.eyes.clip.removeMovieClip();
      _loc2_.clip.profilecard.poloroid_bg.customerMC.mouth.clip.removeMovieClip();
      _loc2_.clip.profilecard.poloroid_bg.customerMC.hair.clip.removeMovieClip();
      _loc2_.clip.profilecard.poloroid_bg.customerMC.back_hair.clip.removeMovieClip();
      _loc2_.clip.profilecard.poloroid_bg.customerMC.body.attachMovie("customer" + num + "_body","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.head.attachMovie("customer" + num + "_head","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.eyes.attachMovie("customer" + num + "_eyes","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.mouth.attachMovie("customer" + num + "_mouth","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.neck.attachMovie("customer" + num + "_neck","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.hair.attachMovie("customer" + num + "_hair","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.back_hair.attachMovie("customer" + num + "_back_hair","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.front_shoe.attachMovie("customer" + num + "_foot","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.back_shoe.attachMovie("customer" + num + "_foot","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.fronthand.attachMovie("customer" + num + "_hand","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.backhand.attachMovie("customer" + num + "_hand2","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.front_upperarm.attachMovie("customer" + num + "_upperarm","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.back_upperarm.attachMovie("customer" + num + "_upperarm","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.front_forearm.attachMovie("customer" + num + "_forearm","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.back_forearm.attachMovie("customer" + num + "_forearm","clip",1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.eyes.clip.gotoAndStop(1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.mouth.clip.gotoAndStop(1);
      _loc2_.clip.profilecard.poloroid_bg.customerMC.gotoAndStop(1);
      if(starred)
      {
         _loc2_.clip.profilecard.poloroid_bg.customerMC.gotoAndStop("overjoyedposter");
      }
      _loc2_.clip.profilecard.poloroid_bg.gotoAndStop(num);
      _loc2_.clip.profilecard.poloroid_bg.setMask(_loc2_.clip.profilecard.poloroid_mask);
   }
   function setupScreen()
   {
      var screen = this;
      var gameObj = screen.gameObj;
      screen.clip = screen.gameclip.attachMovie("customerfile_screen","customerfile_screen",50005);
      screen.buildThumbs();
      screen.gameObj.soundEngine.switchMusic(5);
      screen.clip.close_btn.onPress = function()
      {
         gameObj.pauseManager.pauseGame();
      };
      screen.clip.main_btn.onPress = function()
      {
         screen.flipToMain();
      };
      screen.clip.big_btn.onPress = function()
      {
         screen.flipToMain();
      };
      screen.clip.buttonguard.onPress = function()
      {
      };
      screen.clip.buttonguard.useHandCursor = false;
   }
   function buildThumbs()
   {
      var screen = this;
      var _loc3_ = screen.gameObj;
      var _loc7_ = _loc3_.customerdata.length - 1;
      var _loc2_ = 1;
      while(_loc2_ <= _loc7_)
      {
         var _loc4_ = _loc3_.customerdata[_loc2_][0];
         var _loc5_ = _loc3_.customerdata[_loc2_][3];
         var _loc6_ = _loc3_.customerdata[_loc2_][6];
         if(_loc4_ && _loc5_ > 0)
         {
            screen.clip.maincard["btn" + _loc2_]._alpha = 0;
            screen.clip.maincard["btn" + _loc2_].mynum = _loc2_;
            screen.clip.maincard["btn" + _loc2_].onPress = function()
            {
               screen.flipToProfile(this.mynum);
            };
            screen.clip.maincard["btn" + _loc2_].onRollOver = function()
            {
               screen.clip.maincard.rolloverMC._x = this._x;
               screen.clip.maincard.rolloverMC._y = this._y;
            };
            if(_loc6_)
            {
               screen.clip.maincard["star" + _loc2_]._visible = true;
            }
            else
            {
               screen.clip.maincard["star" + _loc2_]._visible = false;
            }
         }
         _loc2_ = _loc2_ + 1;
      }
      trace("Built " + _loc7_ + " customers..");
   }
   function flipToProfile(which)
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      var _loc8_ = _loc3_.customerdata[which][1];
      var _loc7_ = _loc3_.customerdata[which][2];
      var _loc6_ = _loc3_.customerdata[which][3];
      var _loc9_ = _loc3_.customerdata[which][4];
      var _loc5_ = _loc3_.customerdata[which][6];
      _loc2_.clip.profilecard.customername.text = _loc8_;
      _loc2_.clip.profilecard.toppings.text = _loc7_;
      _loc2_.clip.profilecard.pizzas.text = _loc9_;
      _loc2_.clip.profilecard.day.text = _loc6_;
      if(_loc5_ > 0)
      {
         _loc2_.clip.profilecard.sealMC._visible = true;
         _loc2_.clip.profilecard.sealMC.gotoAndStop(_loc5_);
      }
      else
      {
         _loc2_.clip.profilecard.sealMC._visible = false;
      }
      _loc2_.buildCustomerPoloroid(which,_loc5_);
      _loc2_.clip.gotoAndPlay("flipprofile");
   }
   function flipToMain()
   {
      var _loc2_ = this;
      _loc2_.clip.gotoAndPlay("flipmain");
   }
   function pauseUpdate(msg)
   {
   }
}
