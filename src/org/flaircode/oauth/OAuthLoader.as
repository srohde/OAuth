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