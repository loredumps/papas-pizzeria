var _mochiads_game_id = "c9a9907b6b748acd";
mochi.MochiServices.connect("c9a9907b6b748acd");
_root.attachMovie("mainmask","mainmask",700000);
var progbarwidth = 516;
_root.progbar.onEnterFrame = function()
{
   var _loc5_ = _root.getBytesLoaded();
   var _loc4_ = _root.getBytesTotal();
   var _loc3_ = _loc5_ / _loc4_;
   var _loc2_ = Math.round(progbarwidth * (1 - _loc3_));
   _root.progbar.cover._width = _loc2_;
   _root.progbar.cover._x = progbarwidth - _loc2_ + 1;
   if(_loc3_ == 1)
   {
      _root.gotoAndPlay(2);
   }
};
CoolmathSDK2.init();
stop();
