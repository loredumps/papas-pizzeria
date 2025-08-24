class mochi.MochiServices
{
   var isLoading;
   var startTime;
   var waitInterval;
   var _callbacks;
   static var _id;
   static var _container;
   static var _clip;
   static var _sendChannelName;
   static var _rcvChannelName;
   static var onError;
   static var _listenChannel;
   static var _rcvChannel;
   static var _loader;
   static var _loaderListener;
   static var _sendChannel;
   static var _gatewayURL = "http://www.mochiads.com/static/lib/services/services.swf";
   static var _listenChannelName = "__mochiservices";
   static var _connecting = false;
   static var _connected = false;
   function MochiServices()
   {
   }
   static function get id()
   {
      return mochi.MochiServices._id;
   }
   static function get clip()
   {
      return mochi.MochiServices._container;
   }
   static function get childClip()
   {
      return mochi.MochiServices._clip;
   }
   static function getVersion()
   {
      return "1.32";
   }
   static function allowDomains(server)
   {
      var _loc1_ = server.split("/")[2].split(":")[0];
      if(System.security)
      {
         if(System.security.allowDomain)
         {
            System.security.allowDomain("*");
            System.security.allowDomain(_loc1_);
         }
         if(System.security.allowInsecureDomain)
         {
            System.security.allowInsecureDomain("*");
            System.security.allowInsecureDomain(_loc1_);
         }
      }
      return _loc1_;
   }
   static function get isNetworkAvailable()
   {
      if(System.security)
      {
         var _loc1_ = System.security;
         if(_loc1_.sandboxType == "localWithFile")
         {
            return false;
         }
      }
      return true;
   }
   static function set comChannelName(val)
   {
      if(val != undefined)
      {
         if(val.length > 3)
         {
            mochi.MochiServices._sendChannelName = val + "_fromgame";
            mochi.MochiServices._rcvChannelName = val;
            mochi.MochiServices.initComChannels();
         }
      }
   }
   static function get connected()
   {
      return mochi.MochiServices._connected;
   }
   static function connect(id, clip, onError)
   {
      if(!mochi.MochiServices._connected && mochi.MochiServices._clip == undefined)
      {
         trace("MochiServices Connecting...");
         mochi.MochiServices._connecting = true;
         mochi.MochiServices.init(id,clip);
      }
      if(onError != undefined)
      {
         mochi.MochiServices.onError = onError;
      }
      else if(mochi.MochiServices.onError == undefined)
      {
         mochi.MochiServices.onError = function(errorCode)
         {
            trace(errorCode);
         };
      }
   }
   static function disconnect()
   {
      if(mochi.MochiServices._connected || mochi.MochiServices._connecting)
      {
         mochi.MochiServices._connecting = mochi.MochiServices._connected = false;
         mochi.MochiServices.flush(true);
         if(mochi.MochiServices._clip != undefined)
         {
            mochi.MochiServices._clip.removeMovieClip();
            delete mochi.MochiServices._clip;
         }
         mochi.MochiServices._listenChannel.close();
         mochi.MochiServices._rcvChannel.close();
      }
   }
   static function init(id, clip)
   {
      mochi.MochiServices._id = id;
      if(clip != undefined)
      {
         mochi.MochiServices._container = clip;
      }
      else
      {
         mochi.MochiServices._container = _root;
      }
      mochi.MochiServices.loadCommunicator(id,mochi.MochiServices._container);
   }
   static function loadCommunicator(id, clip)
   {
      var _loc2_ = "_mochiservices_com_" + id;
      if(mochi.MochiServices._clip != null)
      {
         return mochi.MochiServices._clip;
      }
      if(!mochi.MochiServices.isNetworkAvailable)
      {
         return null;
      }
      mochi.MochiServices.allowDomains(mochi.MochiServices._gatewayURL);
      mochi.MochiServices._clip = clip.createEmptyMovieClip(_loc2_,10336,false);
      mochi.MochiServices._loader = new MovieClipLoader();
      if(mochi.MochiServices._loaderListener.waitInterval != null)
      {
         clearInterval(mochi.MochiServices._loaderListener.waitInterval);
      }
      mochi.MochiServices._loaderListener = {};
      mochi.MochiServices._loaderListener.onLoadError = function(target_mc, errorCode, httpStatus)
      {
         trace("MochiServices could not load.");
         mochi.MochiServices.disconnect();
         mochi.MochiServices.onError.apply(null,[errorCode]);
      };
      mochi.MochiServices._loaderListener.onLoadStart = function(target_mc)
      {
         this.isLoading = true;
      };
      mochi.MochiServices._loaderListener.startTime = getTimer();
      mochi.MochiServices._loaderListener.wait = function()
      {
         if(getTimer() - this.startTime > 10000)
         {
            if(!this.isLoading)
            {
               mochi.MochiServices.disconnect();
               mochi.MochiServices.onError.apply(null,["IOError"]);
            }
            clearInterval(this.waitInterval);
         }
      };
      mochi.MochiServices._loaderListener.waitInterval = setInterval(mochi.MochiServices._loaderListener,"wait",1000);
      mochi.MochiServices._loader.addListener(mochi.MochiServices._loaderListener);
      mochi.MochiServices._sendChannel = new LocalConnection();
      mochi.MochiServices._sendChannel._queue = [];
      mochi.MochiServices._rcvChannel = new LocalConnection();
      mochi.MochiServices._rcvChannel.allowDomain = function(d)
      {
         return true;
      };
      mochi.MochiServices._rcvChannel.allowInsecureDomain = mochi.MochiServices._rcvChannel.allowDomain;
      mochi.MochiServices._rcvChannel._nextcallbackID = 0;
      mochi.MochiServices._rcvChannel._callbacks = {};
      mochi.MochiServices.listen();
      return mochi.MochiServices._clip;
   }
   static function onStatus(infoObject)
   {
      var _loc0_ = null;
      if((_loc0_ = infoObject.level) === "error")
      {
         mochi.MochiServices._connected = false;
         mochi.MochiServices._listenChannel.connect(mochi.MochiServices._listenChannelName);
      }
   }
   static function listen()
   {
      mochi.MochiServices._listenChannel = new LocalConnection();
      mochi.MochiServices._listenChannel.handshake = function(args)
      {
         mochi.MochiServices.comChannelName = args.newChannel;
      };
      mochi.MochiServices._listenChannel.allowDomain = function(d)
      {
         return true;
      };
      mochi.MochiServices._listenChannel.allowInsecureDomain = mochi.MochiServices._listenChannel.allowDomain;
      mochi.MochiServices._listenChannel.connect(mochi.MochiServices._listenChannelName);
      trace("Waiting for MochiAds services to connect...");
   }
   static function initComChannels()
   {
      if(!mochi.MochiServices._connected)
      {
         mochi.MochiServices._sendChannel.onStatus = function(infoObject)
         {
            mochi.MochiServices.onStatus(infoObject);
         };
         mochi.MochiServices._sendChannel.send(mochi.MochiServices._sendChannelName,"onReceive",{methodName:"handshakeDone"});
         mochi.MochiServices._sendChannel.send(mochi.MochiServices._sendChannelName,"onReceive",{methodName:"registerGame",id:mochi.MochiServices._id,clip:mochi.MochiServices._clip,version:getVersion()});
         mochi.MochiServices._rcvChannel.onStatus = function(infoObject)
         {
            mochi.MochiServices.onStatus(infoObject);
         };
         mochi.MochiServices._rcvChannel.onReceive = function(pkg)
         {
            var _loc5_ = pkg.callbackID;
            var _loc4_ = this._callbacks[_loc5_];
            if(!_loc4_)
            {
               return undefined;
            }
            var _loc2_ = _loc4_.callbackMethod;
            var _loc3_ = _loc4_.callbackObject;
            if(_loc3_ && typeof _loc2_ == "string")
            {
               _loc2_ = _loc3_[_loc2_];
            }
            if(_loc2_ != undefined)
            {
               _loc2_.apply(_loc3_,pkg.args);
            }
            delete this._callbacks[_loc5_];
         };
         mochi.MochiServices._rcvChannel.onError = function()
         {
            mochi.MochiServices.onError.apply(null,["IOError"]);
         };
         mochi.MochiServices._rcvChannel.connect(mochi.MochiServices._rcvChannelName);
         trace("connected!");
         mochi.MochiServices._connecting = false;
         mochi.MochiServices._connected = true;
         mochi.MochiServices._listenChannel.close();
         while(mochi.MochiServices._sendChannel._queue.length > 0)
         {
            mochi.MochiServices._sendChannel.send(mochi.MochiServices._sendChannelName,"onReceive",mochi.MochiServices._sendChannel._queue.shift());
         }
      }
   }
   static function flush(error)
   {
      var _loc1_ = undefined;
      var _loc2_ = undefined;
      while(mochi.MochiServices._sendChannel._queue.length > 0)
      {
         _loc1_ = mochi.MochiServices._sendChannel._queue.shift();
         false;
         if(_loc1_.callbackID != null)
         {
            _loc2_ = mochi.MochiServices._rcvChannel._callbacks[_loc1_.callbackID];
         }
         delete mochi.MochiServices._rcvChannel._callbacks[_loc1_.callbackID];
         if(error)
         {
            mochi.MochiServices.handleError(_loc1_.args,_loc2_.callbackObject,_loc2_.callbackMethod);
         }
      }
   }
   static function handleError(args, callbackObject, callbackMethod)
   {
      if(args != null)
      {
         if(args.onError != null)
         {
            args.onError.apply(null,["NotConnected"]);
         }
         if(args.options != null && args.options.onError != null)
         {
            args.options.onError.apply(null,["NotConnected"]);
         }
      }
      if(callbackMethod != null)
      {
         args = {};
         args.error = true;
         args.errorCode = "NotConnected";
         if(callbackObject != null && typeof callbackMethod == "string")
         {
            callbackObject[callbackMethod](args);
         }
         else if(callbackMethod != null)
         {
            callbackMethod.apply(args);
         }
      }
   }
   static function send(methodName, args, callbackObject, callbackMethod)
   {
      if(mochi.MochiServices._connected)
      {
         mochi.MochiServices._sendChannel.send(mochi.MochiServices._sendChannelName,"onReceive",{methodName:methodName,args:args,callbackID:mochi.MochiServices._rcvChannel._nextcallbackID});
      }
      else
      {
         if(mochi.MochiServices._clip == undefined || !mochi.MochiServices._connecting)
         {
            mochi.MochiServices.onError.apply(null,["NotConnected"]);
            mochi.MochiServices.handleError(args,callbackObject,callbackMethod);
            mochi.MochiServices.flush(true);
            return undefined;
         }
         mochi.MochiServices._sendChannel._queue.push({methodName:methodName,args:args,callbackID:mochi.MochiServices._rcvChannel._nextcallbackID});
      }
      mochi.MochiServices._rcvChannel._callbacks[mochi.MochiServices._rcvChannel._nextcallbackID] = {callbackObject:callbackObject,callbackMethod:callbackMethod};
      mochi.MochiServices._rcvChannel._nextcallbackID = mochi.MochiServices._rcvChannel._nextcallbackID + 1;
   }
}
