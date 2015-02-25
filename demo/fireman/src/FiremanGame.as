package
{
	import starling.display.Sprite;

	import com.catalystapps.gaf.core.ZipToGAFAssetConverter;
	import com.catalystapps.gaf.data.GAFTimeline;
	import com.catalystapps.gaf.display.GAFMovieClip;

	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	/**
	 * @author mitvad
	 */
	public class FiremanGame extends Sprite
	{
		public function FiremanGame()
		{
			this.loadZip();
		}
		
		private function loadZip(): void
		{
			var request: URLRequest = new URLRequest("assets/fireman/fireman.zip");
			var urlLoader: URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE, this.onLoaded);
			urlLoader.load(request);
		}

		private function onLoaded(event: Event): void
		{
			var zip: ByteArray = (event.target as URLLoader).data;
			
			var converter: ZipToGAFAssetConverter = new ZipToGAFAssetConverter();
			converter.addEventListener(Event.COMPLETE, this.onConverted);
			converter.addEventListener(ErrorEvent.ERROR, this.onError);
			converter.convert(zip);
		}

		private function onConverted(event: Event): void
		{
			var timeline: GAFTimeline = (event.target as ZipToGAFAssetConverter).gafTimeline;
			var mc: GAFMovieClip = new GAFMovieClip(timeline);
			
			this.addChild(mc);
			mc.y = -mc.height / 2 - 100;
			mc.play();
		}
		
		private function onError(event: ErrorEvent): void
		{
			trace(event);
		}
	}
}
