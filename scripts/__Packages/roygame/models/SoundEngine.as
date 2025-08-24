class roygame.models.SoundEngine
{
   var isMute = false;
   var currentTrack = 1;
   var fadeSpeed = 100;
   var fadeAmount = 10;
   var maxvolume = 70;
   function SoundEngine(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.setupEngine();
   }
   function setupEngine()
   {
      var _loc3_ = this;
      _loc3_.clip = _root.createEmptyMovieClip("soundMCs",10000);
      var _loc11_ = _loc3_.clip.createEmptyMovieClip("clip1mc",1);
      var _loc10_ = _loc3_.clip.createEmptyMovieClip("clip2mc",2);
      var _loc9_ = _loc3_.clip.createEmptyMovieClip("clip3mc",3);
      var _loc8_ = _loc3_.clip.createEmptyMovieClip("clip4mc",4);
      var _loc7_ = _loc3_.clip.createEmptyMovieClip("clip5mc",5);
      var _loc6_ = _loc3_.clip.createEmptyMovieClip("clip6mc",6);
      var _loc5_ = _loc3_.clip.createEmptyMovieClip("clip7mc",7);
      var _loc4_ = _loc3_.clip.createEmptyMovieClip("clip8mc",8);
      _loc3_.Track1 = new Sound(_loc11_);
      _loc3_.Track2 = new Sound(_loc10_);
      _loc3_.Track3 = new Sound(_loc9_);
      _loc3_.Track4 = new Sound(_loc8_);
      _loc3_.Track5 = new Sound(_loc7_);
      _loc3_.Track6 = new Sound(_loc6_);
      _loc3_.SoundFX = new Sound(_loc5_);
      _loc3_.SoundFX2 = new Sound(_loc4_);
   }
   function playSound(which, loop, track)
   {
      var _loc3_ = this;
      var _loc2_ = undefined;
      if(track == 2)
      {
         _loc2_ = _loc3_.SoundFX2;
      }
      else
      {
         _loc2_ = _loc3_.SoundFX;
      }
      _loc2_.stop();
      if(which != 0)
      {
         _loc2_.attachSound(which);
         if(loop)
         {
            _loc2_.start(0,1000);
         }
         else
         {
            _loc2_.start();
         }
      }
   }
   function muteSound()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj.hudObj;
      if(!_loc2_.isMute)
      {
         _loc2_.SoundFX.setVolume(0);
         _loc2_.SoundFX2.setVolume(0);
         _loc2_.Track1.setVolume(0);
         _loc2_.Track2.setVolume(0);
         _loc2_.Track3.setVolume(0);
         _loc2_.Track4.setVolume(0);
         _loc2_.Track5.setVolume(0);
         _loc2_.Track6.setVolume(0);
         _loc2_.isMute = true;
         _loc3_.clip.sound_btn.gotoAndStop("off");
      }
      else
      {
         _loc2_.SoundFX.setVolume(100);
         _loc2_.SoundFX2.setVolume(100);
         _loc2_.Track1.setVolume(0);
         _loc2_.Track2.setVolume(0);
         _loc2_.Track3.setVolume(0);
         _loc2_.Track4.setVolume(0);
         _loc2_.Track5.setVolume(0);
         _loc2_.Track6.setVolume(0);
         _loc2_["Track" + _loc2_.currentTrack].setVolume(_loc2_.maxvolume);
         _loc2_.isMute = false;
         _loc3_.clip.sound_btn.gotoAndStop("on");
      }
   }
   function startMainMenuMusic()
   {
      var engine = this;
      trace("Let\'s play the mainmenu music!");
      clearInterval(engine.fadeCycle);
      engine.Track1.stop();
      engine.Track2.stop();
      engine.Track3.stop();
      engine.Track4.stop();
      engine.Track5.stop();
      engine.Track6.stop();
      engine.SoundFX.stop();
      engine.SoundFX2.stop();
      engine.Track1.attachSound("toppingscreen_music");
      engine.currentTrack = 1;
      engine.Track1.setVolume(0);
      engine.Track2.setVolume(0);
      engine.Track3.setVolume(0);
      engine.Track4.setVolume(0);
      engine.Track5.setVolume(0);
      engine.Track6.setVolume(0);
      if(!engine.isMute)
      {
         engine.SoundFX.setVolume(100);
         engine.SoundFX2.setVolume(60);
         engine["Track" + engine.currentTrack].setVolume(engine.maxvolume);
      }
      else
      {
         trace("I want to play the mainmenu music.... but I\'m muted!");
      }
      engine.Track1.start();
      engine.Track1.onSoundComplete = function()
      {
         engine.Track1.start();
      };
   }
   function startGameMusic()
   {
      var engine = this;
      clearInterval(engine.fadeCycle);
      engine.Track1.stop();
      engine.Track2.stop();
      engine.Track3.stop();
      engine.Track4.stop();
      engine.Track5.stop();
      engine.Track6.stop();
      engine.SoundFX.stop();
      engine.SoundFX2.stop();
      engine.Track1.attachSound("takeorder_music");
      engine.Track2.attachSound("toppingscreen_music");
      engine.Track3.attachSound("bakingscreen_music");
      engine.Track4.attachSound("cuttingscreen_music");
      engine.Track5.attachSound("orderscreen_music");
      engine.Track6.attachSound("justguitar_music");
      engine.currentTrack = 1;
      engine.Track1.setVolume(0);
      engine.Track2.setVolume(0);
      engine.Track3.setVolume(0);
      engine.Track4.setVolume(0);
      engine.Track5.setVolume(0);
      engine.Track6.setVolume(0);
      if(!engine.isMute)
      {
         engine.SoundFX.setVolume(100);
         engine.SoundFX2.setVolume(100);
         engine["Track" + engine.currentTrack].setVolume(engine.maxvolume);
      }
      engine.Track1.start();
      engine.Track2.start();
      engine.Track3.start();
      engine.Track4.start();
      engine.Track5.start();
      engine.Track6.start();
      engine.Track1.onSoundComplete = function()
      {
         engine.Track1.start();
      };
      engine.Track2.onSoundComplete = function()
      {
         engine.Track2.start();
      };
      engine.Track3.onSoundComplete = function()
      {
         engine.Track3.start();
      };
      engine.Track4.onSoundComplete = function()
      {
         engine.Track4.start();
      };
      engine.Track5.onSoundComplete = function()
      {
         engine.Track5.start();
      };
      engine.Track6.onSoundComplete = function()
      {
         engine.Track6.start();
      };
   }
   function switchMusic(which)
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.currentTrack;
      var _loc4_ = which;
      if(!_loc2_.isMute)
      {
         if(_loc4_ != _loc3_)
         {
            _loc2_.currentTrack = which;
            clearInterval(_loc2_.fadeCycle);
            _loc2_.fadeCycle = setInterval(this,"fadeMusic",_loc2_.fadeSpeed,_loc4_,_loc3_);
         }
      }
      else
      {
         _loc2_.currentTrack = which;
      }
   }
   function fadeMusic(raisetrack, lowertrack)
   {
      var _loc2_ = this;
      if(raisetrack != 0)
      {
         var _loc9_ = _loc2_["Track" + raisetrack].getVolume();
         var _loc5_ = _loc9_ + _loc2_.fadeAmount;
         if(_loc5_ > _loc2_.maxvolume)
         {
            _loc5_ = _loc2_.maxvolume;
         }
         _loc2_["Track" + raisetrack].setVolume(_loc5_);
      }
      if(lowertrack != 0)
      {
         var _loc10_ = _loc2_["Track" + lowertrack].getVolume();
         var _loc6_ = _loc10_ - _loc2_.fadeAmount;
         if(_loc6_ < 0)
         {
            _loc6_ = 0;
         }
         _loc2_["Track" + lowertrack].setVolume(_loc6_);
      }
      var _loc7_ = false;
      var _loc8_ = false;
      if(raisetrack == 0)
      {
         _loc7_ = true;
      }
      else if(_loc2_["Track" + raisetrack].getVolume() == _loc2_.maxvolume)
      {
         _loc7_ = true;
      }
      if(lowertrack == 0)
      {
         _loc8_ = true;
      }
      else if(_loc2_["Track" + lowertrack].getVolume() == 0)
      {
         _loc8_ = true;
      }
      if(_loc7_ && _loc8_)
      {
         _loc2_.Track1.setVolume(0);
         _loc2_.Track2.setVolume(0);
         _loc2_.Track3.setVolume(0);
         _loc2_.Track4.setVolume(0);
         _loc2_.Track5.setVolume(0);
         _loc2_.Track6.setVolume(0);
         _loc2_["Track" + lowertrack].setVolume(0);
         _loc2_["Track" + raisetrack].setVolume(_loc2_.maxvolume);
         clearInterval(_loc2_.fadeCycle);
      }
      if(_loc2_.isMute)
      {
         _loc2_.Track1.setVolume(0);
         _loc2_.Track2.setVolume(0);
         _loc2_.Track3.setVolume(0);
         _loc2_.Track4.setVolume(0);
         _loc2_.Track5.setVolume(0);
         _loc2_.Track6.setVolume(0);
         clearInterval(_loc2_.fadeCycle);
      }
   }
   function pauseUpdate(msg)
   {
   }
}
