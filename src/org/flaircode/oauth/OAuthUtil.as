/*
	Copyright 2009 Sönke Rohde
	
	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at
	
	http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/

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