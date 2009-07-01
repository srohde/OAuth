package org.flaircode.oauth
{
	import flash.net.URLRequest;
	
	import mx.rpc.AsyncToken;
	
	import org.iotashan.oauth.OAuthToken;

	/**
	 * OAuth interface
	 * @author soenkerohde
	 * @see org.flairtweet.oauth.OAuth
	 * 
	 */	
	public interface IOAuth
	{
		
		/**
		 * 
		 * @param url for Twitter http://twitter.com/oauth/request_token
		 * @return AsyncToken which will return result typed OAuthToken
		 * @see org.iotashan.oauth.OAuthToken
		 * 
		 */		
		function getRequestToken(url:String):AsyncToken;
		
		/**
		 * 
		 * @param url for Twitter http://twitter.com/oauth/authorize
		 * @param requestTokenKey Key from a previously retrieved request token
		 * @return Can be opened in the browser or with AIR with the HTML control
		 * 
		 */		
		function getAuthorizeRequest(url:String, requestTokenKey:String):URLRequest;
		
		/**
		 * 
		 * @param url for Twitter http://twitter.com/oauth/access_token
		 * @param requestToken previously retrieved request token
		 * @param pin 6 digit number the user has retrieved from the authorize page
		 * @return AsyncToken which will return result typed OAuthToken 
		 * 
		 */		
		function getAccessToken(url:String, requestToken:OAuthToken, pin:int):AsyncToken;
		
		/**
		 * 
		 * @param method GET,POST,UPDATE,DELETE
		 * @param url for Twitter friends timeline and JSON result https://twitter.com/statuses/friends_timeline.json
		 * @param accessToken
		 * @param requestParams
		 * @return
		 * 
		 */		
		function buildRequest(method:String, url:String, accessToken:OAuthToken, requestParams:Object = null):URLRequest;
	}
}