package org.flaircode.oauth
{
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import org.iotashan.oauth.OAuthToken;

	/**
	 * Util class for OAuth specific operations
	 * @author soenkerohde
	 * 
	 */	
	public class OAuthUtil
	{
		
		private static const logger:ILogger = Log.getLogger("org.flairtweet.oauth.OAuthUtil");
		
		/**
		 * 
		 * @param tokenResponse Result from a getRequest/AccessToken call.
		 * @return OAuthToken containing key/secret of the tokenResponse request.
		 * 
		 */		
		public static function getTokenFromResponse(tokenResponse:String):OAuthToken
		{
			logger.info("getTokenFromResponse " + tokenResponse);
			var result:OAuthToken = new OAuthToken();
			
			var params:Array = tokenResponse.split("&");
			for each(var param:String in params)
			{
				var a:Array = param.split("=");
				if(a.length == 2)
				{
					switch(a[0])
					{
						case "oauth_token":
							result.key = a[1];
							logger.debug("Key: " + result.key);
							break;
						case "oauth_token_secret":
							result.secret = a[1];
							logger.debug("Secret: " + result.secret);
							break;
					}
				}
			}
			
			return result;
		}
	}
}