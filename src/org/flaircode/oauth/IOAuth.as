package org.flaircode.oauth
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.iotashan.oauth.OAuthToken;

	/**
	 * OAuth interface
	 * @author soenkerohde
	 * @see org.flaircode.oauth.OAuth
	 * 
	 */	
	public interface IOAuth
	{
		
		/**
		 * 
		 * @param key Consumer Key
		 * 
		 */		
		function set consumerKey(key:String):void;
		
		/**
		 * 
		 * @param secret Consumer secret
		 * 
		 */		
		function set consumerSecret(secret:String):void
		
		/**
		 * 
		 * @param url for Twitter http://twitter.com/oauth/request_token
		 * @return URLLoader. Listen for Event.COMPLETE and transform result to OAuthToken with OAuthUtil.getTokenFromResponse(event.currentTarget.data as String);
		 * @see org.iotashan.oauth.OAuthToken
		 * 
		 */		
		function getRequestToken(url:String):URLLoader;
		
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
		 * @param requestParams additional parameters like oauth_verifier with pin for Twitter desktop clients
		 * @return URLLoader. Listen for Event.COMPLETE and transform result to OAuthToken with OAuthUtil.getTokenFromResponse(event.currentTarget.data as String); 
		 * 
		 */		
		function getAccessToken(url:String, requestToken:OAuthToken, requestParams:Object):URLLoader;
		
		/**
		 * 
		 * @param method GET,POST,UPDATE,DELETE
		 * @param url for Twitter friends timeline and JSON result https://twitter.com/statuses/friends_timeline.json
		 * @param token
		 * @param requestParams
		 * @return
		 * 
		 */		
		function buildRequest(method:String, url:String, token:OAuthToken, requestParams:Object = null):URLRequest;
	}
}