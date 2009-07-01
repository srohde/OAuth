package org.flaircode.oauth
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthToken;

	public class OAuth implements IOAuth
	{
		
		private static const logger:ILogger = Log.getLogger("OAuth");
		
		private var signature:OAuthSignatureMethod_HMAC_SHA1 = new OAuthSignatureMethod_HMAC_SHA1();
		
		private var _consumerKey:String;
		private var _consumerSecret:String;
		private var _consumer:OAuthConsumer;
		
		public function set consumerKey(key:String):void
		{
			_consumerKey = key;
		}
		
		public function set consumerSecret(secret:String):void
		{
			_consumerSecret = secret;
		}
		
		protected function get consumer():OAuthConsumer
		{
			if(_consumer == null)
			{
				if(_consumerKey != null && _consumerSecret != null)
					_consumer = new OAuthConsumer(_consumerKey, _consumerSecret);
				else
					throw new Error("consumerKey/Secret not set.");
			}
			return _consumer;
		}
		
		public function OAuth()
		{
		}
		
		public function buildRequest(method:String, url:String, accessToken:OAuthToken, requestParams:Object = null):URLRequest
		{
			var r:OAuthRequest = new OAuthRequest("GET", url, null, consumer, accessToken);
			var req:URLRequest = new URLRequest(r.buildRequest(signature));
			return req;
		}
		
		/**
		 * build the URLRequest for website authorization
		 * 
		 * @param requestTokenKey
		 * @return URLRequest for authorize Twitter page
		 * 
		 */		
		public function getAuthorizeRequest(url:String, requestTokenKey:String):URLRequest
		{
			var req:URLRequest = new URLRequest(url + "?oauth_token=" + requestTokenKey);
			return req;
		}
		
		/**
		 * gets the RequestToken based on the defined consumerKey and consumerSecret
		 * 
		 * @param url
		 * @return result is OAuthToken
		 * 
		 */		
		public function getRequestToken(url:String):AsyncToken
		{
			var asyncToken:AsyncToken = new AsyncToken();
			
			var r:OAuthRequest = new OAuthRequest("GET", url, null, consumer, null);
			var req:URLRequest = new URLRequest(r.buildRequest(signature));
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, function(e:Event):void
			{
				var result:OAuthToken =  OAuthUtil.getTokenFromResponse(e.currentTarget.data as String);
				var re:ResultEvent = new ResultEvent(ResultEvent.RESULT, false, true, result);
				for each(var responder:IResponder in asyncToken.responders)
				{
					responder.result(re);
				}
				
			});
			
			loader.load(req);
			return asyncToken;
		}
		
		
		
		public function getAccessToken(url:String, requestToken:OAuthToken, pin:int):AsyncToken
		{
			var asyncToken:AsyncToken = new AsyncToken();
			
			var r:OAuthRequest = new OAuthRequest("GET", url, {oauth_verifier:pin}, consumer, requestToken);
			var req:URLRequest = new URLRequest(r.buildRequest(signature));
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, function(e:Event):void
			{
				var result:OAuthToken = OAuthUtil.getTokenFromResponse(e.currentTarget.data as String);
				var re:ResultEvent = new ResultEvent(ResultEvent.RESULT, false, true, result);
				for each(var responder:IResponder in asyncToken.responders)
				{
					responder.result(re);
				}
				
			});
			loader.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void
			{
				for each(var resp:IResponder in asyncToken.responders)
				{
					resp.fault(null);
				}
			});
			loader.load(req);
			
			return asyncToken;
		}
		
	}
}