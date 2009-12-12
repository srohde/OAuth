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

package org.flaircode.oauth {
	import org.iotashan.oauth.OAuthToken;
	
	/**
	 * Util class for OAuth specific operations
	 * @author soenkerohde
	 *
	 */
	public class OAuthUtil {
		
		/**
		 *
		 * @param tokenResponse Result from a getRequest/AccessToken call.
		 * @return OAuthToken containing key/secret of the tokenResponse request.
		 *
		 */
		public static function getTokenFromResponse( tokenResponse : String ) : OAuthToken {
			var result:OAuthToken = new OAuthToken();
			
			var params:Array = tokenResponse.split( "&" );
			for each ( var param : String in params ) {
				var paramNameValue:Array = param.split( "=" );
				if ( paramNameValue.length == 2 ) {
					if ( paramNameValue[0] == "oauth_token" ) {
						result.key = paramNameValue[1];
					} else if ( paramNameValue[0] == "oauth_token_secret" ) {
						result.secret = paramNameValue[1];
					}
				}
			}
			
			return result;
		}
	}
}