class roygame.models.NewCustomerScreen
{
   var customernum = 1;
   function NewCustomerScreen(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.gameclip = _loc2_.gameObj.clip;
      if(_loc2_.gameObj.showNoPapa)
      {
         _loc2_.setupNoPapaScreen();
      }
      else
      {
         _loc2_.setupScreen();
      }
   }
   function buildCustomer()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.customernum;
      _loc2_.clip.circleMC.customerMC.body.attachMovie("customer" + _loc3_ + "_body","clip",1);
      _loc2_.clip.circleMC.customerMC.head.attachMovie("customer" + _loc3_ + "_head","clip",1);
      _loc2_.clip.circleMC.customerMC.eyes.attachMovie("customer" + _loc3_ + "_eyes","clip",1);
      _loc2_.clip.circleMC.customerMC.mouth.attachMovie("customer" + _loc3_ + "_mouth","clip",1);
      _loc2_.clip.circleMC.customerMC.neck.attachMovie("customer" + _loc3_ + "_neck","clip",1);
      _loc2_.clip.circleMC.customerMC.hair.attachMovie("customer" + _loc3_ + "_hair","clip",1);
      _loc2_.clip.circleMC.customerMC.back_hair.attachMovie("customer" + _loc3_ + "_back_hair","clip",1);
      _loc2_.clip.circleMC.customerMC.front_shoe.attachMovie("customer" + _loc3_ + "_foot","clip",1);
      _loc2_.clip.circleMC.customerMC.back_shoe.attachMovie("customer" + _loc3_ + "_foot","clip",1);
      _loc2_.clip.circleMC.customerMC.fronthand.attachMovie("customer" + _loc3_ + "_hand","clip",1);
      _loc2_.clip.circleMC.customerMC.backhand.attachMovie("customer" + _loc3_ + "_hand2","clip",1);
      _loc2_.clip.circleMC.customerMC.front_upperarm.attachMovie("customer" + _loc3_ + "_upperarm","clip",1);
      _loc2_.clip.circleMC.customerMC.back_upperarm.attachMovie("customer" + _loc3_ + "_upperarm","clip",1);
      _loc2_.clip.circleMC.customerMC.front_forearm.attachMovie("customer" + _loc3_ + "_forearm","clip",1);
      _loc2_.clip.circleMC.customerMC.back_forearm.attachMovie("customer" + _loc3_ + "_forearm","clip",1);
      _loc2_.clip.circleMC.customerMC.gotoAndPlay("overjoyed");
      _loc2_.clip.circleMC.customerMC._xscale = 80;
      _loc2_.clip.circleMC.customerMC._yscale = 80;
   }
   function setupNoPapaScreen()
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.gameObj;
      _loc2_.clip = _loc2_.gameclip.attachMovie("newcustomer_nopapa","newcustomer_screen",10);
      _loc2_.gameObj.soundEngine.switchMusic(0);
      var _loc3_ = "endofday.wav";
      _loc2_.gameObj.soundEngine.playSound(_loc3_,0,2);
      _loc2_.startSealAnimation();
   }
   function startSealAnimation()
   {
      var _loc2_ = this;
      trace("Show seal");
      _loc2_.clip.sealMC.seal.gotoAndStop(3);
      _loc2_.clip.sealMC.gotoAndPlay(2);
   }
   function setupScreen()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      _loc2_.clip = _loc2_.gameclip.attachMovie("newcustomer_screen","newcustomer_screen",10);
      _loc2_.customernum = _loc3_.newCustomerNum;
      var _loc4_ = _loc2_.customernum;
      var _loc5_ = _loc3_.customerdata[_loc4_][1];
      trace("My customer num: " + _loc4_);
      trace("My customer name: " + _loc5_);
      _loc2_.buildCustomer();
      _loc2_.clip.circleMC.customername.text = _loc5_;
      _loc2_.gameObj.soundEngine.switchMusic(0);
      var _loc6_ = "customer_overjoyed.wav";
      _loc2_.gameObj.soundEngine.playSound(_loc6_,0,2);
      _loc3_.customerdata[_loc4_][0] = 1;
      _loc3_.customerdata[_loc4_][3] = _loc3_.currentDay;
   }
   function endAnimation()
   {
      var _loc2_ = this;
      _loc2_.gameObj.switchModes("startofday","allow");
   }
   function pauseUpdate(msg)
   {
   }
}
