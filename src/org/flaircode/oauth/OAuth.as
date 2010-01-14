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
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.system.Capabilities;
	
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthToken;
	import org.iotashan.utils.OAuthUtil;
	import org.iotashan.utils.URLEncoding;
	
	public class OAuth implements IOAuth {
		
		private var signature:OAuthSignatureMethod_HMAC_SHA1 = new OAuthSignatureMethod_HMAC_SHA1();
		
		private var _consumerKey:String;
		private var _consumerSecret:String;
		private var _consumer:OAuthConsumer;
		
		/**
		 *
		 * @param key Consumer Key
		 *
		 */
		public function set consumerKey( key : String ) : void {
			_consumerKey = key;
		}
		
		/**
		 *
		 * @param secret Consumer Secret
		 *
		 */
		public function set consumerSecret( secret : String ) : void {
			_consumerSecret = secret;
		}
		
		public function get consumer() : OAuthConsumer {
			if ( _consumer == null ) {
				if ( _consumerKey != null && _consumerSecret != null )
					_consumer = new OAuthConsumer( _consumerKey, _consumerSecret );
				else
					throw new Error( "consumerKey/Secret not set." );
			}
			return _consumer;
		}
		
		/**
		 * constructor
		 *
		 */
		public function OAuth( consumerKey : String = null, consumerSecret : String = null ) {
			var forceCompile:OAuthUtil;
			_consumerKey = consumerKey;
			_consumerSecret = consumerSecret;
		}
		
		/**
		 * used to build OAuth authenticated calls
		 *
		 * @param method GET, POST, DELETE, UPDATE
		 * @param url
		 * @param token After authenticatin the accessToken is expected here
		 * @param requestParams
		 * @param removeParamsFromURL
		 * @return
		 *
		 */
		public function buildRequest( method : String, url : String, token : OAuthToken, requestParams : Object = null ) : URLRequest {
			var oauthRequest:OAuthRequest = new OAuthRequest( method, url, requestParams, consumer, token );
			if ( method == "DELETE" && Capabilities.playerType != "Desktop" ) {
				method = URLRequestMethod.POST;
			}
			var request:URLRequest = new URLRequest( oauthRequest.buildRequest( signature, OAuthRequest.RESULT_TYPE_URL_STRING ) );
			request.method = method;
			
			return request;
		}
		
		/**
		 * build the URLRequest for website authorization
		 *
		 * @param requestTokenKey
		 * @return URLRequest for authorize Twitter page
		 *
		 */
		public function getAuthorizeRequest( url : String, requestTokenKey : String ) : URLRequest {
			var req:URLRequest = new URLRequest( url + "?oauth_token=" + requestTokenKey );
			return req;
		}
		
		/**
		 * gets the RequestToken based on the defined consumerKey and consumerSecret
		 *
		 * @param url
		 * @return result is OAuthToken
		 *
		 */
		public function getRequestToken( url : String ) : URLLoader {
			return new URLLoader( getRequestTokenRequest( url ) );
		}
		
		public function getRequestTokenRequest( url : String ) : URLRequest {
			var oauthRequest:OAuthRequest = new OAuthRequest( "GET", url, null, consumer, null );
			var request:URLRequest = new URLRequest( oauthRequest.buildRequest( signature ) );
			return request;
		}
		
		
		/**
		 * gets the AccessToken base on the requestToken
		 *
		 * @param url
		 * @param requestToken
		 * @param requestParams additional parameters like oauth_verifier with pin for Twitter desktop clients
		 * @return
		 *
		 */
		public function getAccessToken( url : String, requestToken : OAuthToken, requestParams : Object ) : URLLoader {
			return new URLLoader( getAccessTokenRequest( url, requestToken, requestParams ) );
		}
		
		public function getAccessTokenRequest( url : String, requestToken : OAuthToken, requestParams : Object ) : URLRequest {
			var request:URLRequest = buildRequest( "GET", url, requestToken, requestParams );
			return request;
		}
	
	}
}