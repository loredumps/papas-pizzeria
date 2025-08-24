class roygame.models.HighScores
{
   var scoresObject;
   function HighScores(gameobj)
   {
      var _loc2_ = this;
      _loc2_.gameObj = gameobj;
      _loc2_.setupScreen();
   }
   function setupScreen()
   {
      var _loc2_ = this;
      var game = _loc2_.gameObj;
      _loc2_.clip = game.clip.attachMovie("highscores","highscores",100000);
      _loc2_.clip.board.continue_btn.onPress = function()
      {
         game.nextLevel();
      };
      _loc2_.clip.board.quit_btn.onPress = function()
      {
         game.quitGame();
      };
      game.soundEngine.switchMusic(5);
      _loc2_.setupScores();
      _loc2_.submitScore();
   }
   function setupScores()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
   }
   function submitScore()
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_.gameObj;
      _loc3_.clip.board.enternameMC.gotoAndStop("sending");
      var _loc5_ = _loc2_.username;
      var _loc4_ = _loc2_.totalTips;
      var _loc19_ = _loc2_.playerid;
      _loc3_.currentscores = {pname:_loc5_,pscore:_loc4_,drank:0,wrank:0,mrank:0,arank:0};
      _loc3_.leaderboard = {dscores:0,wscores:0,mscores:0,ascores:0};
      _loc3_.leaderboardtext = {dnames:"",dscores:"",ddates:"",wnames:"",wscores:"",wdates:"",mnames:"",mscores:"",mdates:"",anames:"",ascores:"",adates:""};
      mochi.MochiScores.setBoardID("ce5b4a18ca9ad91a");
      mochi.MochiScores.submit(_loc2_.totalTips,_loc2_.username,this,"onScoresReceived");
   }
   function onScoresReceived(args)
   {
      var _loc2_ = this;
      var _loc4_ = _loc2_.gameObj;
      if(args.scores != null)
      {
         trace("Scores received!");
         _loc2_.scoresObject = mochi.MochiScores.scoresArrayToObjects(args.scores);
         _loc2_.clip.board.gotoAndPlay("ad");
      }
      else if(args.error)
      {
         trace("Error: " + args.errorCode);
         _loc2_.clip.board.enternameMC.gotoAndStop("error");
      }
   }
   function setupScoresDisplay()
   {
      var _loc2_ = this;
      var _loc11_ = _loc2_.gameObj;
      _loc2_.scoredisplaytype = "daily";
      _loc2_.currentscores.drank = _loc2_.scoresObject.places.daily;
      _loc2_.currentscores.wrank = _loc2_.scoresObject.places.weekly;
      _loc2_.currentscores.mrank = _loc2_.scoresObject.places.monthly;
      _loc2_.currentscores.arank = _loc2_.scoresObject.places.alltime;
      var _loc10_ = _loc2_.parseScore(String(_loc2_.currentscores.pscore));
      _loc2_.currentscores.pscore = _loc10_;
      var _loc3_ = undefined;
      var _loc4_ = undefined;
      var _loc9_ = 10;
      var _loc6_ = Math.min(this.scoresObject.daily.length,_loc9_);
      var _loc5_ = Math.min(this.scoresObject.weekly.length,_loc9_);
      var _loc7_ = Math.min(this.scoresObject.monthly.length,_loc9_);
      var _loc8_ = Math.min(this.scoresObject.alltime.length,_loc9_);
      _loc4_ = 0;
      while(_loc4_ < _loc6_)
      {
         _loc3_ = this.scoresObject.daily[_loc4_];
         _loc2_.leaderboardtext.dnames += _loc3_.name + "\n";
         _loc2_.leaderboardtext.dscores += _loc2_.parseScore(_loc3_.score) + "\n";
         _loc2_.leaderboardtext.ddates += _loc2_.parseTimestamp(_loc3_.timestamp) + "\n";
         _loc4_ = _loc4_ + 1;
      }
      _loc4_ = 0;
      while(_loc4_ < _loc5_)
      {
         _loc3_ = this.scoresObject.weekly[_loc4_];
         _loc2_.leaderboardtext.wnames += _loc3_.name + "\n";
         _loc2_.leaderboardtext.wscores += _loc2_.parseScore(_loc3_.score) + "\n";
         _loc2_.leaderboardtext.wdates += _loc2_.parseTimestamp(_loc3_.timestamp) + "\n";
         _loc4_ = _loc4_ + 1;
      }
      _loc4_ = 0;
      while(_loc4_ < _loc7_)
      {
         _loc3_ = this.scoresObject.monthly[_loc4_];
         _loc2_.leaderboardtext.mnames += _loc3_.name + "\n";
         _loc2_.leaderboardtext.mscores += _loc2_.parseScore(_loc3_.score) + "\n";
         _loc2_.leaderboardtext.mdates += _loc2_.parseTimestamp(_loc3_.timestamp) + "\n";
         _loc4_ = _loc4_ + 1;
      }
      _loc4_ = 0;
      while(_loc4_ < _loc8_)
      {
         _loc3_ = this.scoresObject.alltime[_loc4_];
         _loc2_.leaderboardtext.anames += _loc3_.name + "\n";
         _loc2_.leaderboardtext.ascores += _loc2_.parseScore(_loc3_.score) + "\n";
         _loc2_.leaderboardtext.adates += _loc2_.parseTimestamp(_loc3_.timestamp) + "\n";
         _loc4_ = _loc4_ + 1;
      }
      _loc2_.clip.board.viewboardMC.name_txt.text = _loc2_.leaderboardtext.dnames;
      _loc2_.clip.board.viewboardMC.score_txt.text = _loc2_.leaderboardtext.dscores;
      _loc2_.clip.board.viewboardMC.date_txt.text = _loc2_.leaderboardtext.ddates;
      _loc2_.clip.board.viewboardMC.current.name_txt.text = _loc2_.currentscores.pname;
      _loc2_.clip.board.viewboardMC.current.score_txt.text = _loc2_.currentscores.pscore;
      _loc2_.clip.board.viewboardMC.current.rank_txt.text = _loc2_.currentscores.drank;
   }
   function switchScoreDisplay()
   {
      var _loc2_ = this;
      var _loc3_ = _loc2_.gameObj;
      trace("Switching the score display to: " + _loc2_.scoredisplaytype);
      if(_loc2_.scoredisplaytype == "daily")
      {
         _loc2_.clip.board.viewboardMC.name_txt.text = _loc2_.leaderboardtext.dnames;
         _loc2_.clip.board.viewboardMC.score_txt.text = _loc2_.leaderboardtext.dscores;
         _loc2_.clip.board.viewboardMC.date_txt.text = _loc2_.leaderboardtext.ddates;
         _loc2_.clip.board.viewboardMC.current.name_txt.text = _loc2_.currentscores.pname;
         _loc2_.clip.board.viewboardMC.current.score_txt.text = _loc2_.currentscores.pscore;
         _loc2_.clip.board.viewboardMC.current.rank_txt.text = _loc2_.currentscores.drank;
      }
      else if(_loc2_.scoredisplaytype == "weekly")
      {
         _loc2_.clip.board.viewboardMC.name_txt.text = _loc2_.leaderboardtext.wnames;
         _loc2_.clip.board.viewboardMC.score_txt.text = _loc2_.leaderboardtext.wscores;
         _loc2_.clip.board.viewboardMC.date_txt.text = _loc2_.leaderboardtext.wdates;
         _loc2_.clip.board.viewboardMC.current.name_txt.text = _loc2_.currentscores.pname;
         _loc2_.clip.board.viewboardMC.current.score_txt.text = _loc2_.currentscores.pscore;
         _loc2_.clip.board.viewboardMC.current.rank_txt.text = _loc2_.currentscores.wrank;
      }
      else if(_loc2_.scoredisplaytype == "monthly")
      {
         _loc2_.clip.board.viewboardMC.name_txt.text = _loc2_.leaderboardtext.mnames;
         _loc2_.clip.board.viewboardMC.score_txt.text = _loc2_.leaderboardtext.mscores;
         _loc2_.clip.board.viewboardMC.date_txt.text = _loc2_.leaderboardtext.mdates;
         _loc2_.clip.board.viewboardMC.current.name_txt.text = _loc2_.currentscores.pname;
         _loc2_.clip.board.viewboardMC.current.score_txt.text = _loc2_.currentscores.pscore;
         _loc2_.clip.board.viewboardMC.current.rank_txt.text = _loc2_.currentscores.mrank;
      }
      else if(_loc2_.scoredisplaytype == "alltime")
      {
         _loc2_.clip.board.viewboardMC.name_txt.text = _loc2_.leaderboardtext.anames;
         _loc2_.clip.board.viewboardMC.score_txt.text = _loc2_.leaderboardtext.ascores;
         _loc2_.clip.board.viewboardMC.date_txt.text = _loc2_.leaderboardtext.adates;
         _loc2_.clip.board.viewboardMC.current.name_txt.text = _loc2_.currentscores.pname;
         _loc2_.clip.board.viewboardMC.current.score_txt.text = _loc2_.currentscores.pscore;
         _loc2_.clip.board.viewboardMC.current.rank_txt.text = _loc2_.currentscores.arank;
      }
   }
   function parseScore(score)
   {
      var _loc4_ = score / 100;
      var _loc2_ = Math.floor(_loc4_);
      var _loc1_ = score - _loc2_ * 100;
      var _loc6_ = _loc1_ / 100;
      if(_loc1_ < 10)
      {
         _loc1_ = "0" + _loc1_;
      }
      else if(_loc1_ == 0)
      {
         _loc1_ = "00";
      }
      var _loc3_ = "$" + _loc2_ + "." + _loc1_;
      if(score <= 0)
      {
         _loc3_ = " $0.00 ";
      }
      return _loc3_;
   }
   function parseDate(date)
   {
      var _loc3_ = undefined;
      var _loc5_ = date.slice(0,2);
      var _loc1_ = date.slice(2,4);
      var _loc4_ = date.slice(4);
      var _loc6_ = [0,"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
      var _loc7_ = _loc6_[parseInt(_loc1_)];
      _loc3_ = _loc1_ + "/" + _loc4_ + "/" + _loc5_;
      return _loc3_;
   }
   function parseTimestamp(stamp)
   {
      var _loc4_ = new Date(stamp);
      var _loc6_ = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
      var _loc3_ = _loc4_.getYear() - 100;
      var _loc1_ = _loc4_.getMonth() + 1;
      var _loc2_ = _loc4_.getDate();
      if(_loc3_ < 10)
      {
         _loc3_ = String("0" + _loc3_);
      }
      if(_loc1_ < 10)
      {
         _loc1_ = String("0" + _loc1_);
      }
      if(_loc2_ < 10)
      {
         _loc2_ = String("0" + _loc2_);
      }
      var _loc5_ = String(_loc1_ + "/" + _loc2_ + "/" + _loc3_);
      return _loc5_;
   }
   function pauseUpdate(msg)
   {
   }
}
