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
	import flash.events.Event;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	
	import mx.core.UIComponent;
	
	/**
	 * A complete event is dispatched when the website has been loaded.
	 */
	[Event(name="complete")]

	/**
	 * OAuthLoader
	 * 
	 * HTMLLoader wrapper class because HTML loader does not implement IUIComponent
	 */
	public class OAuthLoader extends UIComponent
	{
		/**
		 * Constructor
		 */
		public function OAuthLoader()
		{
			super();
		}
		
		/**
		 * @private
		 * HTMLLoader instance
		 */
		private var htmlLoader:HTMLLoader;
		
		/**
		 * Create the HTMLLoader and makes it a child of this UIComponent instance.
		 */
		override protected function createChildren():void
		{
			if(htmlLoader == null)
			{
				htmlLoader = new HTMLLoader();
				htmlLoader.width = 640;
				htmlLoader.height = 480;
				addChild(htmlLoader);
				
				htmlLoader.addEventListener(Event.COMPLETE, completeHandler);
			}
		}
		
		/**
		 * define default width/height
		 */
		override protected function measure():void
		{
			measuredWidth = 640;
			measuredHeight= 480;
		}
		
		/**
		 * resize to fit available space
		 */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			htmlLoader.width = unscaledWidth;
			htmlLoader.height= unscaledHeight;
		}
		
		/**
		 * re-dispatch bubbling event
		 */
		private function completeHandler(event:Event) : void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * 
		 * @param request
		 * 
		 */		
		public function load(request:URLRequest) : void
		{
			if(htmlLoader == null)
				createChildren();
			htmlLoader.load(request);
		}
	}
}